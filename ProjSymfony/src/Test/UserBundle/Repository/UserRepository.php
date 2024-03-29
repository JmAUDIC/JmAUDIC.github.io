<?php

namespace Test\UserBundle\Repository;

/**
 * UserRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class UserRepository extends \Doctrine\ORM\EntityRepository
{
  public function getReservations()
  {
    $qb = $this
      ->createQueryBuilder('r')
      ->leftJoin('r.reservations', 'reserv')
      ->addSelect('reserv')
    ;

    return $qb
      ->getQuery()
      ->getResult()
    ;
  }
}
