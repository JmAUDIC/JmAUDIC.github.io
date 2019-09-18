--@Stremusic.sql
-- @Author :	Jean-Marie Audic, Alpha-Oumar Diallo, Paul-Alexandre Tessier
-- @Date :	Mercredi 10 Mars 2017

-- Suppression des anciennes tables 

DROP VIEW  UtilisateurAbonnement ;
DROP VIEW AlbumTitre;
DROP TABLE Utilisateur;
DROP TABLE Abonnement
DROP TABLE Titre;
DROP TABLE Album;
DROP TABLE Avis;

--Creation Sequence

CREATE SEQUENCE sequence_id_titre START WITH 1 INCREMENT BY 1;

-- Création de la table Utilisateur

CREATE TABLE Utilisateur
(
    login_user VARCHAR2(50) PRIMARY KEY,
	mdp_user VARCHAR2(50),
	mail_user VARCHAR2(50),
    age_user NUMBER(12),
    type_abonnement VARCHAR2(50) REFERENCES Abonnement(type_abonnement),
    date_debut_abonnement DATE,
);

-- Création de la table Abonnement

CREATE TABLE Abonnement
(
    type_abonnement VARCHAR2(50) PRIMARY KEY,
    information_abonnement TEXT(13),
    prix_abonnement DOUBLE(5),
);

CREATE TABLE Titre
(
    id_titre INT(7) PRIMARY KEY,
    nom_titre VARCHAR2(50),
    nom_album VARCHAR2(10) REFERENCES Album(nom_album),
);

CREATE TABLE Album 
(
    nom_album VARCHAR2(10) PRIMARY KEY,
    nom_artiste VARCHAR(50),
    genre_album VARCHAR(50),
    label_album VARCHAR(50),
    date_sortie_album DATE,
    nb_titre_album INT(18),
);

CREATE TABLE Avis
(
    login_user VARCHAR(50) REFERENCES Utilisateur(login_user),
    id_titre INT(7) REFERENCES Titre(id_titre),
    note_titre INT(1), -- note sur 5
    commentaire_titre TEXT(15),
    CONSTRAINT chk_avis CHECK (note_titre <= 5 AND note_titre >= 0)
);

-- Insertion des valeurs de test

INSERT INTO Utilisateur VALUES('jeanjack','password','jeanjacque.goldman@hotmail.fr',18,'Decouverte',to_date('31122016','ddmmyyyy'));
INSERT INTO Utilisateur VALUES('jenphilip','wxcvbgd','jenphilip.goldman@hotmail.fr',19,'1 mois',to_date('31012016','ddmmyyyy'));
INSERT INTO Utilisateur VALUES('jeanmarie','ccvdfgc','jeanmari.goldman@hotmail.fr',20,'2 mois',to_date('25022016','ddmmyyyy'));
INSERT INTO Utilisateur VALUES('alphaoumar','wxcvbgd','alphaoumar.goldman@hotmail.fr',21,'4 mois',to_date('15032016','ddmmyyyy'));
INSERT INTO Utilisateur VALUES('Antoine','azertyuiop','Antoine.ledisparu@orange.fr',10,'Inactif',to_date('08072016','ddmmyyyy'));

INSERT into Abonnement VALUES('Decouverte', '1 mois gratuit', 0.0 );
INSERT into Abonnement VALUES('1 mois', '1 mois d abonnement a de la musique illimitée', 9.99 );
INSERT into Abonnement VALUES('3 mois', '3 mois d abonnement a de la musique illimitée', 24.99 );
INSERT into Abonnement VALUES('1 an', '1 an d abonnement a de la musique illimitée', 74.99 );
INSERT into Abonnement VALUES('Inactif', 'Compte plus abonné ou formule découverte expirée', 0.0 );

insert into Album VALUES('L Ovni', 'JUL', 'Rap Alternatif', 'D or et de platine',to_date('02122016','ddmmyyyy'),23);
insert into Album VALUES('Bat Out of Hell', 'Meat Loaf', 'Rock wagnérien', 'Cleveland International',to_date('21101977','ddmmyyyy'),7);
insert into Album VALUES('Travelling without moving', 'Jamiroquai', 'Funk', 'Sony',to_date('09091996','ddmmyyyy'),14);
insert into Album VALUES('X&Y', 'Coldplay', 'Alternatif', 'EMI',to_date('06062005','ddmmyyyy'),13);
insert into Album VALUES('Mes fantaisies', 'Shy m', 'R&B', 'K.Pone',to_date('30102006','ddmmyyyy'),13);
insert into Album VALUES('Willy and the Poor boys', 'Creedence Clearwater Revival', 'Rock', 'Fantasy Records',to_date('02111969','ddmmyyyy'),13);

insert into Titre VALUES(sequence_id_titre.nextval,'Fortunate Son','Willy and the Poor boys' );
insert into Titre VALUES(sequence_id_titre.nextval,'Tchikita','L Ovni' );
insert into Titre VALUES(sequence_id_titre.nextval,'Paradise By The Dashboard Light','Bat Out of Hell' );
insert into Titre VALUES(sequence_id_titre.nextval,'Virtual Insanity','Travelling without moving' );
insert into Titre VALUES(sequence_id_titre.nextval,'Speed of Sound','X&Y' );
insert into Titre VALUES(sequence_id_titre.nextval,'Femme de couleur','Mes fantaisies' );

insert into Avis VALUES('jeanjack','Tchikita', 5, 'Encore un magnifique titre de ce génie de la musique du 21eme siecle');
insert into Avis VALUES('alphaoumar','Femme de couleur', 4, 'Une belle femme pour une belle musique en fait');
insert into Avis VALUES('jenphilip','Speed of Sound', 0, 'Nul');
insert into Avis VALUES('jeanmarie','Femme de couleur', 5, 'Parfait');
insert into Avis VALUES('jeanjack','Fortunate Son', 2, 'Décu par ce nouveau titre');
insert into Avis VALUES('alphaoumar','Tchikita', 4, 'Tchikitaaaaaa');
-- Affichage de l'ensenble des valeurs dans les tables

SELECT * FROM Utilisateur;
SELECT * FROM Abonnement;
SELECT * FROM Titre;
SELECT * FROM Album;
SELECT * FROM Avis;

SET SERVEROUTPUT ON

--Creation de Trigger

CREATE OR REPLACE TRIGGER utilisateur_ins_row
	BEFORE INSERT
	ON Utilisateur
	FOR EACH ROW
DECLARE 
	pas_valide EXCEPTION;
	utilisateur_exist NUMBER;
BEGIN
	SELECT COUNT(*) INTO utilisateur_exist
	FROM  Utilisateur
	WHERE :new.login_user = Utilisateur.login_user;

	
		RAISE pas_valide;
	

	EXCEPTION
	WHEN pas_valide THEN
		RAISE_APPLICATION_ERROR (-20001, 'Ce pseudo existe deja');
END;
/

--Test trigger
--INSERT INTO Utilisateur VALUES('jeanjack','password','jean.bon@hotmail.fr',18,'Decouverte',to_date('20161231','yyyymmdd'));

CREATE OR REPLACE TRIGGER avis_ins_row
	BEFORE INSERT
	ON Avis
	FOR EACH ROW
DECLARE 
	pas_valide EXCEPTION;
	utilisateur_abo_valide NUMBER;
BEGIN
	SELECT COUNT(*) INTO utilisateur_abo_valide
	FROM  Utilisateur
	WHERE :new.type_abonnement = "Inactif";

	
		RAISE pas_valide;
	

	EXCEPTION
	WHEN pas_valide THEN
		RAISE_APPLICATION_ERROR (-20001, 'L utilisateur ne peut pas poster d avis');
END;
/

--insert into Avis VALUES('Antoine','Tchikita', 4, 'test trigger insertion');


--Creation de Vues
--Vue "générique" qui associe les utilisateurs et leurs abonnements.

CREATE OR REPLACE VIEW UtilisateurAbonnement AS
SELECT * FROM Utilisateur NATURAL JOIN Abonnement ;
--Test
SELECT * FROM UtilisateurAbonnement;

--Création d'une fonction qui choisit un tuple via login_user demandé à l'utilisateur et l'affiche
DECLARE
        loguser VARCHAR(50);
        
BEGIN
        loguser:='&loguser';
        FOR t IN(SELECT login_user,mdp_user,mail_user,age_user,type_abonnement,date_debut_abonnement,information_abonnement,prix_abonnement FROM UtilisateurAbonnement WHERE UtilisateurAbonnement.login_user=loguser)
        LOOP
        dbms_output.put_line('User Login : '||t.login_user);
        dbms_output.put_line('Mots de passe : '||t.mdp_user);
        dbms_output.put_line('Mail utilisateur : '||t.mail_user);
        dbms_output.put_line('Age de l utilisateur : '||t.age_user);
        dbms_output.put_line('Type d abonnement : '||t.type_abonnement);
        dbms_output.put_line('Date debut de l abonnement : '||t.date_debut_abonnement);
        dbms_output.put_line('Information sur l abonnement : '||t.information_abonnement);
        dbms_output.put_line('Le prix de l abonnement : '||t.prix_abonnement);
        END LOOP;
END;
/


--Vue "générique"  qui associe les Albums et leurs titres.

CREATE OR REPLACE VIEW AlbumTitre AS
SELECT * FROM Titre NATURAL JOIN Album ;
--Test
SELECT * FROM AlbumTitre;

--Création d'une fonction qui choisit un tuple via id_titre demandé à l'utilisateur et l'affiche

DECLARE
        titid VARCHAR(7);
BEGIN
        titid:='&titid';
        FOR t IN(SELECT id_titre,nom_titre,nom_album,nom_artiste,genre_album,label_album,date_sortie_album,nb_titre_album FROM AlbumTitre WHERE AlbumTitre.id_titre=titid)
        LOOP
        dbms_output.put_line('Reference du titre : '||t.id_titre);
        dbms_output.put_line('Le nom du titre : '||t.nom_titre);
        dbms_output.put_line('Le nom de l album: '||t.nom_album);
        dbms_output.put_line('Le nom de l artiste: '||t.nom_artiste);
        dbms_output.put_line('Le genre d album : '||t.genre_album);
        dbms_output.put_line('Le label : '||t.label_album);
        dbms_output.put_line('Date de sortie de l album : '||t.date_sortie_album);
        dbms_output.put_line('Nombre de titre qui compose l album : '||t.nb_titre_album);
        END LOOP;
END;
/
--FIN des vues



SET SERVEROUTPUT OFF
-- Suppression des tables et vues (A enlever avant de rendre (libère espace mémoire))
DROP VIEW  UtilisateurAbonnement ;
DROP VIEW AlbumTitre;
DROP TABLE Utilisateur;
DROP TABLE Abonnement
DROP TABLE Titre;
DROP TABLE Album;
DROP TABLE Avis;

--http://sheikyerbouti.developpez.com/pl_sql/?page=Chap7
--pour mieux comprendre ce que fait SET SERVEROUTPUT OFF
