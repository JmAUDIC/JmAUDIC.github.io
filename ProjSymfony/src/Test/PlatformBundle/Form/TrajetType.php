<?php

namespace Test\PlatformBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;

class TrajetType extends AbstractType
{
    /**
     * @param FormBuilderInterface $builder
     * @param array $options
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('lieuDepart')
            ->add('lieuArrive')
            ->add('dateDepart')
            ->add('dateArrive')
            ->add('prix')
            ->add('descriptionTrajet')
            ->add('nbPlace')
            ->add('voiture')
            ->add('conducteur', EntityType::class, array(
                'class' => 'Test\UserBundle\Entity\User',
                'choice_label' => 'nom',
                'placeholder' => 'Please choose',
                'empty_data' => null,
                'required' => false

            ))
        ;
    }

    /**
     * @param OptionsResolver $resolver
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Test\PlatformBundle\Entity\Trajet'
        ));
    }
}
