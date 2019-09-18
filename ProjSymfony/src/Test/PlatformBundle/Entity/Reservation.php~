<?php

namespace Test\PlatformBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Reservation
 *
 * @ORM\Table(name="reservation")
 * @ORM\Entity(repositoryClass="Test\PlatformBundle\Repository\ReservationRepository")
 */
class Reservation
{
     /**
     * @ORM\ManyToOne(targetEntity="Test\PlatformBundle\Entity\Trajet")
     */
       private $trajet;


    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="date_reservation", type="datetime")
     */
    private $dateReservation;


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
     * Set dateReservation
     *
     * @param \DateTime $dateReservation
     *
     * @return Reservation
     */
    public function setDateReservation($dateReservation)
    {
        $this->dateReservation = $dateReservation;

        return $this;
    }

    /**
     * Get dateReservation
     *
     * @return \DateTime
     */
    public function getDateReservation()
    {
        return $this->dateReservation;
    }

    /**
     * Set trajet
     *
     * @param \Test\PlatformBundle\Entity\Trajet $trajet
     *
     * @return Reservation
     */
    public function setTrajet(\Test\PlatformBundle\Entity\Trajet $trajet)
    {
        $this->trajet = $trajet;

        return $this;
    }

    /**
     * Get trajet
     *
     * @return \Test\PlatformBundle\Entity\Trajet
     */
    public function getTrajet()
    {
        return $this->trajet;
    }
}
