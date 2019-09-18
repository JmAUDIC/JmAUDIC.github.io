package genet_gaudicheau;

import java.io.BufferedInputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Scanner;

public class TABR {
	Case tabC[];
	int nb;
	
	public TABR() {
		nb = 0;
		tabC = new Case[30];
		for(int i=0; i<30; i++) {
			tabC[i]= new Case();
		}
		
	}
	
	//("/comptes/E177226M/test.txt"));
            
    public String lecture(File f) {
        try {
           BufferedInputStream in = new BufferedInputStream(new FileInputStream(f));
           StringWriter out = new StringWriter();
           int b;
           while ((b=in.read()) != -1)
               out.write(b);
           out.flush();
           out.close();
           in.close();
           return out.toString();
        }
        catch (IOException ie)
        {
             ie.printStackTrace(); 
        }
		return null;
    }
	
    public void parseF(File f) {
    	String r = lecture(f);
    	String delim = "[\n;]+";
    	String delim2 = "[:]+";
    	String limites[] = new String[2];
    	String[] tokens = r.split(delim);
    	String[] arbre = new String[30];
    	int n=0;
    	for (int i=0; i<tokens.length;i++) {
    		
    		limites = tokens[i].split(delim2);
  
    		tabC[n].debut=Integer.parseInt(limites[0]);
    		tabC[n].fin=Integer.parseInt(limites[1]);
    		
    		i++;
    		
    		
    		arbre = tokens[i].split(delim2);
    		for(int j=0; j<arbre.length;j++) {
    			tabC[n].a.inserer(tabC[n].a, Integer.parseInt(arbre[j]));
    		} 		
    		nb++;
    		n++;
    	}
    }
    
    public void afficherTabr(TABR t) {
    	for (int i=0; i<t.nb; i++) {
			t.tabC[i].afficherArbre(t.tabC[i]);
		}
    }
    
    public void verifierTABR(TABR tabr) {
    	boolean valide = true;
    	int i;
    	for (i = 0; i<tabr.nb-1; i++) {
   
    		if(tabr.tabC[i].verifierBorne(tabr.tabC[i])==false) {
    			System.out.println("à la case"+i);
    			valide = false;
    			
    		}
    		if (tabr.tabC[i].fin>tabr.tabC[i+1].debut) {
    			System.out.println("Les bornes de la case "+i+" et de la case "+(i+1)+" se chevauchent");
    			valide = false;
    		}
    		if (tabr.tabC[i].verifierCase(tabr.tabC[i])==false) {
    			System.out.println("L'arbre de la case "+i+" n'est pas trié");
    			valide = false;
    		}
    	}

    	if(tabr.tabC[i].verifierBorne(tabr.tabC[i])==false) {
    		System.out.println("à la case "+i);
    		valide = false;
    	}
    	if(tabr.tabC[i].verifierCase(tabr.tabC[i])==false) {
    		System.out.println("L'arbre de la case "+i+" n'est pas trié");
    		valide = false;
    	}
    	if (valide == true) {
    		System.out.println("L'arbre est valide");
    	}
    }
    
    public void insererVal(TABR t, int x) {
    	int i=0;
    	boolean stop = false;
    	while (!stop) {
    		if(x>=t.tabC[i].debut && x<=t.tabC[i].fin) {
    			t.tabC[i].a.inserer(t.tabC[i].a, x);
    			stop =true;
    			System.out.println("l'élément a été inséré avec succès");
    		}
    		else {
    			if(x>t.tabC[i].fin && x<t.tabC[i+1].debut) {
    				System.out.println("Cet élement ne peut pas etre inséré");
    				stop =true;
    			}
    		}	
    	i++;
    	}
    }
    public void deleteVal(TABR t, int x) {
    	int i=0;
    	boolean stop = false;
    	while (!stop) {
    		if(x>=t.tabC[i].debut && x<=t.tabC[i].fin) {
    			t.tabC[i].a.delete(x);
    			stop =true;
    		}
    		else {
    			if(x>t.tabC[i].fin && x<t.tabC[i+1].debut) {
    				System.out.println("Cet élement ne peut pas etre supprimé");
    				stop =true;
    			}
    		}	
    	i++;
    	}
    }
    
    public void creerF (TABR t) throws IOException
    {
        Scanner sc2 = new Scanner(System.in);
        System.out.println("Entrer le nom du fichier");
        String nom = sc2.nextLine();
         
        BufferedWriter bw = new BufferedWriter(new FileWriter(nom));
        PrintWriter pWriter = new PrintWriter(bw);
        for (int i = 0; i<t.nb; i++) {
        	pWriter.print(t.tabC[i].debut+":"+t.tabC[i].fin+";");
    		t.ecrire(t.tabC[i].a, pWriter);
    		pWriter.print("\n");
        }
        pWriter.close() ;
    }
    public void ecrire(ABR a, PrintWriter pWriter) {
		if (a.vide == false) {
			pWriter.print(a.val+":");
			ecrire(a.sag, pWriter);			
			ecrire(a.sad, pWriter);
		}
	}
    
    public void fusionC(TABR t, int i) {
    	if (i>nb-1) {
    		System.out.println("pas assez de cases");
    	}
    	else {
	    	int j=0;
	    	t.tabC[i].fin = t.tabC[i+1].fin;
	    	t.tabC[i+1].a.fusionA(t.tabC[i+1].a, t.tabC[i].a);
	    	for(j = i+1;j<nb-1; j++ ) {
	    		t.tabC[j] = t.tabC[j+1];
	    		t.tabC[j].a = t.tabC[j+1].a;
	    	}
	    	nb--;
	    	System.out.println("fusion réalisée avec succès");
    	}
    }
    
    public ABR transformerABR(TABR t) {
    	for (int i=1; i<nb; i++) {
    		t.tabC[0].a.fusionA(t.tabC[i].a, t.tabC[1].a);
    	}
    	System.out.println("Transformation en ABR réussie");
    	return t.tabC[1].a;
    }
    
    

}
