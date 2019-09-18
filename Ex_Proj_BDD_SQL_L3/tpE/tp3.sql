DROP TABLE inscrip_parcours;
DROP TABLE inscrip_evt;
DROP TABLE compo_parcours;
DROP TABLE avis;
DROP TABLE achats;
DROP TABLE livres;
DROP TABLE clients;
DROP TABLE parcours;

CREATE TABLE clients(
	idcl NUMBER NOT NULL,
	nom VARCHAR2(20),
	pren VARCHAR2(15),
	adr VARCHAR2(30),
	tel VARCHAR2(12),
	PRIMARY KEY (idcl)
	);

CREATE TABLE livres(
	refl VARCHAR2(10) NOT NULL,
	titre VARCHAR2(20),
	auteur VARCHAR2(20),
	genre VARCHAR2(15),
	PRIMARY KEY (refl)
	);

CREATE TABLE achats(
	idcl NUMBER NOT NULL,
	refl VARCHAR2(10) NOT NULL,
	dateachat date NOT NULL CONSTRAINT ck_dateachat CHECK (dateachat >= TO_DATE('01012008', 'ddmmyyyy') AND dateachat <= TO_DATE('31122013', 'ddmmyyyy')),
	FOREIGN KEY (idcl) REFERENCES clients(idcl) ON DELETE CASCADE,
	FOREIGN KEY (refl) REFERENCES livres(refl) ON DELETE CASCADE
	);

CREATE TABLE avis(
	idcl NUMBER NOT NULL,
	refl VARCHAR2(10),
	note NUMBER(4,2),
	commentaire VARCHAR2(50),
	FOREIGN KEY (idcl) REFERENCES clients(idcl) ON DELETE CASCADE,
	FOREIGN KEY (refl) REFERENCES livres(refl) ON DELETE CASCADE
	);

CREATE TABLE parcours(
	idp VARCHAR2(10) NOT NULL,
	intitulep VARCHAR2(15),
	genre VARCHAR2(15),
	date_deb DATE,
	PRIMARY KEY (idp)
);

CREATE TABLE compo_parcours(
	idp VARCHAR2(10) NOT NULL,
	id_evt VARCHAR2(10) NOT NULL,
	PRIMARY KEY (idp, id_evt),
	FOREIGN KEY (idp) REFERENCES parcours(idp) ON DELETE CASCADE
);

CREATE TABLE inscrip_parcours (
	idcl NUMBER NOT NULL,
	idp VARCHAR2(10) NOT NULL,
	PRIMARY KEY (idcl, idp),
	FOREIGN KEY (idcl) REFERENCES clients(idcl) ON DELETE CASCADE,
	FOREIGN KEY (idp) REFERENCES parcours(idp)
);

CREATE TABLE inscrip_evt(
	idcl NUMBER NOT NULL,
	idp VARCHAR2(10) NOT NULL,
	id_evt VARCHAR2(10) NOT NULL,
	PRIMARY KEY (idcl, idp, id_evt), 
	FOREIGN KEY (idcl) REFERENCES clients(idcl) ON DELETE CASCADE,
	FOREIGN KEY (idp) REFERENCES parcours(idp) ON DELETE CASCADE
);




DROP SEQUENCE seqidcl;
CREATE SEQUENCE seqidcl START WITH 2 INCREMENT BY 1;

ALTER TABLE achats ADD prix NUMBER;
ALTER TABLE livres ADD note_moy NUMBER;

INSERT INTO clients (idcl, nom, pren, adr, tel) VALUES (seqidcl.nextVal, 'Star', 'Patrick', '26 rue des Conques','0600000000');
INSERT INTO clients (idcl, nom, pren, adr, tel) VALUES (seqidcl.nextVal, 'Leponge', 'Bob', '24 rue des Conques', '0611111111');
INSERT INTO livres (refl, titre, auteur, genre) VALUES ('001', 'Le suicide francais', 'Eric Zemmour', 'Essai');
INSERT INTO livres (refl, titre, auteur, genre) VALUES ('002', 'La dame de pique', 'Valerie Trierweiler', 'Biographie');
INSERT INTO livres (refl, titre, auteur, genre) VALUES ('003', 'CharlieHebdo no1178', 'Charlie Hebdo', 'Magazine');
INSERT INTO livres (refl, titre, auteur, genre) VALUES ('004', 'Petit ours brun', 'Marie Aubinais', 'Education');
INSERT INTO achats (idcl, refl, dateachat, prix) VALUES ('2', '001', TO_DATE('03102009', 'ddmmyyyy'), 19.99);
INSERT INTO achats (idcl, refl, dateachat, prix) VALUES ('2', '002', TO_DATE('04102009', 'ddmmyyyy'), 12.99);
INSERT INTO achats (idcl, refl, dateachat, prix) VALUES ('2', '003', TO_DATE('05062009', 'ddmmyyyy'), 1.95);
INSERT INTO achats (idcl, refl, dateachat, prix) VALUES ('3', '004', TO_DATE('03102009', 'ddmmyyyy'), 6.50);
INSERT INTO achats (idcl, refl, dateachat, prix) VALUES ('3', '001', TO_DATE('03102009', 'ddmmyyyy'), 19.99 );
INSERT INTO avis (idcl, refl, note, commentaire) VALUES ('2', '001', '13', 'Dit tout haut ce que tous le monde pense tout bas');
INSERT INTO avis (idcl, refl, note, commentaire) VALUES ('3', '001', '12', 'Un livre édifiant');
INSERT INTO avis (idcl, refl, note, commentaire) VALUES ('2', '004', '16', 'Un scenario qui nous tient en haleine');
INSERT INTO avis (idcl, refl, note, commentaire) VALUES ('3', '004', '18', '');
INSERT INTO avis (idcl, refl, note, commentaire) VALUES ('3', '002', '14', 'Un livre poignant');



SET serveroutput ON;
--question 1a
/*
SET serveroutput ON;
DECLARE 
	note_avg NUMBER;
	refLivres VARCHAR2(10);

BEGIN
		refLivres := '&refLivres';
		SELECT AVG(note) INTO note_avg
		FROM avis
		WHERE refl = refLivres;

		UPDATE livres
		SET note_moy = note_avg
		WHERE refl = refLivres;
	
END;
/
*/
--question 1b
/*
SET serveroutput ON;
DECLARE 
	note_avg NUMBER;
	refLivres VARCHAR2(10);

BEGIN
	FOR refLivres IN (SELECT refl FROM livres) LOOP
		SELECT AVG(note) INTO note_avg
		FROM avis
		WHERE refl = refLivres.refl;

		UPDATE livres
		SET note_moy = note_avg
		WHERE refl = refLivres.refl;
	END LOOP;
END;
/
*/

/*
CREATE OR REPLACE PROCEDURE avgAvis() AS

BEGIN
	
	FOR refLivres IN (SELECT refl FROM livres) LOOP
		SELECT AVG(note) INTO note_avg
		FROM avis
		WHERE refl = refLivres.refl;

		UPDATE livres
		SET note_moy = note_avg
		WHERE refl = refLivres.refl;
	END LOOP;
END;
/
*/

--question 1c
SET serveroutput ON;
CREATE OR REPLACE PROCEDURE avgAvis IS
 
	note_avg NUMBER;
	refLivres VARCHAR2(10);
BEGIN
	FOR refLivres IN (SELECT refl FROM livres) LOOP
		SELECT AVG(note) INTO note_avg
		FROM avis
		WHERE refl = refLivres.refl;

		UPDATE livres
		SET note_moy = note_avg
		WHERE refl = refLivres.refl;
	END LOOP;
END avgAvis;
/
EXEC avgAvis;


--trigger, on attend une erreur "table mutating" qui est normale quand on insere un avis, pas quand on crée le trigger

--question 2
/*
CREATE OR REPLACE TRIGGER avis_moy
	AFTER INSERT OR UPDATE
	ON avis
	FOR EACH ROW
 DECLARE
	note_avg NUMBER;
	refLivres VARCHAR2(10);
BEGIN
	FOR refLivres IN (SELECT refl FROM livres) LOOP
		SELECT AVG(note) INTO note_avg
		FROM avis
		WHERE refl = refLivres.refl;

		UPDATE OF livres
		SET note_moy = note_avg
		WHERE refl = refLivres.refl;
	END LOOP;
END;
/


UPDATE avis 
SET note = 5
WHERE idcl = 2; 
*/

/* Réponse question 2
Le trigger renvoie une mutating table error.
*/

--partie 2---------------------------------------------

--question 1
/*
CREATE OR REPLACE TRIGGER avis_ins_row
	BEFORE INSERT
	ON avis
	FOR EACH ROW
DECLARE 
	pas_achete EXCEPTION;
	livreAchete NUMBER;
BEGIN
	SELECT COUNT(*) INTO livreAchete
	FROM  livres
	WHERE :new.refl = livres.refl;

	
		RAISE pas_achete;
	

	EXCEPTION
	WHEN pas_achete THEN
		RAISE_APPLICATION_ERROR (-20001, 'Ce livre n a pas ete achete par le client');
END;
/

INSERT INTO avis (idcl, refl, note, commentaire) VALUES ('3', '003', '18', '');
*/

--question 2

SET serveroutput ON;

CREATE OR REPLACE PROCEDURE updateAvis(
	idcl IN clients.idcl%Type, 
	refl IN livres.refl%Type
)
IS
	choix NUMBER;
	commentaire VARCHAR2(50);
	note NUMBER(4,2);
	CURSOR c1 IS SELECT * FROM avis NATURAL JOIN livres NATURAL JOIN clients
	ligne c1%RowType;

BEGIN
	FOR ligne IN c1 LOOP
		dbms_output.put_line('Que voulez vous modifier\
		1-La note
		2-Le commentaire');
		choix := &choix;
		IF ( choix = 1) THEN
			dbms_output.put_line('Entrez un commentaire');
			commentaire:='&commentaire';
		ELSIF (choix = 2) THEN
			dbms_output.put_line('Entrez une note');
			note:='&note';
		END IF;

		UPDATE avis
		SET avis.commentaire = commentaire
		SET avis.note = note
		WHERE avis.idcl=idcl;
	END LOOP;
END updateAvis;
/


EXEC updateAvis(1, 001);

SELECT * FROM avis;

show errors;







