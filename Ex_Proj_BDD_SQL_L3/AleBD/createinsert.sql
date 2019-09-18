
DROP TABLE EMPRUNT;
DROP TABLE ENTRETIEN;
DROP TABLE MATERIEL;
DROP TABLE ADHERENT;

CREATE TABLE MATERIEL(
num_mat int, 
nom_mat varchar2(20), 
type_mat varchar2(50),
date_mat date,
dispo_mat int,
primary key(num_mat)
);
DROP SEQUENCE materiel_sequence;
CREATE SEQUENCE materiel_sequence START WITH 1 INCREMENT BY 1;

CREATE TABLE ADHERENT(
num_adh int NOT NULL, 
prenom_adh varchar2(30),
nom_adh varchar2(20),
mail_adh varchar2(30),
telephone_adh int,
adresse_adh varchar2(30),
ville_adh varchar2(30),
primary key(num_adh)
);
DROP SEQUENCE adherent_sequence;
CREATE SEQUENCE adherent_sequence START WITH 1 INCREMENT BY 1;

CREATE TABLE EMPRUNT(
dateDebT_emp date, 
num_mat int,
num_adh int,
dateFinT_emp date,
dateDebR_emp date,
dateFinR_emp date,
remarque_empr varchar2(200),
primary key(dateDebT_emp,num_mat,num_adh),
CONSTRAINT materiel_emprunt foreign key (num_mat) references MATERIEL (num_mat) ON DELETE CASCADE ,
CONSTRAINT adherent_emprunt foreign key (num_adh) references ADHERENT (num_adh)
);

CREATE TABLE ENTRETIEN(
date_entr date, 
type_entr varchar2(20),
num_mat int,
remarque_entr varchar(200),
primary key(date_entr,type_entr,num_mat),
CONSTRAINT materiel_entretien foreign key (num_mat) references MATERIEL (num_mat)ON DELETE CASCADE 
);

CREATE OR REPLACE TRIGGER AI_materiel
BEFORE INSERT
ON MATERIEL
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT materiel_sequence.nextval INTO :NEW.num_mat FROM dual;
END;
/
CREATE OR REPLACE TRIGGER AI_adherent
BEFORE INSERT
ON ADHERENT
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT adherent_sequence.nextval INTO :NEW.num_adh FROM dual;
END;
/

ALTER TABLE EMPRUNT ADD CHECK(dateDebT_emp>=TO_DATE('2000-01-01','YYYY-MM-DD'));
ALTER TABLE EMPRUNT ADD CHECK(dateFinT_emp>=TO_DATE('2000-01-01','YYYY-MM-DD'));
ALTER TABLE EMPRUNT ADD CHECK(dateDebR_emp>=TO_DATE('2000-01-01','YYYY-MM-DD'));
ALTER TABLE EMPRUNT ADD CHECK(dateFinR_emp>=TO_DATE('2000-01-01','YYYY-MM-DD'));

INSERT INTO MATERIEL VALUES(null,'John deere 8800', 'ensileuse', TO_DATE('2009-12-30','YYYY-MM-DD'),1);
INSERT INTO MATERIEL VALUES(null, 'John deere S685', 'moissoneuse-batteuse',TO_DATE('2010-10-12','YYYY-MM-DD'), 1);
INSERT INTO MATERIEL VALUES(null, 'John deere 9620R', 'tracteur', TO_DATE('2011-11-21','YYYY-MM-DD'),1);
INSERT INTO MATERIEL VALUES(null, 'John deere R962i', 'pulvérisateur',TO_DATE('2012-01-15','YYYY-MM-DD'),1);
INSERT INTO MATERIEL VALUES(null, 'Claas VARIANT 370', 'presse à balles rondes',TO_DATE('2013-02-15','YYYY-MM-DD'),1);
INSERT INTO MATERIEL VALUES(null, 'CAT  TH407C', 'télescopique',TO_DATE('2013-11-25','YYYY-MM-DD'),1);
INSERT INTO MATERIEL VALUES(null, 'Claas  CARGOS 700', 'remorque',TO_DATE('2014-02-17','YYYY-MM-DD'),1);
INSERT INTO MATERIEL VALUES(null, 'Claas DISCO', 'faucheuse',TO_DATE('2014-09-29','YYYY-MM-DD'),1);
INSERT INTO MATERIEL VALUES(null, 'Claas ARION 650-530', 'tracteur',TO_DATE('2015-01-01','YYYY-MM-DD'),1);

INSERT INTO ADHERENT VALUES(null, 'Michel', 'Dubois','michel.dubois@gmail.com',0240703985, 'La grande motte', 'Noyant la gravoyère');
INSERT INTO ADHERENT VALUES(null, 'Bernard', 'Dupont','dupont-bernard@gmail.com',0243548525, 'La fromanderie', 'Saint quentin les anges');
INSERT INTO ADHERENT VALUES(null, 'André', 'Dupond','andredupond@orange.com',0251254595,'Chemin du fou', 'bazoges en paillers');
INSERT INTO ADHERENT VALUES(null, 'Franck', 'Duclos','duclos.f@gmail.com',0254986532,'La tricotière', 'Bouaye');
INSERT INTO ADHERENT VALUES(null, 'Mickaël', 'Gillot','mick.gill@bbox.com',0252525252,'La leu', 'Mée');
INSERT INTO ADHERENT VALUES(null, 'Gérard', 'Grosbois','grosbois-g.dubois@gmail.com',0244521245,'La morellerie', 'Le cellier');
INSERT INTO ADHERENT VALUES(null, 'Micheline', 'Ptitebranch','michmich_du_85@yahoo.com',0263520141, 'chemin perdu', 'Pouzauges');



INSERT INTO EMPRUNT VALUES(TO_DATE('2014-10-15','YYYY-MM-DD'),7,1,TO_DATE('2014-10-30','YYYY-MM-DD'),TO_DATE('2014-10-16','YYYY-MM-DD'),TO_DATE('2014-10-28','YYYY-MM-DD'), 'La charette commence à rouiller');
INSERT INTO EMPRUNT VALUES(TO_DATE('2015-05-02','YYYY-MM-DD'),2,1,TO_DATE('2015-05-17','YYYY-MM-DD'),TO_DATE('2015-05-02','YYYY-MM-DD'),TO_DATE('2015-05-17','YYYY-MM-DD'), 'J ai bu un verre avec Monique');
INSERT INTO EMPRUNT VALUES(TO_DATE('2015-08-12','YYYY-MM-DD'),9,2,TO_DATE('2015-08-27','YYYY-MM-DD'),TO_DATE('2015-08-15','YYYY-MM-DD'),TO_DATE('2015-08-27','YYYY-MM-DD'), 'Ils nous volent notre travail');
INSERT INTO EMPRUNT VALUES(TO_DATE('2015-08-27','YYYY-MM-DD'),3,3,TO_DATE('2015-09-11','YYYY-MM-DD'),TO_DATE('2015-08-27','YYYY-MM-DD'),TO_DATE('2015-09-11','YYYY-MM-DD'), 'En revenant de Montaigue, j ai vu la digue');
INSERT INTO EMPRUNT VALUES(TO_DATE('2015-10-01','YYYY-MM-DD'),8,3,TO_DATE('2015-10-16','YYYY-MM-DD'),TO_DATE('2015-10-01','YYYY-MM-DD'),TO_DATE('2015-10-16','YYYY-MM-DD'), 'La digue de qui ?');
INSERT INTO EMPRUNT VALUES(TO_DATE('2015-11-02','YYYY-MM-DD'),7,4,TO_DATE('2015-11-17','YYYY-MM-DD'),TO_DATE('2015-11-05','YYYY-MM-DD'),TO_DATE('2015-11-17','YYYY-MM-DD'), 'La digue du curé');
INSERT INTO EMPRUNT VALUES(TO_DATE('2016-02-29','YYYY-MM-DD'),7,3,TO_DATE('2016-03-10','YYYY-MM-DD'),TO_DATE('2016-03-01','YYYY-MM-DD'),NULL, NULL);


INSERT INTO ENTRETIEN VALUES(TO_DATE('2014-10-19','YYYY-MM-DD'),'Maintenance',7,'La charette était rouillée');
INSERT INTO ENTRETIEN VALUES(TO_DATE('2015-05-14','YYYY-MM-DD'),'Reparation',2,'Problème dans la direction');
INSERT INTO ENTRETIEN VALUES(TO_DATE('2015-08-30','YYYY-MM-DD'),'Maintenance',8,'Affutage des lames');
INSERT INTO ENTRETIEN VALUES(TO_DATE('2015-08-30','YYYY-MM-DD'),'Maintenance',3,'Changement de la roue avant gauche');
