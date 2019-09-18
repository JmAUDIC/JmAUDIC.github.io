

-- TRIGGER PERMETTANT DE VERIFIER QU'UN MATERIEL A BIEN ETE RENDU ET EST EN SERVICE (dispo_mat=1) --
CREATE OR REPLACE TRIGGER before_inUp_RenduDispo_EMPRUNT BEFORE INSERT OR UPDATE 
ON EMPRUNT FOR EACH ROW

DECLARE 

-- DECLARATION VARIABLES VERIFICATION RENDU -- 
dateFR EMPRUNT.DATEFINR_EMP%TYPE; 
dateDR EMPRUNT.DATEFINR_EMP%TYPE; 
numM MATERIEL.NUM_MAT%TYPE;
trouve INTEGER; 
nonRendu EXCEPTION;

CURSOR c_E IS SELECT NUM_MAT, DATEFINR_EMP, DATEDEBR_EMP INTO numM, dateFR, dateDR FROM EMPRUNT ORDER BY DATEFINR_EMP DESC; 
-- Le order by permet de récupérer le dernier emprunt plus rapidement pour le nouveau materiel --


-- DECLARATION VARIABLES VERIFICATION DISPONIBILITE -- 

dispo MATERIEL.DISPO_MAT%TYPE;
nonDispo EXCEPTION;

CURSOR c_M IS SELECT NUM_MAT, DISPO_MAT INTO numM, dispo FROM MATERIEL; 


BEGIN

-- PARTIE RENDU --
 trouve := 0; 
 OPEN c_E;
    LOOP
       FETCH c_E INTO numM , dateFR , dateDR;
       EXIT WHEN c_E%NOTFOUND; 	
       	IF(numM= :NEW.NUM_MAT) THEN 

       		trouve := 1; 
       		dbms_output.put_line('trouve');
       		dbms_output.put_line(c_E%ROWCOUNT);

       		IF(dateFR IS NULL AND dateDR IS NOT NULL) THEN 
       		 	RAISE nonRendu; 
       		END IF; 
       	END IF;	
       EXIT WHEN numM IS NULL OR trouve = 1 ;   
    END LOOP;

  CLOSE c_E;	



-- PARTIE DISPO -- 
  trouve := 0; 
  
  OPEN c_M;
    LOOP
       FETCH c_M INTO numM , dispo;
       EXIT WHEN c_M%NOTFOUND;  
        IF(numM= :OLD.NUM_MAT) THEN 

          trouve := 1; 
          dbms_output.put_line('trouve');
          dbms_output.put_line(c_M%ROWCOUNT);

          IF(dispo = 0) THEN 
            RAISE nonDispo; 
          END IF; 
        END IF; 
       EXIT WHEN numM IS NULL OR trouve = 1 ;   
    END LOOP;

  CLOSE c_M;  

-- PARTIE EXCEPTION -- 

 EXCEPTION
   WHEN nonDispo THEN  RAISE_APPLICATION_ERROR(- 20001, 'Materiel non disponible !');
   WHEN nonRendu THEN  RAISE_APPLICATION_ERROR(- 20002, 'Materiel non rendu, emprunt impossible');

END; 
/

-- TRIGGER PERMETTANT DE VERIFIER LES DIFFERENTES CONTRAINTES DE DATES -- 
CREATE OR REPLACE TRIGGER before_inUp_DatesCheck_EMPRUNT BEFORE INSERT OR UPDATE 
ON EMPRUNT FOR EACH ROW

BEGIN

IF (:new.dateDebT_emp > :new.dateFinT_emp) 
THEN RAISE_APPLICATION_ERROR(- 20001, 'La date théorique de début doit être antérieure ou égale à la date de fin théorique');
END IF;

IF (:new.dateDebR_emp > :new.dateFinR_emp) THEN 
	IF (:new.dateFinR_emp != NULL)
		THEN RAISE_APPLICATION_ERROR(- 20002, 'La date réelle de début doit être antérieure ou égale à la date de fin réelle');
	END IF;	
END IF;

IF (:new.dateDebR_emp > :new.dateDebT_emp)
THEN RAISE_APPLICATION_ERROR(- 20003, 'La date réelle de début doit être postérieure ou égale à la date de début théorique');
END IF;


END; 
/