package genet_gaudicheau;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Scanner;

public class main {
	
	public static void menu(TABR t, ABR a) throws IOException {
		Scanner sc = new Scanner(System.in);
		int choix = 0;		
		while(choix<1 || choix>9) {
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			System.out.println("|Quelle action souhaitez vous effectuer?     |");
			System.out.println("|1- Créer un TABR à partir d'un fichier texte|");
			System.out.println("|2- Créer un fichier à partir du TABR        |");
			System.out.println("|3- Afficher le TABR sur l'écran             |");
			System.out.println("|4- Vérifier si le TABR construit est valide |");
			System.out.println("|5- Insérer un entier dans le TABR           |");
			System.out.println("|6- Supprimer un entier dans le TABR         |");
			System.out.println("|7- Fusionner deux cases du TABR             |");
			System.out.println("|8- Transformer le TABR en ABR               |");
			System.out.println("|9- Quitter le programme                     |");
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		choix =sc.nextInt();
		}
		switch(choix) {
		case 1:
			Scanner sch = new Scanner(System.in);
	        System.out.println("Entrer le nom du fichier");
	        String nom = sch.nextLine();
			File f = new File(nom);
			t.parseF(f);
		break;
		case 2:
			t.creerF(t);
		break;
		case 3:
			t.afficherTabr(t);
		break;
		case 4:
			t.verifierTABR(t);
		break;
		case 5:
			System.out.println("entier à insérer?");
			int nb= sc.nextInt();
			t.insererVal(t,  nb);
		break;
		case 6:
			System.out.println("entier à supprimer?");
			int nb2= sc.nextInt();
			t.deleteVal(t, nb2);
		break;
		case 7:
			System.out.println("case à fusionner?");
			int n= sc.nextInt();
			t.fusionC(t, n);
		break;
		case 8:
			a =t.transformerABR(t);
			int choix3=4;
			while( choix3!=1 && choix3!=0) {
				System.out.println("voulez-vous afficher l'ABR? 1/0");
				choix3 =sc.nextInt();
			}
			if (choix3 == 1) {
				a.afficher(a);
			}
		break;
		default :
			System.exit(0);
		}
		int choix2 = 4;
		while (choix2 !=0 && choix2!=1) {
			System.out.println("Voulez-vous continuer? 1/0");
			choix2= sc.nextInt();
		}
		if (choix2 == 1) {
			menu(t, a);
		}
		else {
			System.exit(0);
		}
	}

	public static void main(String[] args) throws IOException {
		ABR a = new ABR();
		TABR t = new TABR();
		menu(t, a);

	}

}