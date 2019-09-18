CREATE OR REPLACE PROCEDURE useMat
AS 
	numM MATERIEL.NUM_MAT%TYPE;
  numE EMPRUNT.NUM_MAT%TYPE;

	nom MATERIEL.NOM_MAT%TYPE;
  
  dateMD NUMERIC;

  dateM MATERIEL.DATE_MAT%TYPE; 

  dateEC NUMERIC;
  dateED MATERIEL.DATE_MAT%TYPE;
  dateEF MATERIEL.DATE_MAT%TYPE;


	CURSOR c_T IS SELECT NUM_MAT, NOM_MAT, DATE_MAT INTO numM, nom, dateM FROM  MATERIEL;
  CURSOR c_U IS SELECT EMPRUNT.NUM_MAT,DATEDEBR_EMP ,DATEFINR_EMP  
  FROM EMPRUNT
  INNER JOIN MATERIEL on EMPRUNT.NUM_MAT = MATERIEL.NUM_MAT
  WHERE DATEDEBR_EMP < CURRENT_DATE;

BEGIN
 
  OPEN c_T;
    LOOP
       FETCH c_T INTO numM, nom , dateM;
       EXIT WHEN c_T%NOTFOUND; 
        dateMD :=  to_number(to_char(sysdate, 'j'))-to_number(to_char(to_date(dateM),'j'));
    		dbms_output.put_line( '==== Nom : ' || nom || ' Num :' || numM || ' ====');
    		dbms_output.put_line( '  Temps ecoule depuis l acquisition : ' || dateMD || '  en jour(s)');
			   dateEC := 0;
        OPEN c_U; 
          LOOP 
           FETCH c_U INTO numE, dateED, dateEF;
            IF(numE = numM) THEN
              IF(dateEF IS NULL) THEN
                
                dateEC := dateEC + to_number(to_char((CURRENT_DATE-dateED), '9999.99'));
              ELSE 
                dateEC := dateEC + to_number(to_char((dateEF-dateED), '9999.99'));
              END IF;  
               
            END IF;
            IF c_U%NOTFOUND THEN
              dbms_output.put_line( 'Temps total utilisation :' || dateEC );
              dbms_output.put_line( 'Taux utilisation ' || to_char((dateEC/dateMD)*100,'9999.99') || '%'); 
              dbms_output.put_line( '---------------------------------------------------------------------'); 
              EXIT; 
            END IF;  

          END LOOP;   
        CLOSE c_U;    
       EXIT WHEN numM IS NULL;   
    END LOOP;

  CLOSE c_T;	

END useMat;
/
  
show errors
