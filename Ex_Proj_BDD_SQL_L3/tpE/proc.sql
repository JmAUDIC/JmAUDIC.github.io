CREATE OR REPLACE PROCEDURE valideAge(profil VARCHAR2, jeu VARCHAR2) IS 
		dateJoueur DATE;
		pegiJeu VARCHAR2(30);
		CURSOR cJoueur IS SELECT date_naissance FROM joueur WHERE joueur.login=profil;
		CURSOR cPegi IS SELECT pegi FROM jeu WHERE jeu.titre=jeu;
	BEGIN
		OPEN cPegi;
		OPEN cJoueur;
		FETCH cPegi INTO pegiJeu;
		FETCH cJoueur INTO dateJoueur;
		IF (trouverAge(dateJoueur) >= pegiJeu) THEN
			DBMS_OUTPUT.PUT_LINE( profil ||' peut acheter ' || jeu ||', il est assez grand ;)');
		ELSE
			DBMS_OUTPUT.PUT_LINE( profil ||' ne peut pas acheter ' || jeu ||', il est encore un peu jeune ;)');
		END IF; 
		CLOSE cPegi;
		CLOSE cJoueur;
		
	END;
	/

--IS/AS?

CREATE OR REPLACE PROCEDURE Abo(log VARCHAR2) AS 
		--login_user VARCHAR2(50);
		abonnement VARCHAR2(50);
		--CURSOR cursorLog IS SELECT login_user FROM Utilisateur WHERE Utilisateur.login_user=log;
		CURSOR cursorAbo IS SELECT type_abonnement FROM Utilisateur WHERE Utilsateur.type_abonnement=abo;
	BEGIN
		OPEN cursorLog;
		OPEN cursorAbo;
		--FETCH cursorLog INTO login_user;
		FETCH cursorAbo INTO abonnement;
		
		IF (abonnement ='Inactif') THEN
		
			DBMS_OUTPUT.PUT_LINE( log ||' ne possède plus d abonnement valide');
		ELSE
			DBMS_OUTPUT.PUT_LINE( log ||' dispose de l abonnement:  ');
		END IF;
	
	END ;

