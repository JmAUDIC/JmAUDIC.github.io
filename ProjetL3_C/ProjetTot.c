//Priscilla Bouron
//Pierre Gaudicheau
//Jean-Marie Audic

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>


//////////////// Création des enregistrements ///////////////////////


typedef struct TCarte{
	char nom[25];	//Nom de la carte
	char effet[150]; // Effet de la carte
	int  id;		//Type de carte
	int numj;		//numéro du joueur : 0 si pioche, 1 pour joueur 1, etc
    int pos;        //position de la carte
} TCarte;

typedef struct TJoueur{
	char nom[20];	//Nom du joueur
	int  numj;		//Numéro du joueur
	int points;		//Points totaux
	TCarte totem[6]; //Totem du joueur
	//TCarte main[10]; //main du joueur
} TJoueur;

//Création structure Carte
struct TCarte Carte[60];

//Création structure joueurs
TJoueur J1;
TJoueur J2;
TJoueur J3;



// Procédures générales
void creerCarte();    //Création des 59 cartes
void afficherCarte();
void randCarte();
int bornes(int, int);
void creaJoueur(TJoueur * , int );
void afficherJoueur(TJoueur);
void afficherCarteJoueur(int );
void defCarte(int);
void piocherCarte(int*,int);
void initialisationTotem(TJoueur *j);
void afficherTotem(TJoueur j);
void ajoutTotem(TJoueur *j, int posi);
void supprimerHautTotem(TJoueur *j);
void volerHautTotem(TJoueur *jvole,TJoueur *jvoleur);
int compterTotem(TJoueur j);
int choix_joueur();
int DernierEtage(TJoueur j);
void jouerCarte(int idCarte, int posCarte,TJoueur *joueurCarte,TJoueur *joueurSuiv,TJoueur *joueurApSuiv, int *prem);
void unTour(TJoueur *joueurActuel,TJoueur *joueurSuiv,TJoueur *joueurApSuiv, int numjAct,int * prem);
//////////////// MAIN :Création des cartes ///////////////////////

//Cartes Tête de totem
void creerCarte(){

    int i=0;

    //Cartes totems

	for (i=0;i<5; i++)
	{   strcpy(Carte[i].nom , "***TETE DE COYOTE*** ");
		strcpy(Carte[i].effet, "**Effet : Lorsque Tete de Coyote arrive en jeu, vous echangez le totem d'un joueur avec le votre** ");
		Carte[i].id=1;

	}

	for (i=5;i<10; i++)
	{ strcpy(Carte[i].nom , "***TETE D'AIGLE*** ");
		strcpy(Carte[i].effet, "**Effet : Aucun joueur ne peut vous voler vote totem ou des etages de votre totem** ");
		Carte[i].id=2;

	}

	for (i=10;i<15; i++)
	{ strcpy(Carte[i].nom , "***TETE DE LOUP*** ");
		strcpy(Carte[i].effet, "**Effet : Lorsque Tete de Loup arrive en jeu, vous pouvez voler 2 cartes au hasard dans la main d'un joueur adverse** ");
		Carte[i].id=3;

	}

	for (i=15;i<20; i++)
	{ strcpy(Carte[i].nom , "***TETE DE CORBEAU*** ");
		strcpy(Carte[i].effet, "**Effet : Lorsque Tete de Corbeau arrive en jeu, vous pouvez echanger votre main avec celle d'un autre joueur** ");
		Carte[i].id=4;

	}

	for (i=20;i<25; i++)
	{ strcpy(Carte[i].nom , "***TETE DE LYNX*** ");
		strcpy(Carte[i].effet, "**Effet : A la fin de chacun de vos tours, vous pouvez piocher 3 cartes en choisir une puis defausser les 2 autres** ");
		Carte[i].id=5;

	}

	for (i=25;i<30; i++)
	{ strcpy(Carte[i].nom , "***TETE DE TORTUE*** ");
		strcpy(Carte[i].effet, "**Effet : Aucun joueur ne peut detruire votre totem ou des etages de vote totem** ");
		Carte[i].id=6;

	}

	for (i=30;i<35; i++)
	{ strcpy(Carte[i].nom , "***TETE D'OURS*** ");
		strcpy(Carte[i].effet, "**Effet : Lorsque Tete d'ours arrive en jeu, vous pouvez detruire le dernier etage du totem d'un joueur** ");
		Carte[i].id=7;

	}

	//Cartes Coup Bas

	for (i=35;i<38; i++)
	{ strcpy(Carte[i].nom , "***ESPRIT FARCEUR*** ");
		strcpy(Carte[i].effet, "**Effet : Chaque joueur doit donner son totem au joueur se trouvant a sa gauche.** ");
		Carte[i].id=8;

	}

	for (i=38;i<41; i++)
	{ strcpy(Carte[i].nom , "***BISON DINGO*** ");
		strcpy(Carte[i].effet, "**Effet : Detruisez les 2 derniers étages d'un totem. ** ");
		Carte[i].id=9;

	}

	for (i=41;i<46; i++)
	{ strcpy(Carte[i].nom , "***FAUX PAS !*** ");       //effet non implementé
		strcpy(Carte[i].effet, "** Condition : Jouez cette carte durant le tour d'un autre joueur. \n Effet : Annulez l'action d'un joueur. Si vous annulez un autre 'FAUX PAS !', piochez 2 cartes, sinon rejouez immédiatement  ** ");
		Carte[i].id=10;

	}

	for (i=46;i<51; i++)
	{ strcpy(Carte[i].nom , "***PILLAGE !*** ");
		strcpy(Carte[i].effet, "**Effet : Volez et mettez dans votre main le dernier etage du totem d'un joueur. ** ");
		Carte[i].id=11;

	}

	for (i=51;i<55; i++)
	{ strcpy(Carte[i].nom , "***CADEAU !*** ");
		strcpy(Carte[i].effet, "**Effet : Volez et une tete au sommet d'un totem pour le placer au sommet d'un totem adverse puis piochez une carte. ** ");
		Carte[i].id=12;

	}

	for (i=55;i<59; i++)
	{ strcpy(Carte[i].nom , "***EAU DE FEU !*** ");
		strcpy(Carte[i].effet, "**Effet : Piochez 2 cartes ** ");
		Carte[i].id=13;

	}

}

void afficherCarte(){           //permet de tester la bonne création des cartes et la fonction de distibution
    int i;
    for (i=0;i<59; i++)
	{
	    printf("%s\n",Carte[i].nom );
	    printf("%s\n",Carte[i].effet);
	    printf("id de la carte:%d\n",Carte[i].id);
	    printf("numj :%d\n",Carte[i].numj);
        printf("Position de la carte: %d\n",Carte[i].pos);
	    printf("******************************************************** \n");
	}
}

int bornes(int min , int max)       //fonction utilisée pour la distribution des cartes
{
	static int rand_is_seeded = 0;
	if(!rand_is_seeded)
	{
    	srand(time(NULL));
   	 rand_is_seeded = 1;
}
return rand()%(max-min+1) + min;
}

void randCarte(){               //fonction qui distribue les cartes pour chaque joueur
                                //elle redistribue aléatoirement chaque carte en mémoire dans le tableau Carte
    int i,a;
    struct TCarte Copie;

    for (i=0; i< 59 ;i++)
	{
		a=bornes(0,58);  //choisit un nb aléatoire, ca sera la position de la carte à échanger avec la carte i

		strcpy(Copie.nom , Carte[i].nom);
		strcpy(Copie.effet, Carte[i].effet);
		Copie.id=Carte[i].id;

		strcpy(Carte[i].nom , Carte[a].nom);
		strcpy(Carte[i].effet, Carte[a].effet);
		Carte[i].id=Carte[a].id;

		strcpy(Carte[a].nom , Copie.nom);
		strcpy(Carte[a].effet, Copie.effet);
		Carte[a].id=Copie.id;
	}

	for (i=0; i< 59 ;i++){

        Carte[i].pos=i;     //attribue le numéro de la position de la carte dans le tableau,
                            //ce qui permettra au joueur de choisir avec facilité la carte qu'il veut jouer
        if (i<44){          //on attribue un numj à chaque carte ce qui permet de savoir à qui appartien la carte (0=pioche)
          Carte[i].numj=0;
        }
        else if(i<49){
                Carte[i].numj=1;
        }
        else if(i<54){
                Carte[i].numj=2;
        }
        else {
            Carte[i].numj=3;
        }
	}
}


void creaJoueur(TJoueur * joueur, int i){
	printf("Inscrivez le nom du joueur %d:",i );
	scanf("%s",(*joueur).nom);
    (*joueur).numj = i;
    (*joueur).points = 0;

}

void afficherJoueur(TJoueur  joueur){ //fonction de test de création de joueurs
    printf("%s\n",joueur.nom );
    printf("%d\n",joueur.numj );
}

void afficherCarteJoueur(int nj){      //permet d'afficher à l'écran les carte d'un joueur
    int i;

    for (i=0; i< 59 ;i++){
        if((Carte[i]).numj==nj){

	    printf("%s\n",Carte[i].nom );
	    printf("%s\n",Carte[i].effet);
	   // printf("%d\n",Carte[i].id);       //donnée non nécessaire pour les joueurs
	   // printf("%d\n",Carte[i].numj);     //donnée non nécessaire pour les joueurs
        printf(" Numero de la carte: %d\n",Carte[i].pos);
	    printf("******************************************************** \n");
        }
    }
}

void afficherUneCarte(int pos){         //permet d'afficher une carte du tableau de carte
    printf("%s\n",Carte[pos].nom );
	printf("%s\n",Carte[pos].effet);
    printf(" Numéro de la carte: %d\n",Carte[pos].pos);
    printf("***************************************************************\n");
}

void piocherCarte(int * prem, int numj){
    int p;
    p=*prem;
    if (*prem<=43){                     //prem ici est la position de la carte du dessus de la pioche
            Carte[*prem].numj=numj;
    }
    printf("Vous venez de piocher la carte\n");
    afficherUneCarte(p);                    //affiche la carte piochée
    * prem=*prem+1;                     //incrémentée à chaque fois que l'on fait appel à la procédure de pioche

}

void defCarte(int pos){     //permet de changer l'état de la carte pour la defausse et l'utilisation des cartes
    Carte[pos].numj=9;      //toute les cartes dans cet etat ne seront pas forcément défaussées mais simplement utilisées
}

void afficherTotem(TJoueur j){ //affichage du totem d'un joueur
    int i=0;
    printf("Totem du joueur %s \n", j.nom);
    while(j.totem[i].id!=0){
        printf("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT\n" );
        printf("%s\n",j.totem[i].nom );
	    printf("%s\n",j.totem[i].effet);
	    printf("%d\n",j.totem[i].id);
	    i=i+1;
    }
    if (i!=0){
        printf("Ceci est la carte du dessus du totem du joueur %d \n" , j.numj);
    }
    printf("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT\n");
}

void initialisationTotem(TJoueur *j){     //permet de passer id à 0 pour faciliter le parcour du tableau de carte totem
    int i;
    for(i=0;i<6;i++){
        (*j).totem[i].id=0;
    }
}

void ajoutTotem(TJoueur *j, int posi ){     //copie les données nécessaires d'une carte totem jouée par un joueur
    int i=0;                                //dans son tableau totem
    while((*j).totem[i].id!=0){
        i=i+1;
    }
    strcpy((*j).totem[i].nom,Carte[posi].nom);
    strcpy((*j).totem[i].effet,Carte[posi].effet);
    (*j).totem[i].id=Carte[posi].id;
    printf("_______________________________________________\n");
    printf("Vous venez d'augmenter la taille de votre totem\n");
    printf("_______________________________________________\n");

}

void supprimerHautTotem(TJoueur *j){            //supprime la carte totem du dessus d'un joueur
    int i=0;
    while((*j).totem[i].id!=0){
        i=i+1;
    }
    if ((*j).totem[i-1].id==6){   //id=6 correspond à la carte Tete Tortue qui empèche la destruction du haut du totem
        printf ("Vous ne pouvez pas detruire cette carte totem, vous venez donc de perdre un tour ");
    }
    else{
            (*j).totem[i-1].id=0;
    }
}


void volerHautTotem(TJoueur *jvole,TJoueur *jvoleur){  //Pose la carte totem sur le totem du joueur qui vole puis la supprime dans le totem du joueur volé
    int i=0;
    int j=0;
    TJoueur jv;
    jv=*jvole;
    while((*jvole).totem[i].id!=0){
        i=i+1;
    }

    if ((*jvole).totem[i-1].id==2) {  //correspond a la carte totem Eete d'Aigle
       printf("Vous ne pouvez pas voler cette carte totem, vous venez de perde un tour betement");
    }
    else {
            int j=0;
            while((*jvoleur).totem[j].id!=0){
            j=j+1;
            }
        (*jvoleur).totem[j]=(*jvole).totem[i-1];
        supprimerHautTotem(&jv);
        *jvole=jv;
    }
}

int compterTotem(TJoueur j){
    int i=0;
    while((j).totem[i].id!=0){
        i=i+1;
    }
    return i;
}

int choix_joueur() // permet de choisir un joueur pour les cartes qui nécessite une cible
{
    int choix;
		do
		{
			printf("Choisir le numero du joueur. \n");
			scanf("%d", &choix);
		}
		while( choix<1 && choix>3 );
    return(choix);
}

int DernierEtage(TJoueur j) // permet de savoir combien de cartes totem est présentes sur le totem du joueur
{
    int Etage=0;
		do
		{
			Etage = Etage +1;
		}
		while( (j).totem[Etage].id != 0);
    return(Etage-1);
}


void jouerCarte(int idCarte, int posCarte,TJoueur *joueurCarte,TJoueur *joueurSuiv,TJoueur *joueurApSuiv, int *prem){
    TJoueur jcopie;
	int choix=0; // pour les cartes ou il faut choisir un joueur
	int j=0;     //Variable de boucle
	int choixvole=0; //Joueur à voler
	int choixvoleur=0; //Joueur adverse pour poser le totem
	int x=0; //Variable de boucle
    int p=*prem; //position de la carte dans le tableau

    TJoueur joueurA;        //joueur actuel
    TJoueur joueurS;        //joueur Suivant
    TJoueur joueurAS;       //joueur apres Suivant
    joueurA = *joueurCarte;
    joueurS = *joueurSuiv;
    joueurAS = *joueurApSuiv;
    if (idCarte> 0 && idCarte<8){           // correspond à l'id des carte tete totem

    switch (idCarte){

        case 1 : //Carte TETE DE COYOTE

				printf("'TETE DE COYOTE' Viens d'être utilise !\n"); // echange de totem entre le joueur actuel et une cible
				printf("%s\n", Carte[posCarte].effet);

                afficherTotem(joueurA);
                afficherTotem(joueurS);
                afficherTotem(joueurAS);

				printf("Choisissez le numéro du joueur avec qui echanger votre totem! (vous ne pouvez pas vous choisir) \n");
				do
				{
				choix = choix_joueur();
				}
				while (choix == joueurA.numj); // On ne peut pas se choisir

				if (choix == joueurS.numj)
				{
					for (j=0 ;j<6 ;j++) // on échange carte totem par carte totem
					{
						jcopie.totem[j] = (joueurA).totem[j]; // insère le totem du joueur qui joue dans une copie
						(joueurA).totem[j] = (joueurS).totem[j]; // Le joueur qui joue prend le totem du joueur ciblé
						(joueurS).totem[j] = jcopie.totem[j]; // le joueur ciblé prend le totem de la copie donc du joueur qui joue
					}
				}
				if(choix == joueurAS.numj)
				{
					for (j=0 ;j<6 ;j++)
					{
						jcopie.totem[j] = (joueurA).totem[j];
						(joueurA).totem[j] = (joueurAS).totem[j];
						(joueurAS).totem[j] = jcopie.totem[j];
					}
				}
				break;

        case 2 : //Carte TETE D'AIGLE

				printf("'TETE D'AIGLE !' Vient d'etre utilise !\n"); //Effet passif : on ne peut pas voler le totem
				printf("%s\n", Carte[posCarte].effet);
				break;

        case 3 : //Carte TETE DE LOUP

                printf("'TETE DE LOUP !' Vient d'etre utilise !\n"); // Vole deux cartes à un autre joueur
				printf("%s\n", Carte[posCarte].effet);

				do
				{
				choix = choix_joueur();
				}
				while (choix == joueurA.numj); // ne peut pas se voler lui même
                j = 0;

				    do
                    {
                        if (Carte[j].numj == choix) // on test tout le tableau de cartes pour trouver les cartes du joueur ciblé
                        {
                        Carte[j].numj = (joueurA).numj; // la carte change d'id donc de joueur
                        x=x+1;
                        }
                        j=j+1;
                    }
					while (x<2);

				break;


			case 4 : //Carte TETE DE CORBEAU
				printf("'TETE DE CORBEAU !' Vient d'etre utilise !\n"); //echange les mains de deux joueurs
				printf("%s\n", Carte[posCarte].effet);

				do
				{
				choix = choix_joueur();
				}
				while (choix == joueurA.numj); // ne pas être utilisé sur soi-même

                for (j=0;j<59;j++){ //test toute la pioche
                        if(Carte[j].numj == choix) //toutes les cartes du joueur ciblé
                        {
                        Carte[j].numj = (joueurA).numj; // changement de propriétaire
                        }
                        else if(Carte[j].numj == (joueurA).numj) // toutes les cartes du joueur qui joue
                        {
                        Carte[j].numj = choix; // changement de propriétaire
                        }
                }
				break;

        case 5 : //Carte TÊTE DE LYNX
				printf("'TETE DE LYNX !' Vient d'etre utilise !\n"); //pioche trois cartes à la fin d'un tour et en défausse 2 si le joueur le souhaite
				printf("%s\n", Carte[posCarte].effet); // effet : mis en action en fin de tour
				break;


        case 6 : //Carte TÊTE DE TORTUE

				printf("'TETE DE TORTUE!' Vient d'etre utilise !\n"); //effet passif : totem ne peut pas etre détruit
				printf("%s\n", Carte[posCarte].effet); //dans les procédures de destruction
				break;


        case 7 : //Carte TÊTE D'OURS

					printf("'TETE D'OURS!' Vient d'etre utilise !\n"); // supprime la carte en tete du totem d'un joueur
					printf("%s\n", Carte[posCarte].effet);

					afficherTotem(joueurA);
					afficherTotem(joueurS);
					afficherTotem(joueurAS);

					choix = choix_joueur(); // on peut se détruire soi-même

					if (choix == joueurA.numj)
					{
						supprimerHautTotem(&joueurA);
					}
					else if (choix == joueurS.numj)
					{
						supprimerHautTotem(&joueurS);
					}
					else
					{
						supprimerHautTotem(&joueurAS);
					}
				break;


    }
     ajoutTotem(&joueurA, posCarte); // les 8 premières cartes utilisent cette fonction
    }
       switch (idCarte){

           			case 8 : //Carte ESPRIT FARCEUR

					printf("'ESPRIT FARCEUR !' Vient d'etre utilise !\n"); // echange tous les totems vers la gauche
					printf("%s\n", Carte[posCarte].effet);

					for (j=0 ;j<6 ;j++)
					{
						jcopie.totem[j] = (joueurA).totem[j]; // copie le totem du joueur actif
						(joueurA).totem[j] = (joueurS).totem[j]; // le joueur actif prend le totem du joueur suivant
						(joueurS).totem[j] = (joueurAS).totem[j]; // le joueur suivant prend le totem du joueur encore suivant
						(joueurAS).totem[j] = jcopie.totem[j];// le joueur encore suivant prend le totem copié donc le totem du joueur actif
					}
				break;


           			case 9 : //Carte BISON DINGO

					printf("'BISON DINGO !' Vient d'etre utilise !\n"); //supprime les deux premières cartes totem d'un joueur
					printf("%s\n", Carte[posCarte].effet);

					afficherTotem(joueurA);
					afficherTotem(joueurS);
					afficherTotem(joueurAS);
					choix = choix_joueur(); // il peut se choisir lui-même

					if (choix == joueurA.numj)
					{
						supprimerHautTotem(&joueurA);
						supprimerHautTotem(&joueurA);
					}
					else if (choix == joueurS.numj)
					{
						supprimerHautTotem(&joueurS);
						supprimerHautTotem(&joueurS);
					}
					else
					{
						supprimerHautTotem(&joueurAS);
						supprimerHautTotem(&joueurAS);
					}
				break;

            case 11 : //Carte PILLAGE

					printf("'PILLAGE !' Vient d'etre utilise !\n"); //vole la première carte du totem d'un joueur
					printf("%s\n", Carte[posCarte].effet);

					afficherTotem(joueurA);
					afficherTotem(joueurS);
					afficherTotem(joueurAS);

					choix =choix_joueur(); // peut se choisir lui-même
					j=0;
					if (choix == joueurA.numj)
					{
					j= DernierEtage(*joueurCarte); //cible le dernier étage du joueur volé
					(joueurA).totem[j].id= joueurA.numj; // la pose sur le dessus du totem du voleur
					supprimerHautTotem(&joueurA); //supprime la carte dans totem du joueur volé
					}
					else if (choix == joueurS.numj)
						{
						j=DernierEtage(*joueurSuiv);
						(joueurS).totem[j].id=joueurA.numj;
						supprimerHautTotem(&joueurS);
						}
						else
						{
						j=DernierEtage(*joueurApSuiv);
						(joueurAS).totem[j].id=joueurA.numj;
						supprimerHautTotem(&joueurAS);
						}

				break;

           case 12 : //Carte CADEAU

				printf("'CADEAU !' Vient d'etre utilise !\n"); //vole un totem pour le mettre sur celui d'un adversaire
				printf("%s\n", Carte[posCarte].effet);

				afficherTotem(joueurA);
				afficherTotem(joueurS);
				afficherTotem(joueurAS);
				printf("Choisissez le numero du joueur a voler puis celui du joueur pour poser la carte. (vous ne pouvez pas vous choisir vous meme). \n");
				choixvole = choix_joueur(); //peut se volé lui-même
				do
				{
				choixvoleur = choix_joueur(); //ne peut pas être le voleur par contre
				}
				while (choixvoleur == joueurA.numj);

				if (choixvole== joueurA.numj) //
				{
					if(choixvoleur == joueurS.numj)
					{
					volerHautTotem(&joueurA,&joueurS);
					}
					else
					{
						volerHautTotem(&joueurA,&joueurAS);
					}
				}
				else if (choixvole == joueurS.numj)
				{
						if(choixvoleur == joueurA.numj)
						{
							volerHautTotem(&joueurS,&joueurA);
						}
					else
					{
						volerHautTotem(&joueurS,&joueurAS);
					}
				}
				else
				{
					if(choixvoleur== joueurAS.numj)
					{
							volerHautTotem(&joueurAS,&joueurA);
					}
					else
					{
						volerHautTotem(&joueurAS,&joueurS);
					}
				}
				break;

       			case 13&&10 : //Carte EAU DE FEU
					printf("'EAU DE FEU !' Vient d'etre utilise !\n"); // pioche deux cartes
					printf("%s\n", Carte[posCarte].effet);

					piocherCarte(&p, joueurA.numj);
					piocherCarte(&p, joueurA.numj);
				break;
       }


    *joueurCarte=joueurA;
    *joueurSuiv=joueurS;
    *joueurApSuiv=joueurAS;

}

void unTour(TJoueur *joueurActuel,TJoueur *joueurSuiv,TJoueur *joueurApSuiv, int numjAct,int * prem){
    printf("\n\n");

   //Ici si joueurAct=1, joueurSuiv=2 et joueurApSuiv=3
   //Ici si joueurAct=2, joueurSuiv=3 et joueurApSuiv=1
   //Ici si joueurAct=3, joueurSuiv=1 et joueurApSuiv=2
    int bon;   //booléen permetant de sorti de la première boucle
    int rep=0;
    int a,b,c,d,dd;      //utilisée dans le cas de l'activation de la carte lynx, d et dd cartes à défausser
    int i=0;
    int numCarte; //permet de récupérer le num du totem que veut jouer le joueur
    int numAction;      //permet de récupérer le numéro de l'action que veut effectuer le joueur pendant son tour
    TJoueur Jact;
    TJoueur Js;
    TJoueur Jas;
    Jact = *joueurActuel;
    Js=*joueurSuiv;
    Jas=*joueurApSuiv;

    int p;         //récupère la valeur de prem, c'est à dire la place de la première carte de la pioche
    p=*prem;

    printf("*****TOUR DU JOUEUR %d *****\n\n", numjAct);
    printf("Quelle action desirez vous faire? ( tapez le chiffre correspondant)\n\n");
    printf("Vos cartes seront affichees si vous decidez de jouer une carte ou de defausser\n");
    printf("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n");
    do{
        printf("1:Afficher mes cartes \n");
        printf("2:Afficher les totems de chaque joueur\n");
        printf("3:Jouer une carte\n");
        printf("4:Piocher une carte\n");
        printf("5:Me defausser d'une carte\n\n");
        scanf("%d",&numAction);

        if (numAction==1){
            afficherCarteJoueur(numjAct);
        }
        else if(numAction==2){
                afficherTotem(J1);
                afficherTotem(J2);
                afficherTotem(J3);
      }

    }while(numAction<3 || numAction>5);

    if (numAction==3){
    afficherCarteJoueur(numjAct); //on (ré)affiche les cartes du joueur dont c'est le tour
    bon=0;
    do{
        printf("Chosissez le numero de la carte que vous voulez jouer \n");
        scanf("%d",&numCarte);
        if(numCarte>58){                            //
            printf("Attention, le numero des cartes vont de 0 à 58! Vous ne pouvez pas choisir celle ci \n");
        }
        else if(Carte[numCarte].numj != numjAct ){      //carte demandée n'appartient pas au joueur
                printf("Attention, vous ne pouvez pas jouer cette carte!\n");
                }
                else {
                    bon=1;
                }
    }while(bon<1);

    jouerCarte(Carte[numCarte].id,numCarte,&Jact,&Js,&Jas,&p);
    afficherTotem(Jact);
    *joueurActuel = Jact;
    *joueurSuiv=Js;
    *joueurApSuiv=Jas;
    defCarte(Carte[numCarte].pos);

    }    //fin action jouer carte

    else if (numAction==4){
        piocherCarte(&p, numjAct);
        *prem=p;
    }
    else if (numAction==5){
        bon=0;
        afficherCarteJoueur(numjAct);
        do{
        printf("Chosissez le numero de la carte que vous voulez defausser \n");
        scanf("%d",&numCarte);
        if(numCarte>58){                            //
            printf("Attention, le numero des cartes vont de 0 à 58! Vous ne pouvez pas defausser celle ci \n");
        }
        else if(Carte[numCarte].numj != numjAct ){      //carte demandée n'appartient pas au joueur
                printf("Attention, vous ne pouvez pas defausser cette carte !\n");
                }
                else {
                    bon=1;
                }
    }while(bon<1);
        defCarte(numCarte);
    }

    while((*joueurActuel).totem[i].id!=0){      //parcourt le totem pour récupérer la carte du dessus
        i=i+1;                                  // une procédure supplémentaire aurait pu être implémentée
    }

    //Effet conditionnel de la carte Tête de Lynx
    if((*joueurActuel).totem[i-1].id==5){       //id 5 = Tete de lynx

       printf("Voulez activer l'effet de votre carte totem Lynx?\n");
       printf("Vous piocherez trois cartes et en defausserez deux\n");
       printf("Oui : 1 \nNon:2\n");
       scanf("%d",&rep);

       if(rep==1){
        a=p;
        piocherCarte(&p, numjAct);              //pioche trois carte
        //printf("a=%d\n",a);
        b=p;
        piocherCarte(&p, numjAct);
        c=p;
        piocherCarte(&p, numjAct);
        *prem=p;

        do{
        printf("Quelles cartes voulez vous defausser parmis les trois piochees? entrez leurs numeros");
        printf("Premiere carte a defausser: ");
        scanf("%d",&d);
        printf("Seconde carte a defausser: ");
        scanf("%d",&dd);
        }while(d==dd || (d!=a && d!=b && d!=c )|| (dd!=a && dd!=b && dd!=c));
        defCarte(d);
        defCarte(dd);
       }
       else {
        printf("L'effet de votre totem lynx ne s'est pas active \n");
       }
    }

}




int main(){

    char gagnant[20];
    int manche=0;           //numéro de la manche
    int i,a;
    int prem=0;                     //numéro de la carte du dessus paquet de pioche, 0 pour la première
    struct TCarte Copie;

    printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
    printf("XXXXXXXXXXXXXX Bienvenue dans le jeu Totem!XXXXXXXXXXXXXX\n");
    printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n\n\n");
    printf("INSTRUCTIONS : Le but du jeu est d'avoir 24 points,\n");
    printf("chaque cartes tetes totem empilees sur votre totem vaut 1 point,\n");
    printf("Une manche se finit si un joueur possède 6 cartes totems empilees,\n");
    printf("Que le plus beau gagne !\n\n\n");

    creerCarte();                    //création des cartes
    creaJoueur(&J1,1);
    creaJoueur(&J2,2);
    creaJoueur(&J3,3);

    printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
    printf("XXXXXXXXXXXXXXXXXX Debut de la Partie!XXXXXXXXXXXXXXXXXXX\n");
    printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n\n");

    do{
        manche=manche+1;
        printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
        printf("XXXXXXXXXXXXXXXXXXX Manche %d XXXXXXXXXXXXXXXXXXXXXXXXXXX\n",manche);
        printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n\n");



        randCarte();                     // distribution des cartes
        initialisationTotem(&J1);
        initialisationTotem(&J2);
        initialisationTotem(&J3);
        do{
        unTour(&J1,&J2,&J3,1,&prem);    // appel la fonction qui détermine les actions d'un tour, ici pour le joueur 1

        if (compterTotem(J1)<6 && compterTotem(J2)<6 && compterTotem(J3)<6){
            unTour(&J2,&J3,&J1,2,&prem);    // appel la fonction qui détermine les actions d'un tour, ici pour le joueur 2
        }
        if (compterTotem(J1)<6 && compterTotem(J2)<6 && compterTotem(J3)<6){
        unTour(&J3,&J1,&J2,3,&prem);  // appel la fonction qui détermine les actions d'un tour pour le joueur 3
        }
        }while(compterTotem(J1)<6 &&compterTotem(J2)<6 && compterTotem(J3)<6);

    printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
    printf("Fin de la manche\n");
    printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n\n\n");

        J1.points=J1.points+compterTotem(J1);
        J2.points=J2.points+compterTotem(J2);
        J3.points=J3.points+compterTotem(J3);

    printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
    printf("Tableau des scores\n");
    printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n\n\n");

    printf("Joueur 1 : %d\n",J1.points);
    printf("Joueur 2 : %d\n",J2.points);
    printf("Joueur 3 : %d\n",J3.points);

    }while(J1.points<24 && J1.points<24 && J1.points<24);

    if (J1.points>J2.points){
        if (J1.points>J3.points){
                strcpy(gagnant,J1.nom);
        }
    }else if (J2.points>J3.points){
        strcpy(gagnant,J2.nom);
    }
    else {
        strcpy(gagnant,J3.nom);
    }
    printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");
    printf("Le gagnant est: %s \n", gagnant );
    printf("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n");

return 0;
}




