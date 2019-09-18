package genet_gaudicheau;

public class ABR {
	 int val;
	 ABR sag;
	 ABR sad;
	boolean vide;
	
	public ABR (ABR ag, int v, ABR ad) {
		val = v;
		sag = ag;
		sad = ad;
		vide=false;
	}

	public ABR () {
		val=0;
		vide=true;
		sag = null;
		sad = null;
		
	}
	
	public static void afficher(ABR a) {
		if (a.vide == false) {
			System.out.print(a.val+":");
			afficher(a.sag);			
			afficher(a.sad);
		}
	}
	
	public void inserer (ABR a, int x) {
		if (a.vide == true) {
			a.val = x;
			a.vide = false;
			a.sag = new ABR();
			a.sad = new ABR();
		}
		else {
			if(x<=a.val) {
				inserer(a.sag, x);
			}
			else {
				inserer(a.sad, x);
			}
		}
	}
	
	public void recopie(ABR n) {
		this.val = n.val;
		this.vide = n.vide;
		this.sag = n.sag;
		this.sad = n.sad;
	}
	
	public int extraireMax() {
		if(this.sad.vide) {
			int res=this.val;
			recopie(sag);
			return res;
		}
		else return this.sad.extraireMax();
	}
	
	public void delete (int x) {
		if(vide == true) {
			System.out.println("Element inexistant");
		}
		else {
			if(x<val) {
				sag.delete(x);
			}
			else {
				if(x>val) {
					sad.delete(x);
				}
				else {
					if(sag.vide ==true) {
						recopie(this.sad);
						System.out.println("Element supprimé avec succès");
					}
					else {
						if(sad.vide==true) {
							recopie(this.sag);
							System.out.println("Element supprimé avec succès");
						}
						else {
							this.val=sag.extraireMax();
							System.out.println("Element supprimé avec succès");
							
						}
					}
				}
			}
			
		}
	}
	
	public boolean verifierABR(ABR a, int i, int[] t) {
		i++;
		if (a.vide = false) {
			a.sag.verifierABR(a.sag, i, t);
			t[i]=a.val;
			a.sad.verifierABR(a.sad, i,  t);
		}
		for(int j=0; j<i; j++) {
			if (t[j]>t[j+1]) {
				return false;
			}
		}
		return true;
	}
	
	public int min(ABR a, int mini) {
		if(a.vide == false) {
			
			return 	Math.min(a.val, Math.min(a.min(a.sag, mini), a.min(a.sad, mini)));		
		}
		else {
			return mini;
		}
	}
	public int max(ABR a, int maxi) {
		if(a.vide == false) {
			
			return 	Math.max(a.val, Math.max(a.max(a.sag, maxi), a.max(a.sad, maxi)));		
		}
		else {
			return maxi;
		}
	}
	
	public void fusionA(ABR a, ABR b) {
   	if(a.vide == false) {
   		a.fusionA(a.sag, b);
   		b.inserer(b, a.val);
   		a.fusionA(a.sad, b);
   	}
   }
}
