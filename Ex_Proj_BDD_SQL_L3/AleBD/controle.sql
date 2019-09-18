
CREATE ROLE agriculteur;


GRANT INSERT(dateDebT_emp, num_adh, num_mat,dateFinT_emp), UPDATE(remarque_empr) ON EMPRUNT TO agriculteur;
GRANT SELECT on MATERIEL to agriculteur;
GRANT SELECT, INSERT, UPDATE on ENTRETIEN to agriculteur;


GRANT agriculteur to L3_85;


CREATE ROLE secretairebis;
GRANT SELECT, UPDATE(dateDebT_emp,num_mat,dateFinT_emp,dateDebR_emp,dateFinR_emp) on EMPRUNT to secretairebis;
GRANT SELECT, INSERT, UPDATE on MATERIEL to secretairebis;
GRANT SELECT, INSERT, UPDATE on ADHERENT to secretairebis;
GRANT SELECT on ENTRETIEN to secretairebis;
GRANT secretairebis to L3_62;

CREATE ROLE conseiladministration;

GRANT ALL ON MATERIEL;
GRANT ALL ON MATERIEL;
GRANT ALL ON MATERIEL;
GRANT ALL ON MATERIEL;

GRANT conseiladministration TO L3_86;