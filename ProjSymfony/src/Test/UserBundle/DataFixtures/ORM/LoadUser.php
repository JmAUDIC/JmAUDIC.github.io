<?php
// src/Test/UserBundle/DataFixtures/ORM/LoadUser.php

namespace Test\UserBundle\DataFixtures\ORM;

use Doctrine\Common\DataFixtures\FixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Test\UserBundle\Entity\User;

class LoadUser implements FixtureInterface
{
  public function load(ObjectManager $manager)
  {
    // Les noms d'utilisateurs à créer
    $listNames = array('Admin');

    foreach ($listNames as $name) {
      // On crée l'utilisateur
      $user = new User;

      // Le nom d'utilisateur et le mot de passe sont identiques pour l'instant
      $user->setUsername($name);
      $user->setEmail($name . "@test.fr");
      $user->setPlainPassword($name);
      $user->setNom($name);
      $user->setPrenom($name);
      $user->setTelephone(025122222);

      // On ne se sert pas du sel pour l'instant
      // On définit uniquement le role ROLE_USER qui est le role de base
      $user->setRoles(array('ROLE_ADMIN'));

      // On le persiste
      $manager->persist($user);
    }

    // On déclenche l'enregistrement
    $manager->flush();
  }
}
