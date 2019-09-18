CREATE OR REPLACE PROCEDURE countMat
AS 
	total INTEGER;
	nom MATERIEL.TYPE_MAT%TYPE;

	CURSOR c_T IS SELECT TYPE_MAT,Count(*)  INTO total, nom FROM  MATERIEL GROUP BY TYPE_MAT ORDER BY TYPE_MAT ;
 
BEGIN

  OPEN c_T;
    dbms_output.put_line('Affichage du materiel existant : ');
    LOOP
       FETCH c_T INTO nom, total;
       EXIT WHEN c_T%NOTFOUND; 
    		dbms_output.put_line( 'Type : ' || nom || ' Nombre :' || total);
			EXIT WHEN total = 0;   
    END LOOP;

  CLOSE c_T;	

END countMat;
/
  
show errors
