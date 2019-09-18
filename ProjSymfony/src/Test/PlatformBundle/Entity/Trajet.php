<?php

namespace Test\PlatformBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Trajet
 *
 * @ORM\Table(name="trajet")
 * @ORM\Entity(repositoryClass="Test\PlatformBundle\Repository\TrajetRepository")
 */
class Trajet
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(name="voiture", type="string", length=255)
     */
    private $voiture;

    /**
     * @var string
     *
     * @ORM\Column(name="lieu_depart", type="string", length=255)
     */
    private $lieuDepart;

    /**
     * @var string
     *
     * @ORM\Column(name="lieu_arrive", type="string", length=255)
     */
    private $lieuArrive;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="date_depart", type="datetime")
     */
    private $dateDepart;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="date_arrive", type="datetime")
     */
    private $dateArrive;

    /**
     * @var float
     *
     * @ORM\Column(name="prix", type="float")
     */
    private $prix;

    /**
     * @var string
     *
     * @ORM\Column(name="description_trajet", type="text")
     */
    private $descriptionTrajet;

    /**
     * @var int
     *
     * @ORM\Column(name="nb_place", type="integer")
     */
    private $nbPlace;

    /**
     * @ORM\ManyToOne(targetEntity="Test\UserBundle\Entity\User")
     * @ORM\JoinColumn(nullable=false)
     */
     private $conducteur;


    /**
     * Get id
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set lieuDepart
     *
     * @param string $voiture
     *
     * @return Trajet
     */
    public function setVoiture($voirure)
    {
        $this->voiture = $voirure;

        return $this;
    }

    /**
     * Get voiture
     *
     * @return string
     */
    public function getVoiture()
    {
        return $this->voiture;
    }

    /**
     * Set lieuDepart
     *
     * @param string $lieuDepart
     *
     * @return Trajet
     */
    public function setLieuDepart($lieuDepart)
    {
        $this->lieuDepart = $lieuDepart;

        return $this;
    }

    /**
     * Get lieuDepart
     *
     * @return string
     */
    public function getLieuDepart()
    {
        return $this->lieuDepart;
    }

    /**
     * Set lieuArrive
     *
     * @param string $lieuArrive
     *
     * @return Trajet
     */
    public function setLieuArrive($lieuArrive)
    {
        $this->lieuArrive = $lieuArrive;

        return $this;
    }

    /**
     * Get lieuArrive
     *
     * @return string
     */
    public function getLieuArrive()
    {
        return $this->lieuArrive;
    }

    /**
     * Set dateDepart
     *
     * @param \DateTime $dateDepart
     *
     * @return Trajet
     */
    public function setDateDepart($dateDepart)
    {
        $this->dateDepart = $dateDepart;

        return $this;
    }

    /**
     * Get dateDepart
     *
     * @return \DateTime
     */
    public function getDateDepart()
    {
        return $this->dateDepart;
    }

    /**
     * Set dateArrive
     *
     * @param \DateTime $dateArrive
     *
     * @return Trajet
     */
    public function setDateArrive($dateArrive)
    {
        $this->dateArrive = $dateArrive;

        return $this;
    }

    /**
     * Get dateArrive
     *
     * @return \DateTime
     */
    public function getDateArrive()
    {
        return $this->dateArrive;
    }

    /**
     * Set prix
     *
     * @param float $prix
     *
     * @return Trajet
     */
    public function setPrix($prix)
    {
        $this->prix = $prix;

        return $this;
    }

    /**
     * Get prix
     *
     * @return float
     */
    public function getPrix()
    {
        return $this->prix;
    }

    /**
     * Set descriptionTrajet
     *
     * @param string $descriptionTrajet
     *
     * @return Trajet
     */
    public function setDescriptionTrajet($descriptionTrajet)
    {
        $this->descriptionTrajet = $descriptionTrajet;

        return $this;
    }

    /**
     * Get descriptionTrajet
     *
     * @return string
     */
    public function getDescriptionTrajet()
    {
        return $this->descriptionTrajet;
    }

    /**
     * Set nbPlace
     *
     * @param integer $nbPlace
     *
     * @return Trajet
     */
    public function setNbPlace($nbPlace)
    {
        $this->nbPlace = $nbPlace;

        return $this;
    }

    /**
     * Get nbPlace
     *
     * @return int
     */
    public function getNbPlace()
    {
        return $this->nbPlace;
    }

    /**
     * Set conducteur
     *
     * @param \Test\UserBundle\Entity\User $conducteur
     *
     * @return Trajet
     */
    public function setConducteur(\Test\UserBundle\Entity\User $conducteur)
    {
        $this->conducteur = $conducteur;

        return $this;
    }

    /**
     * Get conducteur
     *
     * @return \Test\UserBundle\Entity\User
     */
    public function getConducteur()
    {
        return $this->conducteur;
    }
}
