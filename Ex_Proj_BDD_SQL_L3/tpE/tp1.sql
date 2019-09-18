DROP TABLE avis;
DROP TABLE achats;
DROP TABLE livres;
DROP TABLE clients;

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

INSERT INTO clients (idcl, nom, pren, adr, tel) VALUES ('01', 'Star', 'Patrick', '26 rue des Conques','0600000000');
INSERT INTO clients (idcl, nom, pren, adr, tel) VALUES ('02', 'Leponge', 'Bob', '24 rue des Conques', '0611111111');
INSERT INTO livres (refl, titre, auteur, genre) VALUES ('001', 'Le suicide francais', 'Eric Zemmour', 'Essai');
INSERT INTO livres (refl, titre, auteur, genre) VALUES ('002', 'La dame de pique', 'Valerie Trierweiler', 'Biographie');
INSERT INTO livres (refl, titre, auteur, genre) VALUES ('003', 'CharlieHebdo no1178', 'Charlie Hebdo', 'Magazine');
INSERT INTO livres (refl, titre, auteur, genre) VALUES ('004', 'Petit ours brun', 'Marie Aubinais', 'Education');
INSERT INTO achats (idcl, refl, dateachat) VALUES ('01', '001', TO_DATE('03102009', 'ddmmyyyy') );
INSERT INTO achats (idcl, refl, dateachat) VALUES ('01', '002', TO_DATE('04102009', 'ddmmyyyy') );
INSERT INTO achats (idcl, refl, dateachat) VALUES ('01', '003', TO_DATE('05062009', 'ddmmyyyy') );
INSERT INTO achats (idcl, refl, dateachat) VALUES ('01', '004', TO_DATE('03102009', 'ddmmyyyy') );
INSERT INTO achats (idcl, refl, dateachat) VALUES ('02', '001', TO_DATE('03102009', 'ddmmyyyy') );
INSERT INTO avis (idcl, refl, note, commentaire) VALUES ('01', '001', '13', 'Dit tout haut ce que tout le monde pense tout bas');
INSERT INTO avis (idcl, refl, note, commentaire) VALUES ('02', '001', '12', 'Un livre édifiant');
INSERT INTO avis (idcl, refl, note, commentaire) VALUES ('01', '004', '16', 'Un scénario qui nous tien en haleine');
INSERT INTO avis (idcl, refl, note, commentaire) VALUES ('02', '004', '18', '');
INSERT INTO avis (idcl, refl, note, commentaire) VALUES ('02', '002', '14', 'Un livre poignant');

#Livre avec le max de ventes
SELECT titre, auteur, genre, COUNT(refl) cpt
FROM achats NATURAL JOIN livres
GROUP BY titre
HAVING COUNT(refl) >= 2 ORDER BY COUNT(refl) DESC;

#Moyenne des notes supérieures à 16
SELECT titre, AVG(note)
FROM livres NATURAL JOIN avis
GROUP BY titre
HAVING AVG(note) > 16;

#Clients qui n'ont pas renseigné le commentaire
SELECT pren, titre, note
FROM livres NATURAL JOIN clients NATURAL JOIN avis
WHERE commentaire IS NULL;

