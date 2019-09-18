<?php

namespace Test\PlatformBundle\Controller;

use Symfony\Component\HttpFoundation\Cookie;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

class ThemeController extends Controller
{
  public function themeAction()
  {
    $request = Request::createFromGlobals();
    $response = new Response();
    if( $request->cookies->get('theme') === null)
    {
      $cookie = new Cookie('theme', 'black');
      $response->headers->setCookie($cookie);
      $response->send();
    }
    else {
      $response->headers->clearCookie('theme');
      $response->send();
    }
      return $this->redirectToRoute('test_platform_homepage');
  }
}
