package genet_gaudicheau;

public class Case {
	ABR a;
	int debut;
	int fin;
	
	public Case () {
		a=new ABR();
		debut=0;
		fin=0;
		
	}
	public Case (int debut, int fin, ABR a) {
		this.a = a;
		this.debut = debut;
		this.fin = fin;
	}
	
	public void afficherArbre(Case c) {
		System.out.print(debut+":"+fin+";");
		a.afficher(a);
		System.out.println("");
		
	}
	
	public boolean verifierCase(Case c) {
		int i=-1;
		int t[] = new int[500];
		if (c.debut>c.fin) {
			return false;
		}
		return c.a.verifierABR(c.a, i, t);
	}
	
	public boolean verifierBorne(Case c) {
		int mini =99999;
		mini =c.a.min(c.a, mini);
		int maxi =0;
		maxi=c.a.max(c.a, maxi);
		if(mini<c.debut) {
			System.out.print("Au moins une des valeurs est plus petite que la borne de début");
			return false;
		}
		else {
			if(maxi>c.fin) {
				System.out.print("Au moins une des valeurs est plus grande que la borne de fin ");
				return false;
			}
		}
		return true;
	}
	

}
