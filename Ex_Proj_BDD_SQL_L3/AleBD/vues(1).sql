-- 
CREATE OR REPLACE VIEW VueAffichageEmprunt AS
SELECT EXTRACT(year from dateDebR_emp) "Annee", EXTRACT(month from dateDebR_emp) "Mois", num_adh,nom_adh, num_mat, nom_mat 
FROM ADHERENT NATURAL JOIN EMPRUNT NATURAL JOIN MATERIEL
ORDER BY  EXTRACT(year from dateDebR_emp), EXTRACT(month from dateDebR_emp),num_adh ASC;
--
CREATE OR REPLACE VIEW VuetTopEmprunt AS
SELECT num_mat, nom_mat, count( dateDebT_emp ) AS NBemprunt
FROM MATERIEL
NATURAL JOIN EMPRUNT 
Where to_number(to_char(dateDebT_emp, 'j')) > to_number(to_char(CURRENT_DATE, 'j')-365)
GROUP BY num_mat, nom_mat
ORDER BY NBemprunt DESC;
--
CREATE OR REPLACE VIEW VueMatEmprunt
(Nom,Type,Nom_Emprunteur,Prenom_Emprunteur)
AS SELECT nom_mat,type_mat,prenom_adh,nom_adh
FROM MATERIEL mat,ADHERENT adh
WHERE mat.num_mat IN (SELECT num_mat FROM EMPRUNT WHERE dateDebR_emp IS NOT NULL AND dateFinR_emp IS NULL)
AND adh.num_adh IN (SELECT num_adh FROM EMPRUNT WHERE dateDebR_emp IS NOT NULL AND dateFinR_emp IS NULL);
-- 
CREATE OR REPLACE VIEW VueMatHorsService AS
SELECT MATERIEL.num_mat, MATERIEL.nom_mat, MATERIEL.type_mat, MATERIEL.dispo_mat
FROM MATERIEL
WHERE MATERIEL.dispo_mat= 0;


-- Appels des vues --

SELECT * FROM VuetTopEmprunt; 
SELECT * FROM VueMatEmprunt;
SELECT * FROM VueMatHorsService; 
SELECT * FROM VueAffichageEmprunt;



