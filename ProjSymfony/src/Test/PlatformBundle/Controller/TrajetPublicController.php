<?php

namespace Test\PlatformBundle\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

use Pagerfanta\Pagerfanta;
use Pagerfanta\Adapter\DoctrineORMAdapter;
use Pagerfanta\View\TwitterBootstrap3View;

use Test\PlatformBundle\Entity\Trajet;
use Test\PlatformBundle\Entity\Reservation;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

/**
 * Trajet controller.
 *
 */
class TrajetPublicController extends Controller
{
    /**
     * Lists all Trajet entities.
     *
     */
    public function indexAction(Request $request)
    {
        $em = $this->getDoctrine()->getManager();
        $queryBuilder = $em->getRepository('TestPlatformBundle:Trajet')->createQueryBuilder('e');

        list($filterForm, $queryBuilder) = $this->filter($queryBuilder, $request);
        list($trajets, $pagerHtml) = $this->paginator($queryBuilder, $request);

        return $this->render('trajet/index.html.twig', array(
            'trajets' => $trajets,
            'pagerHtml' => $pagerHtml,
            'filterForm' => $filterForm->createView(),
            'list_user' => $this->listIdUserReservation(),
        ));
    }

    /**
     * Lists trajets du conducteur de l'utilsiateur
     * @Security("has_role('ROLE_USER')")
     */
    public function indexconducteurAction(Request $request)
    {
        $em = $this->getDoctrine()->getManager();
        $queryBuilder = $em->getRepository('TestPlatformBundle:Trajet')->createQueryBuilder('e');

        $user = $this->getUser();
        $list_t = array();
        list($filterForm, $queryBuilder) = $this->filter($queryBuilder, $request);
        list($list_trajet, $pagerHtml) = $this->paginator($queryBuilder, $request);


        foreach ($list_trajet as $tr) {
          $driver = $tr->getConducteur();
          if($driver == $user)
          {
            array_push($list_t,$tr);
          }
        }

        return $this->render('trajet/index_conducteur.html.twig', array(
            'trajets' => $list_t,
            'pagerHtml' => $pagerHtml,
            'filterForm' => $filterForm->createView(),
            'list_user' => $this->listIdUserReservation(),
        ));
    }

    /**
     * Lists trajets du conducteur de l'utilsiateur
     * @Security("has_role('ROLE_USER')")
     */
    public function indexreservationAction(Request $request)
    {
        $em = $this->getDoctrine()->getManager();
        $queryBuilder = $em->getRepository('TestPlatformBundle:Trajet')->createQueryBuilder('e');

        $user = $this->getUser();

        list($filterForm, $queryBuilder) = $this->filter($queryBuilder, $request);
        list($list_trajet, $pagerHtml) = $this->paginator($queryBuilder, $request);

        $list_trajet = array();

        $reservation = $user->getReservations();
        foreach ($reservation as $reser) {
          $traj = $reser->getTrajet();
          array_push($list_trajet,$traj);
        }

        return $this->render('trajet/index_reservation.html.twig', array(
            'trajets' => $list_trajet,
            'pagerHtml' => $pagerHtml,
            'filterForm' => $filterForm->createView(),
            'list_user' => $this->listIdUserReservation(),
        ));
    }

    /**
    * Create filter form and process filter request.
    *
    */
    protected function filter($queryBuilder, Request $request)
    {
        $session = $request->getSession();
        $filterForm = $this->createForm('Test\PlatformBundle\Form\TrajetFilterType');

        // Reset filter
        if ($request->get('filter_action') == 'reset') {
            $session->remove('TrajetControllerFilter');
        }

        // Filter action
        if ($request->get('filter_action') == 'filter') {
            // Bind values from the request
            $filterForm->handleRequest($request);

            if ($filterForm->isValid()) {
                // Build the query from the given form object
                $this->get('lexik_form_filter.query_builder_updater')->addFilterConditions($filterForm, $queryBuilder);
                // Save filter to session
                $filterData = $filterForm->getData();
                $session->set('TrajetControllerFilter', $filterData);
            }
        } else {
            // Get filter from session
            if ($session->has('TrajetControllerFilter')) {
                $filterData = $session->get('TrajetControllerFilter');

                foreach ($filterData as $key => $filter) { //fix for entityFilterType that is loaded from session
                    if (is_object($filter)) {
                        $filterData[$key] = $queryBuilder->getEntityManager()->merge($filter);
                    }
                }

                $filterForm = $this->createForm('Test\PlatformBundle\Form\TrajetFilterType', $filterData);
                $this->get('lexik_form_filter.query_builder_updater')->addFilterConditions($filterForm, $queryBuilder);
            }
        }

        return array($filterForm, $queryBuilder);
    }


    /**
    * Get results from paginator and get paginator view.
    *
    */
    protected function paginator($queryBuilder, Request $request)
    {
        //sorting
        $sortCol = $queryBuilder->getRootAlias().'.'.$request->get('pcg_sort_col', 'id');
        $queryBuilder->orderBy($sortCol, $request->get('pcg_sort_order', 'desc'));
        // Paginator
        $adapter = new DoctrineORMAdapter($queryBuilder);
        $pagerfanta = new Pagerfanta($adapter);
        $pagerfanta->setMaxPerPage($request->get('pcg_show' , 10));

        try {
            $pagerfanta->setCurrentPage($request->get('pcg_page', 1));
        } catch (\Pagerfanta\Exception\OutOfRangeCurrentPageException $ex) {
            $pagerfanta->setCurrentPage(1);
        }

        $entities = $pagerfanta->getCurrentPageResults();

        // Paginator - route generator
        $me = $this;
        $routeGenerator = function($page) use ($me, $request)
        {
            $requestParams = $request->query->all();
            $requestParams['pcg_page'] = $page;
            return $me->generateUrl('trajets', $requestParams);
        };

        // Paginator - view
        $view = new TwitterBootstrap3View();
        $pagerHtml = $view->render($pagerfanta, $routeGenerator, array(
            'proximity' => 3,
            'prev_message' => 'previous',
            'next_message' => 'next',
        ));

        return array($entities, $pagerHtml);
    }

    public function listIdUserReservation()
    {
      $array_user = array();
      $listUsers = $this
        ->getDoctrine()
        ->getManager()
        ->getRepository('TestUserBundle:User')
        ->getReservations()
      ;

      foreach ($listUsers as $user) {
        $user->getReservations();
        array_push($array_user,$user);
      }
      return $array_user;
    }

    /**
     * Displays a form to create a new Trajet entity.
     *
    * @Security("has_role('ROLE_USER')")
    */
    public function newAction(Request $request)
    {

        $trajet = new Trajet();
        $form   = $this->createForm('Test\PlatformBundle\Form\TrajetType', $trajet);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($trajet);
            $em->flush();

            $editLink = $this->generateUrl('trajets_edit', array('id' => $trajet->getId()));
            $this->get('session')->getFlashBag()->add('success', "<a href='$editLink'>New trajet was created successfully.</a>" );

            $nextAction=  $request->get('submit') == 'save' ? 'trajets' : 'trajets_new';
            return $this->redirectToRoute($nextAction);
        }
        return $this->render('trajet/new.html.twig', array(
            'trajet' => $trajet,
            'form'   => $form->createView(),
        ));
    }

    /**
     * Displays a form to create a new Trajet entity.
     *
    * @Security("has_role('ROLE_USER')")
    */
    public function newpublicAction(Request $request)
    {

        $trajet = new Trajet();
        $user = $this->getUser();
        $form = $this->createForm('Test\PlatformBundle\Form\TrajetType',$trajet);
        $form->get('conducteur')->setData($user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($trajet);
            $em->flush();

            $editLink = $this->generateUrl('trajets_edit', array('id' => $trajet->getId()));
            $this->get('session')->getFlashBag()->add('success', "<a href='$editLink'>New trajet was created successfully.</a>" );

            $nextAction=  $request->get('submit') == 'save' ? 'trajets' : 'trajets_new';
            return $this->redirectToRoute($nextAction);
        }
        return $this->render('trajet/new.html.twig', array(
            'trajet' => $trajet,
            'form'   => $form->createView(),
        ));
    }

    /**
     * Finds and displays a Trajet entity.
     * @Security("has_role('ROLE_USER')")
     *
     */
    public function addAction(Trajet $trajet)
    {
      $user = $this->getUser();
      $annonceUser = $trajet->getConducteur();

        $deleteForm = $this->createDeleteForm($trajet);
        if($user == $annonceUser)
        {
          return $this->redirectToRoute('trajets');
        }
        else {
          $reservation = new Reservation();
          $reservation->setTrajet($trajet);
          $reservation->setDateReservation(new \DateTime('now'));

          $user->addReservation($reservation);

          $em = $this->getDoctrine()->getManager();
          $em->persist($reservation);
          $em->persist($user);
          $em->flush();

          return $this->redirectToRoute('trajets');
        }
    }

    /**
     * Finds and displays a Trajet entity.
     * @Security("has_role('ROLE_USER')")
     *
     */
    public function removeAction($id)
    {
      $user = $this->getUser();

      $em = $this->getDoctrine()->getManager();
      $repository = $em->getRepository('TestPlatformBundle:Reservation');

      $reservation = $repository->find($id);

      $user->removeReservation($reservation);
      $em->remove($reservation);
      $em->persist($user);
      $em->flush();

      return $this->redirectToRoute('trajets');

    }

    /**
     * Finds and displays a Trajet entity.
     *
     */
    public function showAction(Trajet $trajet)
    {
      $user = $this->getUser();
      $annonceUser = $trajet->getConducteur();

        $deleteForm = $this->createDeleteForm($trajet);
        if($user == $annonceUser)
        {
          return $this->render('trajet/show.html.twig', array(
              'trajet' => $trajet,
              'delete_form' => $deleteForm->createView(),
              'list_user' => $this->listIdUserReservation(),

          ));
        }
        else {
          return $this->render('trajet/show.html.twig', array(
              'trajet' => $trajet,
              'list_user' => $this->listIdUserReservation(),
          ));
        }
    }



    /**
     * Displays a form to edit an existing Trajet entity.
     *
     * @Security("has_role('ROLE_USER')")
     */
    public function editAction(Request $request, Trajet $trajet)
    {
        $user = $this->getUser();
        $annonceUser = $trajet->getConducteur();
        if($user == $annonceUser)
        {
          $deleteForm = $this->createDeleteForm($trajet);
          $editForm = $this->createForm('Test\PlatformBundle\Form\TrajetType', $trajet);
          $editForm->handleRequest($request);

          if ($editForm->isSubmitted() && $editForm->isValid()) {
              $em = $this->getDoctrine()->getManager();
              $em->persist($trajet);
              $em->flush();

              $this->get('session')->getFlashBag()->add('success', 'Edited Successfully!');
              return $this->redirectToRoute('trajets_edit', array('id' => $trajet->getId()));
          }
          return $this->render('trajet/edit.html.twig', array(
              'trajet' => $trajet,
              'edit_form' => $editForm->createView(),
              'delete_form' => $deleteForm->createView(),
          ));
        }
    }



    /**
     * Deletes a Trajet entity.
     * @Security("has_role('ROLE_USER')")
     *
     */
    public function deleteAction(Request $request, Trajet $trajet)
    {
      $user = $this->getUser();
      $annonceUser = $trajet->getConducteur();
      if($user == $annonceUser)
      {
        $form = $this->createDeleteForm($trajet);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($trajet);
            $em->flush();
            $this->get('session')->getFlashBag()->add('success', 'The Trajet was deleted successfully');
        } else {
            $this->get('session')->getFlashBag()->add('error', 'Problem with deletion of the Trajet');
        }

        return $this->redirectToRoute('trajets');
      }
    }

    /**
     * Creates a form to delete a Trajet entity.
     * @Security("has_role('ROLE_USER')")
     *
     * @param Trajet $trajet The Trajet entity
     *
     * @return \Symfony\Component\Form\Form The form
     */
    private function createDeleteForm(Trajet $trajet)
    {
      $user = $this->getUser();
      $annonceUser = $trajet->getConducteur();
      if($user == $annonceUser)
      {
        return $this->createFormBuilder()
            ->setAction($this->generateUrl('trajets_delete', array('id' => $trajet->getId())))
            ->setMethod('DELETE')
            ->getForm()
        ;
      }
    }

    /**
     * Delete Trajet by id
     * @Security("has_role('ROLE_USER')")
     *
     */
    public function deleteByIdAction(Trajet $trajet){
      $user = $this->getUser();
      $annonceUser = $trajet->getConducteur();
      if($user == $annonceUser)
      {
        $em = $this->getDoctrine()->getManager();

        try {
            $em->remove($trajet);
            $em->flush();
            $this->get('session')->getFlashBag()->add('success', 'The Trajet was deleted successfully');
        } catch (Exception $ex) {
            $this->get('session')->getFlashBag()->add('error', 'Problem with deletion of the Trajet');
        }

        return $this->redirect($this->generateUrl('trajets'));
      }
    }


    /**
    * Bulk Action
    * @Security("has_role('ROLE_USER')")
    */
    public function bulkAction(Request $request)
    {
        $ids = $request->get("ids", array());
        $action = $request->get("bulk_action", "delete");

        if ($action == "delete") {
            try {
                $em = $this->getDoctrine()->getManager();
                $repository = $em->getRepository('TestPlatformBundle:Trajet');

                foreach ($ids as $id) {
                    $trajet = $repository->find($id);
                    $em->remove($trajet);
                    $em->flush();
                }

                $this->get('session')->getFlashBag()->add('success', 'trajets was deleted successfully!');

            } catch (Exception $ex) {
                $this->get('session')->getFlashBag()->add('error', 'Problem with deletion of the trajets ');
            }
        }

        return $this->redirect($this->generateUrl('trajets'));
    }


}
