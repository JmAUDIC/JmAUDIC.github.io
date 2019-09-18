<?php

namespace Test\PlatformBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
  public function indexAction()
  {
    return $this->render('TestPlatformBundle:Default:index.html.twig');
  }
}
