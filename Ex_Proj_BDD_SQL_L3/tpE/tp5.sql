# Q1
#réponse à la question 1



desc facts;
desc dates;
desc authors;
desc collaborations;
desc publications;
desc squads; 
desc supports;


#explain plan for select * from facts;
#Q2
SELECT count(*) FROM facts;
SELECT count(*) FROM dates;
SELECT count(*) FROM authors;
SELECT count(*) FROM collaborations;
SELECT count(*) FROM publications;
SELECT count(*) FROM squads;
SELECT count(*) FROM supports;

#Visualisation du plan d'exécution d'une requête

#Q1
#R1
explain plan for select title from publications where nb_pages > 20 ;
select * from table(dbms_xplan.display);

#R2
explain plan for select title from publications natural join facts where
date_id = 2008 ;
select * from table(dbms_xplan.display);

#R3
explain plan for 
select title 
from publications 
where publication_id in (select publication_id from facts where date_id = 2008);
select * from table(dbms_xplan.display);

#R4
explain plan for 
select title 
from publications natural join facts natural join collaborations natural join authors 
where last_name= 'Rosenthal' ;
select * from table(dbms_xplan.display);





#Q2
#R1
explain plan for select title from publications1 where nb_pages > 20 ;
select * from table(dbms_xplan.display);

#R2
explain plan for select title from publications1 natural join facts where
date_id = 2008 ;
select * from table(dbms_xplan.display);

#R3
explain plan for 
select title 
from publications1 
where publication_id in (select publication_id from facts where date_id = 2008);
select * from table(dbms_xplan.display);

#R4
explain plan for 
select title 
from publications1 natural join facts natural join collaborations natural join authors 
where last_name= 'Rosenthal' ;
select * from table(dbms_xplan.display);




#Les index

#Q1
SELECT index_name, table_name, column_name 
FROM all_ind_columns 
WHERE index_owner = 'ADMIN_M2';