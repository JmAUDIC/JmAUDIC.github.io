<?php

namespace Test\UserBundle\Entity;

// src/Test/UserBundle/Entity/User.php
use Doctrine\ORM\Mapping as ORM;
use FOS\UserBundle\Model\User as BaseUser;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ORM\Entity(repositoryClass="Test\UserBundle\Repository\UserRepository")
 * @ORM\Table(name="user")
 */
class User extends BaseUser
{
    /**
   * @ORM\ManyToMany(targetEntity="Test\PlatformBundle\Entity\Reservation", cascade={"persist", "remove"})
   * @ORM\JoinColumn(nullable=false)
   */
    private $reservations;

    /**
   * @ORM\Column(name="id", type="integer")
   * @ORM\Id
   * @ORM\GeneratedValue(strategy="AUTO")
   */
    protected $id;

    /**
   * @ORM\Column(name="nom", type="string", length=255)
   * @Assert\NotBlank(message="Please enter your name.", groups={"Registration", "Profile"})
   * @Assert\Length(
   *     min=3,
   *     max=255,
   *     minMessage="The name is too short.",
   *     maxMessage="The name is too long.",
   *     groups={"Registration", "Profile"}
   * )
   */
    protected $nom;

    /**
   * @ORM\Column(name="prenom", type="string", length=255)
   */
    protected $prenom;

    /**
   * @ORM\Column(name="telephone", type="string", length=255)
   */
    protected $telephone;

    public function eraseCredentials()
    {

    }

    public function setEmail($email)
    {
        $email = is_null($email) ? '' : $email;
        parent::setEmail($email);
        $this->setUsername($email);

        return $this;
    }


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
     * Set nom
     *
     * @param string $nom
     *
     * @return User
     */
    public function setNom($nom)
    {
        $this->nom = $nom;

        return $this;
    }

    /**
     * Get nom
     *
     * @return string
     */
    public function getNom()
    {
        return $this->nom;
    }

    /**
     * Set prenom
     *
     * @param string $prenom
     *
     * @return User
     */
    public function setPrenom($prenom)
    {
        $this->prenom = $prenom;

        return $this;
    }

    /**
     * Get prenom
     *
     * @return string
     */
    public function getPrenom()
    {
        return $this->prenom;
    }

    /**
     * Set telephone
     *
     * @param string $telephone
     *
     * @return User
     */
    public function setTelephone($telephone)
    {
        $this->telephone = $telephone;

        return $this;
    }

    /**
     * Get telephone
     *
     * @return string
     */
    public function getTelephone()
    {
        return $this->telephone;
    }

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Set trajet
     *
     * @param \Test\PlatformBundle\Entity\Trajet $trajet
     *
     * @return User
     */
    public function setTrajet(\Test\PlatformBundle\Entity\Trajet $trajet = null)
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

    /**
     * Add reservation
     *
     * @param \Test\PlatformBundle\Entity\Reservation $reservation
     *
     * @return User
     */
    public function addReservation(\Test\PlatformBundle\Entity\Reservation $reservation)
    {
        $this->reservations[] = $reservation;

        return $this;
    }

    /**
     * Remove reservation
     *
     * @param \Test\PlatformBundle\Entity\Reservation $reservation
     */
    public function removeReservation(\Test\PlatformBundle\Entity\Reservation $reservation)
    {
        $this->reservations->removeElement($reservation);
    }

    /**
     * Get reservations
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getReservations()
    {
        return $this->reservations;
    }
}
