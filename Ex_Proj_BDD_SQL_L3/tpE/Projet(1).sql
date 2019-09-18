DROP TABLE stat_jeu;
DROP TABLE facture;
DROP TABLE jeu;
DROP TABLE joueur;
DROP USER admin CASCADE  ;
DROP USER player;
DROP ROLE role_admin;
DROP ROLE role_player;


 
CREATE TABLE joueur(
	login VARCHAR2(20) NOT NULL,
	--Ajout sexe
	sexe VARCHAR2(1) NOT NULL,
	mdp VARCHAR2(15) NOT NULL,
	date_naissance DATE NOT NULL,
	PRIMARY KEY (login), 
	CHECK (sexe='M' OR sexe='F')
	);
CREATE TABLE jeu(
	editeur VARCHAR2(50) NOT NULL,
	titre VARCHAR2(50) NOT NULL,
	description VARCHAR2(100),
	date_parution DATE,
	pegi NUMBER,
	note_presse NUMBER,
	prix NUMBER,
	PRIMARY KEY (editeur, titre)
	);
CREATE TABLE facture(
    login VARCHAR2(20) NOT NULL,
	ref_facture NUMBER NOT NULL,
	date_achat DATE NOT NULL,
	prix NUMBER,
	editeur VARCHAR(50) NOT NULL,
	titre VARCHAR(50) NOT NULL,
	PRIMARY KEY (ref_facture),
	FOREIGN KEY(titre, editeur) REFERENCES jeu(titre, editeur),
	FOREIGN KEY(login) REFERENCES joueur(login)
	);

CREATE TABLE stat_jeu(
	login VARCHAR2(20) NOT NULL,
	editeur VARCHAR2(50) NOT NULL,
	titre VARCHAR2(30) NOT NULL,
	temps_joue VARCHAR2(10),
	PRIMARY KEY (login, titre),
	FOREIGN KEY (login) REFERENCES joueur(login),
	FOREIGN KEY (titre, editeur) REFERENCES jeu(titre, editeur)	
	);

--Ajout trigger: 

INSERT INTO joueur(login,sexe, mdp, date_naissance) VALUES('Antipolis','M','ABX22',TO_DATE('20/10/1993','DD/MM/YYYY'));
INSERT INTO joueur(login,sexe, mdp, date_naissance) VALUES('Kusco','M','interneeet', TO_DATE('14/02/1993','DD/MM/YYYY'));
INSERT INTO joueur(login,sexe, mdp, date_naissance) VALUES('Capitaineflamm','M','coucou', TO_DATE('26/01/1993','DD/MM/YYYY'));
INSERT INTO joueur(login,sexe, mdp, date_naissance) VALUES('MonsieurP','M','azerty', TO_DATE('03/04/1984','DD/MM/YYYY'));
INSERT INTO joueur(login,sexe, mdp, date_naissance) VALUES('ElDiablo','F','youpi', TO_DATE('01/01/1983','DD/MM/YYYY'));
INSERT INTO joueur(login,sexe, mdp, date_naissance) VALUES('Reptilien72','F','UJH638A', TO_DATE('12/12/2003','DD/MM/YYYY'));


INSERT INTO jeu(editeur, titre, description, date_parution, pegi, note_presse, prix) VALUES('Valve','Half Life 2','FPS',TO_DATE('16/11/2004','DD/MM/YYYY'),18,17,19.99);
INSERT INTO jeu(editeur, titre, description, date_parution, pegi, note_presse, prix) VALUES('Sega','Company Of Heroes 2','Stratégie',TO_DATE('20/07/2013','DD/MM/YYYY'),12,16,29.99);
INSERT INTO jeu(editeur, titre, description, date_parution, pegi, note_presse, prix) VALUES('Infinty Ward','Call of Duty Modern Warfare','FPS', TO_DATE('05/11/2007','DD/MM/YYYY'),18, 15,49.99);
INSERT INTO jeu(editeur, titre, description, date_parution, pegi, note_presse, prix) VALUES('SCS Software','Euro Truck Simulator 2','Simulation de poids lourds',TO_DATE('19/10/2012','DD/MM/YYYY'), 3,18,4.5);
INSERT INTO jeu(editeur, titre, description, date_parution, pegi, note_presse, prix) VALUES('Focus Home interactive','Farming Simulator 2012','Simulation agricole',TO_DATE('25/10/2012','DD/MM/YYYY'),3,14,19.99);
INSERT INTO jeu(editeur, titre, description, date_parution, pegi, note_presse, prix) VALUES('Valve','Counter Strike Global Ofensive','FPS',TO_DATE('21/08/2012','DD/MM/YYYY'),18,15, 9.99);
INSERT INTO jeu(editeur, titre, description, date_parution, pegi, note_presse, prix) VALUES('Sega','Empire Earth II','Stratégie',TO_DATE('29/04/2005','DD/MM/YYYY'),12,14, 14.49);
INSERT INTO jeu(editeur, titre, description, date_parution, pegi, note_presse, prix) VALUES('Eidos Interactive','Commandos Strike Force','FPS',TO_DATE('17/03/2006','DD/MM/YYYY'),16,11,12.45);
INSERT INTO jeu(editeur, titre, description, date_parution, pegi, note_presse, prix) VALUES('UIE gmbH ','Airport Simulator 2014','Simulation de transport aerien',TO_DATE('19/12/2013','DD/MM/YYYY'),3,08, 4.99);
INSERT INTO jeu(editeur, titre, description, date_parution, pegi, note_presse, prix) VALUES('Microsoft','Age Of Empires III','Stratégie',TO_DATE('18/10/2005','DD/MM/YYYY'),8,16,12.45);

DROP SEQUENCE seqfac;
CREATE SEQUENCE seqfac start with 1 increment by 1;
INSERT INTO facture( ref_facture, login, titre, editeur,date_achat, prix) VALUES(seqfac.nextval, 'Antipolis','Half Life 2','Valve',TO_DATE('02/08/2012','DD/MM/YYYY'),19.99);
INSERT INTO facture( ref_facture, login, titre, editeur,date_achat, prix) VALUES(seqfac.nextval,'Antipolis','Company Of Heroes 2','Sega',TO_DATE('04/12/2011','DD/MM/YYYY'),29.99);
INSERT INTO facture(ref_facture,login,  titre, editeur,date_achat, prix) VALUES(seqfac.nextval,'Capitaineflamm','Call of Duty Modern Warfare','Infinty Ward',TO_DATE('02/08/2011','DD/MM/YYYY'),49.99);
INSERT INTO facture( ref_facture, login, titre, editeur,date_achat, prix) VALUES(seqfac.nextval,'Antipolis','Euro Truck Simulator 2','SCS Software',TO_DATE('06/11/2011','DD/MM/YYYY'),4.5);
INSERT INTO facture( ref_facture, login, titre, editeur,date_achat, prix) VALUES(seqfac.nextval,'Reptilien72','Commandos Strike Force','Eidos Interactive',TO_DATE('24/11/2008','DD/MM/YYYY'),12.45);
INSERT INTO facture( ref_facture, login, titre, editeur,date_achat, prix) VALUES(seqfac.nextval,'ElDiablo','Age Of Empires III','Microsoft',TO_DATE('28/01/2008','DD/MM/YYYY'),12.45);



INSERT INTO stat_jeu(login, editeur, titre, temps_joue) VALUES ('Antipolis','Sega','Company Of Heroes 2','14,3h');
INSERT INTO stat_jeu(login, editeur, titre, temps_joue) VALUES ('Capitaineflamm','Infinty Ward','Call of Duty Modern Warfare','43h');
INSERT INTO stat_jeu(login, editeur, titre, temps_joue) VALUES ('Antipolis','Valve','Half Life 2','124,3h');
INSERT INTO stat_jeu(login, editeur, titre, temps_joue) VALUES ('ElDiablo','Microsoft','Age Of Empires III','11h');



--Nous créons l'utilisateur player, l'admin peut tout faire

--CREATE USER admin IDENTIFIED BY admin ;		
--CREATE USER player IDENTIFIED by player ;
--GRANT CREATE SESSION TO player ;	
--GRANT CREATE TABLE TO player ;
--GRANT SELECT ON stat_jeu TO player WITH GRANT OPTION ;
--GRANT SELECT ON jeu TO player WITH GRANT OPTION ;
--GRANT SELECT ON joueur TO player WITH GRANT OPTION ;

--Création des vues:
--Vue permettant de calculer le nombre de jeux que possède un joueur:
CREATE OR REPLACE VIEW NbJeuxJoueurs AS
	SELECT login, COUNT(titre) AS Nombre_de_Jeux
	FROM facture
	GROUP BY login;

--Vue permettant de calculer la somme totale dépensée par les joueurs en achat de jeux vidéos.  
CREATE OR REPLACE VIEW SommeDepensee AS
	SELECT login, SUM(prix) AS Somme_totale
	FROM facture
	GROUP BY login;

--Vue permettant de lister les jeux par catégorie (FPS, Stratégie etc.)
CREATE OR REPLACE VIEW Genre AS
	SELECT titre, description
	FROM jeu
	GROUP BY description, titre;
	
--Cette fonction renvoie l'âge du joueur

set serveroutput on;
CREATE OR REPLACE FUNCTION trouverAge(dateNaissance IN DATE)
	RETURN NUMBER IS
		ageJoueur NUMBER;
	BEGIN
		ageJoueur := trunc( (sysdate - dateNaissance)/365.25);
		RETURN ageJoueur;
	END;
	/

--Cette fonction vérifie qu'un joueur dont on donne la date de naissance en paramètre peut acheter un jeu. 

CREATE OR REPLACE PROCEDURE valideAge(profil VARCHAR2, jeu VARCHAR2) IS 
		dateJoueur DATE;
		pegiJeu VARCHAR2(30);
		CURSOR cJoueur IS SELECT date_naissance FROM joueur WHERE joueur.login=profil;
		CURSOR cPegi IS SELECT pegi FROM jeu WHERE jeu.titre=jeu;
	BEGIN
		OPEN cPegi;
		OPEN cJoueur;
		FETCH cPegi INTO pjeuegiJeu;
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

	--Trigger qui empêche l'insertion d'un prix négatif.
	CREATE OR REPLACE TRIGGER prixNegatifFacture
		BEFORE INSERT 
			ON facture
			FOR EACH ROW
			 
		DECLARE 
			prix_error EXCEPTION;
		BEGIN
			IF :new.prix<0 THEN
				Raise prix_error;
			END IF;
		EXCEPTION
			WHEN prix_error THEN
			raise_application_error(-20001,'Le prix du jeu ne peut etre negatif !');
		END;
		/
	--Idem mais pour la table jeu
		CREATE OR REPLACE TRIGGER prixNegatifJeu
		BEFORE INSERT 
			ON jeu
			FOR EACH ROW
			 
		DECLARE 
			prix_error EXCEPTION;
		BEGIN
			IF :new.prix<0 THEN
				Raise prix_error;
			END IF;
		EXCEPTION
			WHEN prix_error THEN
			raise_application_error(-20001,'Le prix du jeu ne peut etre negatif !');
		END;
		/

	

		

--Fonction qui permet de lister tous les jeux d'un genre donné en paramètre:
CREATE OR REPLACE PROCEDURE triGenre(genre VARCHAR2) IS
	CURSOR cGenre IS SELECT DISTINCT titre , note_presse FROM jeu WHERE description=genre ORDER BY note_presse DESC;
	jeuTitre cGenre%ROWTYPE;
	BEGIN
		OPEN cGenre;
		DBMS_OUTPUT.PUT_LINE('*********');
		DBMS_OUTPUT.PUT_LINE('** '||genre||' **');
		DBMS_OUTPUT.PUT_LINE('*********');
		LOOP
			FETCH cGenre INTO jeuTitre;
			EXIT WHEN cGenre %NOTFOUND; 
			DBMS_OUTPUT.PUT_LINE(jeuTitre.titre ||' Note :'|| jeuTitre.note_presse);
			
		END LOOP;
		CLOSE cGenre;
	END;
	/


CREATE OR REPLACE PROCEDURE jeuParPrix(prixMin REAL, prixMax REAL) IS
	CURSOR cPrix IS SELECT DISTINCT titre, editeur, prix FROM jeu WHERE prix <= prixMax AND prix >= prixMin ORDER BY prix ASC;
	jeuPrix cPrix%ROWTYPE;

	BEGIN
		OPEN cPrix;
		LOOP
			FETCH cPrix INTO jeuPrix;
			EXIT WHEN cPrix %NOTFOUND;
			DBMS_OUTPUT.PUT_LINE( jeuPrix.titre || ' Editeur: ' || jeuPrix.editeur || ' Prix: ' || jeuPrix.prix);
			
		END LOOP;
		CLOSE cPrix;
	END;
	/


--On ne peut pas acheter un jeu avant sa date de sortie
CREATE OR REPLACE TRIGGER facture_dateS_ins_row
	BEFORE INSERT OR UPDATE
	ON facture
	FOR EACH ROW
DECLARE
	avant_sortie EXCEPTION;
	sortie_jeu  jeu.date_parution%Type;
BEGIN
	SELECT date_parution INTO sortie_jeu
	FROM jeu
	WHERE jeu.titre = :new.titre;	
	IF :new.date_achat < sortie_jeu THEN
		RAISE avant_sortie ;
	END IF;	
EXCEPTION 
	WHEN avant_sortie THEN
		raise_application_error(-20002, 'On ne peut acheter un jeu avant sa sortie');
	
END;
/


CREATE USER admin IDENTIFIED BY admin; 
GRANT UNLIMITED TABLESPACE TO admin;

CREATE ROLE role_admin ;
GRANT CREATE SESSION TO role_admin;	
GRANT DBA TO role_admin ;
GRANT role_admin TO admin;

CREATE USER player IDENTIFIED BY player;
CREATE ROLE role_player;
GRANT CREATE SESSION TO role_player;
GRANT SELECT ON NbJeuxJoueurs TO role_player;
GRANT SELECT ON SommeDepensee TO role_player;
GRANT EXECUTE ON triGenre TO role_player;
GRANT EXECUTE ON jeuParPrix TO role_player;
GRANT role_player TO player;
