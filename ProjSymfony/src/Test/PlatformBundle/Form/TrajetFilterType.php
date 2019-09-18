<?php

namespace Test\PlatformBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

use Lexik\Bundle\FormFilterBundle\Filter\Form\Type as Filters;


class TrajetFilterType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('id', Filters\NumberFilterType::class)
            ->add('lieuDepart', Filters\TextFilterType::class)
            ->add('lieuArrive', Filters\TextFilterType::class)
            ->add('dateDepart', Filters\DateTimeFilterType::class)
            ->add('dateArrive', Filters\DateTimeFilterType::class)
            ->add('prix', Filters\NumberFilterType::class)
            ->add('descriptionTrajet', Filters\TextFilterType::class)
            ->add('nbPlace', Filters\NumberFilterType::class)
            ->add('voiture', Filters\NumberFilterType::class)
            ->add('conducteur', Filters\EntityFilterType::class, array(
                    'class' => 'Test\UserBundle\Entity\User',
                    'choice_label' => 'nom',
            ))
        ;
        $builder->setMethod("GET");


    }

    public function getBlockPrefix()
    {
        return null;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'allow_extra_fields' => true,
            'csrf_protection' => false,
            'validation_groups' => array('filtering') // avoid NotBlank() constraint-related message
        ));
    }
}
