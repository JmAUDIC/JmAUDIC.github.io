      ******************************************************************
***********GROUPE 9
***********AUDIC Jean-Marie
***********GAUDICHEAU Pierre
***********SECK Myriam
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COURSPART.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.


       SELECT feleve ASSIGN TO "eleve.dat"
       ORGANIZATION indexed
       ACCESS IS dynamic
       FILE STATUS IS fel_stat
       RECORD KEY IS fel_idEL
       ALTERNATE RECORD KEY IS fel_classe WITH DUPLICATES
       ALTERNATE RECORD KEY IS fel_ville WITH DUPLICATES
       ALTERNATE RECORD KEY IS fel_dispo WITH DUPLICATES.

       SELECT fenseignant ASSIGN TO "enseignant.dat"
       ORGANIZATION indexed
       ACCESS IS dynamic
       FILE STATUS IS fen_stat
       RECORD KEY IS fen_idEn
       ALTERNATE RECORD KEY IS fen_matiere WITH DUPLICATES
       ALTERNATE RECORD KEY IS fen_ville WITH DUPLICATES
       ALTERNATE RECORD KEY IS fen_dispo WITH DUPLICATES.

       SELECT freserv ASSIGN TO "reserv.dat"
       ORGANIZATION indexed
       ACCESS IS dynamic
       FILE STATUS IS fr_stat
       RECORD KEY IS fr_cle
       ALTERNATE RECORD KEY IS fr_idEl WITH DUPLICATES
       ALTERNATE RECORD KEY IS fr_idEn WITH DUPLICATES
       ALTERNATE RECORD KEY IS fr_numSem WITH DUPLICATES.

       SELECT favis ASSIGN TO "avis.dat"
       ORGANIZATION indexed
       ACCESS IS dynamic
       FILE STATUS IS fa_stat
       RECORD KEY IS fa_cle
       ALTERNATE RECORD KEY IS fa_idEl WITH DUPLICATES
       ALTERNATE RECORD KEY IS fa_idEn WITH DUPLICATES.


       DATA DIVISION.
       FILE SECTION.

       FD feleve.
       01 Televe.
         02 fel_idEl PIC 9(4).
         02 fel_nom PIC A(20).
         02 fel_prenom PIC A(20).
         02 fel_classe PIC X(15).
         02 fel_ville PIC A(10).
         02 fel_dispo PIC 9(1).

       FD fenseignant.
       01 Tenseignant.
         02 fen_idEn PIC 9(4).
         02 fen_nom PIC A(20).
         02 fen_prenom PIC A(20).
         02 fen_matiere PIC X(20).
         02 fen_ville PIC A(10).
         02 fen_nbHMax PIC 9(2).
         02 fen_dispo PIC 9(1).

       FD freserv.
       01 Treserv.
         02 fr_cle.
           03 fr_idEl PIC 9(4).
           03 fr_idEn PIC 9(4).
           03 fr_numSem PIC 9(2).
         02 fr_nbHeure PIC 9(3).
         02 fr_matiere PIC X(20).

       FD favis.
       01 Tavis.
         02 fa_cle.
           03 fa_idEl PIC 9(4).
           03 fa_idEn PIC 9(4).
         02 fa_note PIC 9(2).
         02 fa_commentaire PIC A(50).

       WORKING-STORAGE SECTION.
       77 fel_stat PIC 9(2).
       77 fen_stat PIC 9(2).
       77 fr_stat PIC 9(2).
       77 fa_stat PIC 9(2).

       77 Wdem PIC 9(1).
       77 Wnb PIC 9(1).
       77 Wnb2 PIC 9(1).
       77 Wnb3 PIC 9(1).
       77 Wfin PIC 9(1).
       77 Wfin2 PIC 9(1).
       77 Wfin3 PIC 9(1).
       77 Wel PIC 9(1).
       77 Wel2 PIC 9(1).
       77 Wel3 PIC 9(1).
       77 Wid PIC 9(4).
       77 Wid2 PIC 9(4).
       77 Wh PIC 9(2).
       77 WhTotalSem PIC 9(2).
       77 Wville PIC A(15).
       77 Wclasse PIC X(15).
       77 Wmatiere PIC X(20).
       77 WnumSem PIC 9(2).
       77 WensDispo PIC 9(1).
       77 WnbHTotal PIC 9(4).
       77 Wmontant PIC 9(5).
       77 Wmontant2 PIC 9(5).
       77 Wmontant3 PIC 9(5).
       77 Wfact PIC 9(2).
       77 WnoteTotal PIC 9(3).
       77 WnbNote PIC 9(2).
       77 WnoteMoy PIC 9(1).
       77 WensOk PIC 9(1).

       PROCEDURE DIVISION.
       PERFORM MENU.

       MENU.
       DISPLAY"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
       DISPLAY"XXXXXXXXXXXXXXXXX  MENU PRINCIPAL  XXXXXXXXXXXXXXXXXXXXX"
       DISPLAY"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
       DISPLAY"________________________________________________________"
       DISPLAY"|Selectionnez un chiffre en fonction de l'action voulue|"
       DISPLAY"|                                                      |"
       DISPLAY"| 0-Quitter l'application                              |"
       DISPLAY"| 1-Creation des donnees                               |"
       DISPLAY"| 2-Acceder au Menu de gestion des Eleves              |"
       DISPLAY"| 3-Acceder au Menu de gestion des Enseigants          |"
       DISPLAY"| 4-Acceder au Menu de gestion des Reservations        |"
       DISPLAY"| 5-Acceder au Menu de gestion des Avis                |"
       DISPLAY"| 6-Fonctions statistique                              |"
       DISPLAY"|______________________________________________________|"
       ACCEPT Wnb
       EVALUATE Wnb

       WHEN 0 PERFORM QUITTER
       WHEN 1 PERFORM DAT
       WHEN 2 PERFORM MENU_ELEVE
       WHEN 3 PERFORM MENU_ENSEIGNANT
       WHEN 4 PERFORM MENU_RESERVATION
       WHEN 5 PERFORM MENU_AVIS
       WHEN 6 PERFORM MENU_STAT
       WHEN OTHER
       DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
       DISPLAY "Entrée non valide"
       DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
       END-EVALUATE
       PERFORM MENU.


       QUITTER.
       DISPLAY "Vouler vous Quitter le programme? (1 : oui / 0 : sinon)"
       ACCEPT Wnb
       EVALUATE Wnb
       WHEN 0 PERFORM MENU
       WHEN 1 STOP RUN
       WHEN OTHER PERFORM QUITTER.

       DAT.

       OPEN I-O feleve
       IF fel_stat=35 THEN
               OPEN OUTPUT feleve
       END-IF
       OPEN I-O fenseignant
       IF fen_stat =35 THEN
               OPEN OUTPUT fenseignant
       END-IF
       OPEN I-O freserv
       IF fr_stat =35 THEN
               OPEN OUTPUT freserv
       END-IF
       OPEN I-O favis
       IF fa_stat =35 THEN
               OPEN OUTPUT favis
       END-IF
       CLOSE feleve
       CLOSE fenseignant
       CLOSE freserv
       CLOSE favis.

       MENU_ELEVE.
       MOVE 0 TO Wnb
       DISPLAY " xxxx  MENU ELEVE  xxxx "
       DISPLAY"________________________________________________________"
       DISPLAY"|Selectionnez un chiffre en fonction de l'action voulue|"
       DISPLAY"|                                                      |"
       DISPLAY"| 0-Revenir au menu principal                          |"
       DISPLAY"| 1-Ajouter un eleve                                   |"
       DISPLAY"| 2-Afficher les eleves                                |"
       DISPLAY"| 3-Modifier les donnees d'un eleve                    |"
       DISPLAY"| 4-Supprimer un eleve                                 |"
       DISPLAY"| 5-Rendre un Eleve Indisponible                       |"
       DISPLAY"| 6-Rendre un Eleve disponible                         |"
       DISPLAY"| 7-Afficher les Eleves indisponible                   |"
       DISPLAY"|______________________________________________________|"
       ACCEPT Wnb
       EVALUATE Wnb
         WHEN 0 PERFORM MENU
         WHEN 1 PERFORM AJOUT_ELEVE
         WHEN 2 PERFORM AFFICHER_ELEVES
         WHEN 3 PERFORM MODIFIER_ELEVE
         WHEN 4 PERFORM SUPPRIMER_ELEVE
         WHEN 5 PERFORM INDISPO_ELEVE
         WHEN 6 PERFORM DISPO_ELEVE
         WHEN 7 PERFORM AFFICHER_ELEVE_INDISPO
         WHEN OTHER
          DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
          DISPLAY "Entrée non valide"
          DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
       END-EVALUATE
       PERFORM MENU_ELEVE.


       AJOUT_ELEVE.
       OPEN INPUT feleve
       MOVE 0 TO Wfin
       MOVE 0 TO Wid
       MOVE 0 TO Wid2
       PERFORM WITH TEST AFTER UNTIL Wfin = 1
          READ feleve NEXT
          AT END MOVE 1 TO Wfin
          NOT AT END
            IF Wid < fel_idEl THEN
              MOVE fel_idEl TO Wid2
              SUBTRACT Wid FROM Wid2
              IF Wid2 > 1
                 MOVE 1 TO Wfin
              ELSE
                 MOVE fel_idEl TO Wid
              END-IF
            END-IF
          END-READ
       END-PERFORM
       ADD 1 TO Wid
       CLOSE feleve
       OPEN I-O feleve
       MOVE Wid TO fel_idEl
       DISPLAY 'Nom de l eleve'
       ACCEPT fel_nom
       DISPLAY 'Prenom de l eleve'
       ACCEPT fel_prenom
       MOVE 1 TO fel_dispo
       PERFORM DEMANDE_CLASSE
       MOVE Wclasse TO fel_classe
       PERFORM DEMANDE_VILLE
       MOVE Wville TO fel_ville
       WRITE Televe
        INVALID KEY
         DISPLAY 'Ajout impossible'
        NOT INVALID KEY
         DISPLAY 'Eleve enregistre'
       END-WRITE
       CLOSE feleve.

       AFFICHER_ELEVES.
       MOVE 0 TO Wfin
       PERFORM WITH TEST AFTER UNTIL Wfin>=1 AND WfIN<=4
         DISPLAY 'Choisissez en fonction de l action désirée'
         DISPLAY '1: Afficher l ensemble des eleves'
         DISPLAY '2: Afficher l ensemble des eleves de Nantes'
         DISPLAY '3: Afficher l ensemble des eleves de Angers'
         DISPLAY "4: Afficher l ensemble des eleves d'un niveau donne"
         ACCEPT Wfin
       END-PERFORM
       EVALUATE Wfin
         WHEN 2 MOVE 'Nantes' TO Wville
         WHEN 3 MOVE 'Angers' TO Wville
         WHEN 4 PERFORM DEMANDE_CLASSE
       END-EVALUATE
       OPEN INPUT feleve
       IF Wfin=1
           DISPLAY' '
           DISPLAY'Liste des eleves (disponibles uniquement)'
           DISPLAY' '
           MOVE 1 TO fel_dispo
           START feleve KEY IS = fel_dispo
             INVALID KEY
               DISPLAY "Pas d'eleve disponibles actuellement"
             NOT INVALID KEY
               MOVE 0 TO Wfin
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
               READ feleve NEXT
                 AT END
                   MOVE 1 TO Wfin
                 NOT AT END
                   IF fel_dispo=1
                     PERFORM AFFICHER_DETAILS_ELEVE
                   ELSE
                     MOVE 1 TO Wfin
                   END-IF
               END-PERFORM
           END-START
       END-IF
       IF Wfin=2 OR Wfin=3
           DISPLAY' '
           DISPLAY'Liste des eleves de ' Wville
           DISPLAY' '
           MOVE Wville TO fel_ville
           START feleve KEY IS = fel_ville
             INVALID KEY
               DISPLAY "Pas d'elEve de cette ville"
             NOT INVALID KEY
               MOVE 0 TO Wfin
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                 READ feleve NEXT
                   AT END
                     MOVE 1 TO Wfin
                   NOT AT END
                     IF fel_ville=Wville
                       IF fel_dispo=1
                         PERFORM AFFICHER_DETAILS_ELEVE
                       END-IF
                     ELSE
                       MOVE 1 TO Wfin
                     END-IF
                 END-READ
               END-PERFORM
           END-START
       END-IF
       IF Wfin=4
           DISPLAY' '
           DISPLAY'Liste des eleves de ' Wclasse
           DISPLAY' '
           MOVE Wclasse TO fel_classe
           START feleve KEY IS = fel_classe
             INVALID KEY
               DISPLAY "Pas d'eleve de ce niveau"
             NOT INVALID KEY
               MOVE 0 TO Wfin
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                 READ feleve NEXT
                   AT END
                     MOVE 1 TO Wfin
                   NOT AT END
                     IF fel_classe=Wclasse
                       IF fel_dispo=1
                         PERFORM AFFICHER_DETAILS_ELEVE
                       END-IF
                     ELSE
                       MOVE 1 TO Wfin
                     END-IF
                 END-READ
               END-PERFORM
           END-START
       END-IF
       CLOSE feleve.

       AFFICHER_ELEVE_INDISPO.
       OPEN INPUT feleve
       DISPLAY "Liste des eleves rendus indisponibles"
       MOVE 0 TO fel_dispo
       START feleve KEY IS = fel_dispo
       INVALID KEY
         DISPLAY "Pas d'eleves indisponibles"
       NOT INVALID KEY
         MOVE 0 TO Wfin
         PERFORM WITH TEST AFTER UNTIL Wfin=1
         READ feleve
         AT END
           MOVE 1 TO Wfin
         NOT AT END
           IF fel_dispo=0
             PERFORM AFFICHER_DETAILS_ELEVE
           ELSE
             MOVE 1 TO Wfin
           END-IF
         END-READ
       END-PERFORM
       CLOSE feleve.



*********Fonctions de codes récurents
       AFFICHER_DETAILS_ELEVE.
           DISPLAY "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx "
           DISPLAY "Identifiant: ", fel_idEl,
           DISPLAY "Nom: ", fel_nom,
           DISPLAY "Prenom: ", fel_prenom
           DISPLAY "Classe: ", fel_classe
           DISPLAY "Ville: ", fel_ville
     ******DISPLAY "dISPO: ", fel_dispo
           DISPLAY "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ".

       DEMANDE_CLASSE.
       MOVE 0 TO Wnb
       PERFORM WITH TEST AFTER UNTIL Wnb>0 AND Wnb<8
            DISPLAY 'Classe de l eleve? (Entrez le num correspondant)'
            DISPLAY '1: 6eme'
            DISPLAY '2: 5eme'
            DISPLAY '3: 4eme'
            DISPLAY '4: 3eme'
            DISPLAY '5: Seconde'
            DISPLAY '6: Premiere'
            DISPLAY '7: Terminale'
            ACCEPT Wnb
       END-PERFORM
       EVALUATE Wnb
            WHEN 1 MOVE '6eme' TO Wclasse
            WHEN 2 MOVE '5eme' TO Wclasse
            WHEN 3 MOVE '4eme' TO Wclasse
            WHEN 4 MOVE '3eme' TO Wclasse
            WHEN 5 MOVE '2nd' TO Wclasse
            WHEN 6 MOVE 'Premiere' TO Wclasse
            WHEN 7 MOVE 'Terminale' TO Wclasse
            WHEN OTHER DISPLAY 'ERREUR'
       END-EVALUATE.

       DEMANDE_VILLE.
       MOVE 0 TO Wnb
       PERFORM WITH TEST AFTER UNTIL Wnb=1 OR Wnb=2
         DISPLAY "Ville de ratachement (Entrez le num correspondant)"
         DISPLAY '1: Nantes/  2: Angers'
         ACCEPT Wnb
       END-PERFORM
       EVALUATE Wnb
         WHEN 1 MOVE 'Nantes' TO Wville
         WHEN 2 MOVE 'Angers' TO Wville
         WHEN OTHER DISPLAY 'ERREUR'
       END-EVALUATE.

       DEMANDE_AFFICHAGE_ELEVE.
       MOVE 0 TO Wdem
       PERFORM WITH TEST AFTER UNTIL Wdem=1 OR Wdem=2
         DISPlAY 'Voulez-vous afficher les eleves (1:oui /2:non)'
         ACCEPT Wdem
       END-PERFORM
       IF Wdem=1
         PERFORM AFFICHER_ELEVES
       END-IF
       MOVE 0 TO Wdem.

       MODIFIER_ELEVE.
       PERFORM DEMANDE_AFFICHAGE_ELEVE
       OPEN I-O feleve
       DISPLAY 'Entrez le numero de l etudiant a modifier'
       ACCEPT fel_idEl
       READ feleve
         INVALID KEY
           DISPLAY 'Eleve inexistant'
         NOT INVALID KEY
           MOVE 0 TO Wnb
           PERFORM WITH TEST AFTER UNTIL Wnb=1 OR Wnb=2
              DISPLAY "Modifier la classe ?(oui:1, non:2)"
              ACCEPT Wnb
           END-PERFORM
           IF Wnb = 1
             PERFORM DEMANDE_CLASSE
             MOVE Wclasse TO fel_classe
           END-IF
           MOVE 0 TO Wnb
           PERFORM WITH TEST AFTER UNTIL Wnb=1 OR Wnb=2
              DISPLAY "Modifier la Ville ?(oui:1, non:2)"
              ACCEPT Wnb
           END-PERFORM
           IF Wnb=1
             PERFORM DEMANDE_VILLE
             MOVE Wville TO fel_ville
           END-IF
           REWRITE Televe END-REWRITE
           DISPLAY 'Modification(s) effectuee(s)'
       END-READ
       CLOSE feleve.

       SUPPRIMER_ELEVE.
       PERFORM DEMANDE_AFFICHAGE_ELEVE
         DISPLAY "Identifiant de l'eleve a supprimer ?"
         ACCEPT Wid
         OPEN INPUT freserv
         MOVE Wid TO fr_idEl
         START freserv KEY IS = fr_idEl
         INVALID KEY
           OPEN I-O feleve
           MOVE Wid TO fel_idEl
           READ feleve
           INVALID KEY
                DISPLAY 'Auncun identifiant correspondant'
           NOT INVALID KEY
                DELETE feleve RECORD
                DISPLAY 'Suppression du joueur reussie '
           END-READ
           CLOSE feleve
         NOT INVALID KEY
           DISPLAY"Eleve non supprimable des donnees"
           MOVE 0 TO Wnb
           PERFORM WITH TEST AFTER UNTIL Wnb=1 OR Wnb=2
             DISPLAY"Voulez-vous le rendre indisponible? (1:oui/2:non)"
             ACCEPT Wnb
           END-PERFORM
           IF  Wnb=1
             MOVE 3 TO Wnb2
             PERFORM INDISPO_ELEVE
             MOVE 0 TO Wnb2
           END-IF
         END-START
         CLOSE freserv.

       INDISPO_ELEVE.
       IF Wnb2<>3
         PERFORM DEMANDE_AFFICHAGE_ELEVE
         DISPLAY "Identifiant de l'eleve a rendre indisponbible ?"
         ACCEPT fel_idEl
       END-IF
       OPEN I-O feleve
       READ feleve KEY IS fel_idEl
         INVALID KEY
           DISPLAY 'Eleve inexistant'
         NOT INVALID KEY
           IF fel_dispo=1
             MOVE 0 TO fel_dispo
             REWRITE Televe END-REWRITE
           ELSE
             DISPLAY "Cet eleve est deja indisponible"
           END-IF
       END-READ
       CLOSE feleve.

       DISPO_ELEVE.
       DISPLAY "Afficher les eleves indisponibles? (1:oui/ 2:non)"
       PERFORM WITH TEST AFTER UNTIL Wnb=1 OR wNB=2
         ACCEPT Wnb
       END-PERFORM
       IF Wnb=1 PERFORM AFFICHER_ELEVE_INDISPO END-IF
       OPEN I-O feleve
       DISPLAY "Entrez l'id de l'eleve a rendre disponible"
       ACCEPT fel_idEl
       READ feleve KEY IS fel_idEl
         INVALID KEY
           DISPLAY 'Eleve inexistant'
         NOT INVALID KEY
           IF fel_dispo=0
             MOVE 1 TO fel_dispo
             REWRITE Televe END-REWRITE
           ELSE
             DISPLAY "Cet éléve est deja disponible"
           END-IF
       END-READ
       CLOSE feleve.


       MENU_ENSEIGNANT.
       DISPLAY " xxxx  MENU ENSEIGNANT  xxxx "
       DISPLAY"________________________________________________________"
       DISPLAY"|Selectionnez un chiffre en fonction de l'action voulue|"
       DISPLAY"|                                                      |"
       DISPLAY"| 0-Revenir au menu principal                          |"
       DISPLAY"| 1-Ajouter un enseignant                              |"
       DISPLAY"| 2-Afficher les enseignants                           |"
       DISPLAY"| 3-Modifier les donnees d'un enseignant               |"
       DISPLAY"| 4-Supprimer un enseignant                            |"
       DISPLAY"| 5-Rendre un enseignant Indisponible                  |"
       DISPLAY"| 6-Rendre un enseignant disponible                    |"
       DISPLAY"| 7-Afficher les enseignants indisponible              |"
       DISPLAY"|______________________________________________________|"
       ACCEPT Wnb
       EVALUATE Wnb
         WHEN 0 PERFORM MENU
         WHEN 1 PERFORM AJOUT_ENSEIGNANT
         WHEN 2 PERFORM AFFICHER_ENSEIGNANTS
         WHEN 3 PERFORM MODIFIER_ENSEIGNANT
         WHEN 4 PERFORM SUPPRIMER_ENSEIGNANT
         WHEN 5 PERFORM INDISPO_ENSEIGNANT
         WHEN 6 PERFORM DISPO_ENESEIGNANT
         WHEN 7 PERFORM AFFICHER_ENSEIGNANT_INDISPO
         WHEN OTHER
          DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
          DISPLAY "Entrée non valide"
          DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
       END-EVALUATE
       PERFORM MENU_ENSEIGNANT.

       AJOUT_ENSEIGNANT.
       OPEN INPUT fenseignant
       MOVE 0 TO Wfin
       MOVE 0 TO Wid
       MOVE 0 TO Wid2
       PERFORM WITH TEST AFTER UNTIL Wfin = 1
          READ fenseignant NEXT
          AT END MOVE 1 TO Wfin
          NOT AT END
            IF Wid < fen_idEn THEN
              MOVE fen_idEn TO Wid2
              SUBTRACT Wid FROM Wid2
              IF Wid2 > 1
                 MOVE 1 TO Wfin
              ELSE
                 MOVE fen_idEn TO Wid
              END-IF
            END-IF
          END-READ
       END-PERFORM
       ADD 1 TO Wid
       CLOSE fenseignant
       OPEN I-O fenseignant
       MOVE Wid TO fen_idEn
       DISPLAY "Nom de l'enseignant"
       ACCEPT fen_nom
       DISPLAY "Prenom de l'enseignant"
       ACCEPT fen_prenom.
       PERFORM DEMANDE_MATIERE
       MOVE Wmatiere TO fen_matiere
       PERFORM DEMANDE_VILLE
       MOVE Wville TO fen_ville
       PERFORM WITH TEST AFTER UNTIL fen_nbHMax>=1 AND fen_nbHMax<=15
           DISPLAY "Entrez le nombre d'heure max par semaine possible"
           ACCEPT fen_nbHMax
       END-PERFORM
       MOVE 1 TO fen_dispo
       WRITE Tenseignant
        INVALID KEY
         DISPLAY 'Ajout impossible'
        NOT INVALID KEY
         DISPLAY 'Enseignant enregistre'
       END-WRITE
       CLOSE fenseignant.

       DEMANDE_MATIERE.
       MOVE 0 TO Wnb
       PERFORM WITH TEST AFTER UNTIL Wnb>0 AND Wnb<9
         IF Wel=1
           DISPLAY "Matiere du cour particulier enseigne"
         ELSE
           DISPLAY "Matiere enseignee? (Entrez le num correspondant)"
         END-IF
         DISPLAY '1: Mathematiques'
         DISPLAY '2: Francais'
         DISPLAY '3: Histoire-Geo'
         DISPLAY '4: Physique-Chimie'
         DISPLAY '5: SVT'
         DISPLAY '6: Anglais'
         DISPLAY '7: Espagnol'
         DISPLAY '8: Allemand'
       ACCEPT Wnb
       END-PERFORM
       EVALUATE Wnb
         WHEN 1 MOVE 'Mathematiques' TO Wmatiere
         WHEN 2 MOVE 'Francais' TO Wmatiere
         WHEN 3 MOVE 'Histoire-Geo' TO Wmatiere
         WHEN 4 MOVE 'Physique-Chimie' TO Wmatiere
         WHEN 5 MOVE 'SVT' TO Wmatiere
         WHEN 6 MOVE 'Anglais' TO Wmatiere
         WHEN 7 MOVE 'Espagnol' TO Wmatiere
         WHEN 8 MOVE 'Allemand' TO Wmatiere
         WHEN OTHER DISPLAY 'ERREUR'
       END-EVALUATE.

       AFFICHER_DETAILS_ENSEIGNANT.
       DISPLAY "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx "
       DISPLAY "Identifiant: ", fen_idEn,
       DISPLAY "Nom: ", fen_nom,
       DISPLAY "Prenom: ", fen_prenom
       DISPLAY "Matiere Enseignee: ", fen_matiere
       DISPLAY "Ville: ", fen_ville
       DISPLAY "Nombre d'heure Max par semaine: ", fen_nbHMax
*******DISPLAY "dispo: ", fen_dispo
       DISPLAY "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ".

       AFFICHER_ENSEIGNANTS.
       MOVE 0 TO Wfin
       PERFORM WITH TEST AFTER UNTIL Wfin>=1 AND WfIN<=4
         DISPLAY 'Choisissez en fonction de l action désirée'
         DISPLAY '1: Afficher l ensemble des enseignants'
         DISPLAY '2: Afficher l ensemble des enseignants de Nantes'
         DISPLAY '3: Afficher l ensemble des enseignants de Angers'
         DISPLAY "4: Afficher l ensemble des enseignants d'une matiere"
         ACCEPT Wfin
       END-PERFORM
       EVALUATE Wfin
         WHEN 2 MOVE 'Nantes' TO Wville
         WHEN 3 MOVE 'Angers' TO Wville
         WHEN 4 PERFORM DEMANDE_MATIERE
       END-EVALUATE
       OPEN INPUT fenseignant
       IF Wfin=1
           DISPLAY' '
           DISPLAY'Liste exaustive des enseignant disponibles'
           DISPLAY' '
           MOVE 1 TO fen_dispo
           START fenseignant KEY IS = fen_dispo
             INVALID KEY
               DISPLAY "Pas d'enseigant disponibles"
             NOT INVALID KEY
               MOVE 0 TO Wfin
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                 READ fenseignant NEXT
                 AT END MOVE 1 TO Wfin
                 NOT AT END
                   IF fen_dispo = 1
                     PERFORM AFFICHER_DETAILS_ENSEIGNANT
                   ELSE
                     MOVE 1 TO Wfin
                   END-IF
               END-PERFORM
           END-START
       END-IF
       IF Wfin=2 OR Wfin=3
           DISPLAY' '
           DISPLAY'Liste des enseignants de ' Wville
           DISPLAY' '
           MOVE Wville TO fen_ville
           START fenseignant KEY IS = fen_ville
             INVALID KEY
               DISPLAY "Pas d'enseigants de cette ville"
             NOT INVALID KEY
               MOVE 0 TO Wfin
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                 READ fenseignant NEXT
                   AT END
                     MOVE 1 TO Wfin
                   NOT AT END
                     IF fen_ville=Wville
                       IF fen_dispo = 1
                        PERFORM AFFICHER_DETAILS_ENSEIGNANT
                       END-IF
                     ELSE
                       MOVE 1 TO Wfin
                     END-IF
                 END-READ
               END-PERFORM
           END-START
       END-IF
       IF Wfin=4
           DISPLAY' '
           DISPLAY'Liste des enseignants en ' Wmatiere
           DISPLAY' '
           MOVE Wmatiere TO fen_matiere
           START fenseignant KEY IS = fen_matiere
             INVALID KEY
               DISPLAY "Pas d'enseigant dans cette matiere"
             NOT INVALID KEY
               MOVE 0 TO Wfin
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                 READ fenseignant NEXT
                   AT END
                     MOVE 1 TO Wfin
                   NOT AT END
                     IF fen_matiere=Wmatiere
                       IF fen_dispo = 1
                        PERFORM AFFICHER_DETAILS_ENSEIGNANT
                       END-IF
                     ELSE
                       MOVE 1 TO Wfin
                     END-IF
                 END-READ
               END-PERFORM
           END-START
       END-IF
       CLOSE fenseignant.

       AFFICHER_ENSEIGNANT_INDISPO.
       OPEN INPUT fenseignant
       DISPLAY "Liste des enseignants rendus indisponibles"
       MOVE 0 TO fen_dispo
       START fenseignant KEY IS = fen_dispo
       INVALID KEY
         DISPLAY "Pas d'enseignants indisponibles"
       NOT INVALID KEY
         MOVE 0 TO Wfin
         PERFORM WITH TEST AFTER UNTIL Wfin=1
         READ fenseignant
         AT END
           MOVE 1 TO Wfin
         NOT AT END
           IF fen_dispo=0
             PERFORM AFFICHER_DETAILS_ENSEIGNANT
           ELSE
             MOVE 1 TO Wfin
           END-IF
         END-READ
       END-PERFORM
       CLOSE fenseignant.

       DEMANDE_AFFICHAGE_ENSEIGNANT.
       MOVE 0 TO Wfin
       PERFORM WITH TEST AFTER UNTIL Wfin=1 OR Wfin=2
         DISPlAY 'Voulez-vous afficher les enseignants (1:oui /2:non)'
         ACCEPT Wfin
       END-PERFORM
       IF Wfin=1
         PERFORM AFFICHER_ENSEIGNANTS
       END-IF.

       MODIFIER_ENSEIGNANT.
       PERFORM DEMANDE_AFFICHAGE_ENSEIGNANT
       OPEN I-O fenseignant
       DISPLAY "Entrez le numero de l'enseignant a modifier"
       ACCEPT fen_idEn
       READ fenseignant
         INVALID KEY
           DISPLAY 'Enseignant inexistant'
         NOT INVALID KEY
           MOVE 0 TO Wnb
           PERFORM WITH TEST AFTER UNTIL Wnb=1 OR Wnb=2
              DISPLAY "Modifier la Ville ?(oui:1, non:2)"
              ACCEPT Wnb
           END-PERFORM
           IF Wnb=1
             PERFORM DEMANDE_VILLE
             MOVE Wville TO fen_ville
           END-IF
           MOVE 0 TO Wnb
           PERFORM WITH TEST AFTER UNTIL Wnb=1 OR Wnb=2
              DISPLAY "Modifier la matiere enseignee ?(oui:1, non:2)"
              ACCEPT Wnb
           END-PERFORM
           IF Wnb=1
             PERFORM DEMANDE_MATIERE
             MOVE Wmatiere TO fen_matiere
           END-IF
           REWRITE Tenseignant END-REWRITE
       END-READ
       CLOSE fenseignant.

       SUPPRIMER_ENSEIGNANT.
       PERFORM DEMANDE_AFFICHAGE_ENSEIGNANT
         DISPLAY "Identifiant de l'enseignant a supprimer ?"
         OPEN INPUT freserv
         ACCEPT fr_idEn
         START freserv KEY IS = fr_idEn
           INVALID KEY
             OPEN I-O fenseignant
             MOVE fr_idEn TO fen_idEn
             READ fenseignant
              INVALID KEY
                DISPLAY 'Auncun id correspondant'
              NOT INVALID KEY
                DELETE fenseignant RECORD
                DISPLAY "Suppression de l'enseignant reussie "
             END-READ
           NOT INVALID KEY
             DISPLAY"Enseignant non supprimable des donnees"
             MOVE 0 TO Wnb
             PERFORM WITH TEST AFTER UNTIL Wnb=1 OR Wnb=2
              DISPLAY"Voulez-vous le rendre indisponible? (1:oui/2:non)"
              ACCEPT Wnb
             END-PERFORM
             IF  Wnb=1
               MOVE 3 TO Wnb2
               PERFORM INDISPO_ENSEIGNANT
               MOVE 0 TO Wnb2
             END-IF
         END-START.

       INDISPO_ENSEIGNANT.
       IF Wnb2<>3
         PERFORM DEMANDE_AFFICHAGE_ENSEIGNANT
         DISPLAY "Identifiant de l'fenseignant a rendre indisponbible ?"
         ACCEPT fen_idEn
       END-IF
       OPEN I-O fenseignant
       READ fenseignant KEY IS fen_idEn
         INVALID KEY
           DISPLAY 'Enseigant inexistant'
         NOT INVALID KEY
           IF fen_dispo=1
             MOVE 0 TO fen_dispo
             REWRITE Tenseignant END-REWRITE
           ELSE
             DISPLAY "Cet enseignant est deja indisponible"
           END-IF
       END-READ
       CLOSE fenseignant.

       DISPO_ENESEIGNANT.
       DISPLAY "Afficher les enseignant indisponibles? (1:oui/ 2:non)"
       PERFORM WITH TEST AFTER UNTIL Wnb=1 OR Wnb=2
         ACCEPT Wnb
       END-PERFORM
       IF Wnb=1 PERFORM AFFICHER_ENSEIGNANT_INDISPO END-IF
       OPEN I-O fenseignant
       DISPLAY "Entrez l'id de l'enseignant a rendre disponible"
       ACCEPT fen_idEn
       READ fenseignant KEY IS fen_idEn
         INVALID KEY
           DISPLAY 'Enseignant inexistant'
         NOT INVALID KEY
           IF fen_dispo=0
             MOVE 1 TO fen_dispo
             REWRITE Tenseignant END-REWRITE
           ELSE
             DISPLAY "Cet enseignant est deja disponible"
           END-IF
       END-READ
       CLOSE fenseignant.


       MENU_RESERVATION.
       DISPLAY " xxxx  MENU RESERVATION  xxxx "
       DISPLAY"________________________________________________________"
       DISPLAY"|Selectionnez un chiffre en fonction de l'action voulue|"
       DISPLAY"|                                                      |"
       DISPLAY"| 0-Revenir au menu principal                          |"
       DISPLAY"| 1-Ajouter une Reservation                            |"
       DISPLAY"| 2-Afficher reservations via id (test)                |"
       DISPLAY"| 3-Afficher reservations                              |"
       DISPLAY"| 4-Annulation reservation                             |"
       DISPLAY"|______________________________________________________|"
       ACCEPT Wnb
       EVALUATE Wnb
         WHEN 0 PERFORM MENU
         WHEN 1 PERFORM AJOUT_RESERVATION
         WHEN 2 PERFORM AFFICHER_RESERVATIONS_ID
         WHEN 3 PERFORM AFFICHER_RESERV_NOMS
         WHEN 4 PERFORM ANNULATION_RESERV
         WHEN OTHER
          DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
          DISPLAY "Entrée non valide"
          DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
       END-EVALUATE
       PERFORM MENU_RESERVATION.


       AJOUT_RESERVATION.
     **premiere lecture directe sur fichier feleve pour vérifier l'id
     **et entrer les différentes informations concernant la reservation
       MOVE 0 TO WensDispo
       PERFORM DEMANDE_AFFICHAGE_ELEVE
       OPEN INPUT feleve
       DISPLAY "Indiquer l'Id de l'eleve reservant un cour ?"
       ACCEPT Wid
       MOVE Wid TO fel_idEl
       READ feleve
        INVALID KEY
         DISPLAY 'Auncun id correspondant'
        NOT INVALID KEY
         MOVE fel_ville TO Wville
         MOVE 1 TO Wel
          PERFORM DEMANDE_MATIERE
         MOVE 0 TO Wel
         MOVE 0 TO WnumSem
         PERFORM WITH TEST AFTER UNTIL WnumSem>0 AND WnumSem<=52
           DISPLAY "Entrez le numero de la semaine (1-52)"
           ACCEPT WnumSem
         END-PERFORM
         MOVE 0 TO Wh
         PERFORM WITH TEST AFTER UNTIL Wh>0 AND Wh<=5
           DISPLAY "Entrez le nombre d'heure pour la semaine (max:5)"
           ACCEPT Wh
         END-PERFORM
      **on vérifie via lectre une sur zone sur fenseignant s'il existe des enseignants
      **dans la matiere demandée, puis on calcul pour chaque enseignant qui enseigne
      **la matière et qui est de la ville de l'élève si le total des heures de cours
      **dans la semaine demandée, plus le nombre d'heure demandée précedement ne dépassent pas
      **le nombre max d'heure que peut fournir l'enseignant. Le cas échéant, on affiche à l'écran
      **les informations de ce dernier pour que l'utilisateur puisse savoir quel(s)
      **idenfiant(s) il peut renseigner.
         OPEN INPUT fenseignant
         MOVE Wmatiere TO fen_matiere
         START fenseignant KEY IS = fen_matiere
          INVALID KEY
            DISPLAY "Pas d'enseigant dans cette matiere"
          NOT INVALID KEY
           OPEN INPUT freserv
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
            READ fenseignant NEXT
            AT END
             MOVE 1 TO Wfin
            NOT AT END
            IF fen_matiere=Wmatiere
             IF fen_ville=fel_ville AND fen_dispo=1
              MOVE fen_idEn TO fr_idEn
              START freserv KEY IS = fr_idEn
  *************INVALID KEY
  ************* DISPLAY "Erreur"
               NOT INVALID KEY
                MOVE Wh TO WhTotalSem
                MOVE 0 TO Wfin2
                PERFORM WITH TEST AFTER UNTIL Wfin2 = 1
                 READ freserv NEXT
                 AT END
                  MOVE 1 TO Wfin2
                 NOT AT END
                    IF fr_idEn = fen_idEn
                      IF fr_numSem = WnumSem
                         ADD fr_nbHeure TO WhTotalSem
                      END-IF
                    ELSE
                      MOVE 1 TO Wfin2
                    END-IF
                END-PERFORM
              END-START
                IF WhTotalSem <= fen_nbHMax
                  IF WensDispo=0
                    DISPLAY"Enseignant(s) disponible(s) cette semaine"
                  END-IF
                  PERFORM AFFICHER_DETAILS_ENSEIGNANT
                  MOVE 1 TO WensDispo
                END-IF
             END-IF
            ELSE
   **********depasse index recherche matiere
              MOVE 1 TO Wfin
            END-IF
            END-READ
           END-PERFORM
           CLOSE freserv
         END-START

      **Il y a au moins un enseignant disponible
         IF WensDispo=1
           MOVE 0 TO WhTotalSem
           DISPLAY "Entrez l'id de l'enseignant qui donnera le cour "
           ACCEPT fen_idEn
           READ fenseignant KEY IS fen_idEn
           INVALID KEY
             DISPLAY "Auncun id correspondant"
           NOT INVALID KEY

             IF fen_ville=Wville AND fen_matiere=Wmatiere
              OPEN I-O freserv
              MOVE fen_idEn TO fr_idEn
              START freserv KEY IS = fr_idEn
 ************* INVALID KEY
 ****************DISPLAY "Erreur"
               NOT INVALID KEY
                 MOVE 0 TO Wfin2
                PERFORM WITH TEST AFTER UNTIL Wfin2 = 1
                 READ freserv NEXT
                 AT END
                  MOVE 1 TO Wfin2
                 NOT AT END
                  IF fr_idEn  = fen_idEn
                    IF fr_numSem = WnumSem
                         ADD fr_nbHeure TO WhTotalSem
                    END-IF
                  ELSE
                   MOVE 1 TO Wfin2
                  END-IF
                END-PERFORM
              END-START
              IF WhTotalSem <= fen_nbHMax
                 MOVE fel_idEl TO fr_idEl
                 MOVE fen_idEn TO fr_idEn
                 MOVE WnumSem TO fr_numSem
                 READ freserv KEY IS fr_cle
                 INVALID KEY
                   MOVE Wh TO fr_nbHeure
                   MOVE fen_matiere TO fr_matiere
                   WRITE Treserv
                   INVALID KEY
                     DISPLAY 'Ajout impossible'
                   NOT INVALID KEY
                     DISPLAY 'Reservation enregistree'
                   END-WRITE
                 NOT INVALID KEY
                   DISPLAY "L'eleve a deja cour avec ce prof cette Sem"
                   DISPLAY "Ajouter des heures? (1:oui / 2:non)"
                   MOVE 0 TO Wnb
                   PERFORM WITH TEST AFTER UNTIL Wnb=1 OR Wnb=2
                     ACCEPT Wnb
                   END-PERFORM
                   IF Wnb=1
                     ADD Wh TO fr_nbHeure
                     MOVE fen_matiere TO fr_matiere
                     REWRITE Treserv
                     INVALID KEY
                       DISPLAY 'Ajout impossible'
                     NOT INVALID KEY
                      DISPLAY "Nombre d'heures ajoutees"
                     END-REWRITE
                   END-IF
               ELSE
                 DISPLAY "Nombre d'heure max depassee"
               END-IF
              CLOSE freserv
             ELSE
               DISPLAY "Ville ou matiere de l'enseignant invalide"
             END-IF
         ELSE
           DISPLAY "Aucun enseignants disponibles cette semaine"
         END-IF
         CLOSE fenseignant
       END-READ
       CLOSE feleve.



       AFFICHER_RESERVATIONS_ID.
       OPEN INPUT freserv
       DISPLAY' '
       DISPLAY'Liste des reservations par id'
       DISPLAY' '
       MOVE 0 TO Wfin
       PERFORM WITH TEST AFTER UNTIL Wfin = 1
           READ freserv NEXT
              AT END MOVE 1 TO Wfin
           NOT AT END
              DISPLAY "******************************"
              DISPLAY "id Eleve: ", fr_idEl
              DISPLAY "id Enseignant: ", fr_idEn
              DISPLAY "Num Sem: ", fr_numSem
              DISPLAY "Matiere: ", fr_matiere
              DISPLAY "Nombre d'heure: ", fr_nbHeure
              DISPLAY "******************************"
       END-PERFORM
       CLOSE freserv.

       AFFICHER_DETAILS_RESERVATION.
           DISPLAY"*****************************"
           DISPLAY "Semaine Numero: ", fr_numSem
           IF Wel<>1
             DISPLAY"Nom Eleve: ",fel_nom
             DISPLAY"Prenom Eleve: ",fel_prenom
           END-IF
           IF Wel3=1
             DISPLAY"Id Eleve: ",fr_idEl
             DISPLAY"Id Enseignant: ",fr_idEn
           END-IF
           IF Wel2<>1
             DISPLAY"Nom Enseignant: ",fen_nom
             DISPLAY"Prenom Enseignant: ",fen_prenom
           END-IF
           DISPLAY "Matiere: ", fr_matiere
           DISPLAY "Nombre d'heure: ", fr_nbHeure
           DISPLAY "******************************".


       AFFICHER_RESERV_NOMS.
       PERFORM WITH TEST AFTER UNTIL Wnb3>0 AND Wnb3<=6
           DISPLAY"1: Afficher l'ensemble des reservations"
           DISPLAY"2: Afficher l'ensemble des reservations de Nantes"
           DISPLAY"3: Afficher l'ensemble des reservations d'Angers"
           DISPLAY"4: Afficher l'ensemble des reservations d'un Eleve"
           DISPLAY"5: Afficher l'ensemble des reservations d'un Prof"
           DISPLAY"6: Afficher les reservations d'une semaine donnee"
           ACCEPT Wnb3
       END-PERFORM
       EVALUATE Wnb3
           WHEN 2 MOVE 'Nantes' TO Wville
           WHEN 3 MOVE 'Angers' TO Wville
           WHEN 4 PERFORM DEMANDE_AFFICHAGE_ELEVE
             DISPLAY "Entrez le numero de l'eleve"
             ACCEPT Wid
           WHEN 5 PERFORM DEMANDE_AFFICHAGE_ENSEIGNANT
             DISPLAY "Entrez le numero de l'enseignant"
             ACCEPT Wid2
           WHEN 6
             DISPLAY "Entrez le num de la semaine (1-52)"
             PERFORM WITH TEST AFTER UNTIL WnumSem>=1 OR WnumSem<=52
               ACCEPT WnumSem
             END-PERFORM
       END-EVALUATE
       OPEN INPUT freserv
       OPEN INPUT feleve
       OPEN INPUT fenseignant
       IF Wnb3>=1 AND Wnb3<=3
           DISPLAY' '
           IF Wnb3=1
             DISPLAY'Liste des reservations'
           ELSE
             DISPLAY'Liste des reservations de ',Wville
           END-IF
           DISPLAY' '
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
             READ freserv NEXT
             AT END
               MOVE 1 TO Wfin
             NOT AT END
               MOVE fr_idEl TO fel_idEl
               READ feleve KEY IS fel_idEl
***************INVALID KEY DISPLAY "Eleve supprimé"
               MOVE fr_idEn TO fen_idEn
               READ fenseignant KEY IS fen_idEn
***************INVALID KEY DISPLAY "Enseignant supprimé"
               IF Wnb3=1
                 PERFORM AFFICHER_DETAILS_RESERVATION
               ELSE
                 IF fel_ville=Wville
                     PERFORM AFFICHER_DETAILS_RESERVATION
                 END-IF
               END-IF
           END-PERFORM
       END-IF
       IF Wnb3=4
         PERFORM AFFICHER_RES_UN_ELEVE
       END-IF
       IF Wnb3=5
         MOVE 1 TO Wel2
         MOVE Wid2 TO fen_idEn
         READ fenseignant KEY IS fen_idEn
         INVALID KEY
           DISPLAY"Pas d'identifiant correspondant"
         NOT INVALID KEY
           DISPLAY' '
           DISPLAY'Cours enseignés par ',fen_prenom" ",fen_nom
           DISPLAY' '
           MOVE Wid2 TO fr_idEn
           START freserv KEY IS = fr_idEn
             INVALID KEY
               DISPLAY "Pas de reservation concernant cet enseignant"
               DISPLAY " "
             NOT INVALID KEY
               MOVE 0 TO Wfin
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                 READ freserv NEXT
                   AT END
                     MOVE 1 TO Wfin
                   NOT AT END
                     IF fr_idEn=Wid2
                       MOVE fr_idEl TO fel_idEl
                       READ feleve KEY IS fel_idEl
                       PERFORM AFFICHER_DETAILS_RESERVATION
                     ELSE
                       MOVE 1 TO Wfin
                     END-IF
                 END-READ
               END-PERFORM
           END-START
        MOVE 0 TO Wel2
       END-IF

       IF Wnb3=6
         MOVE WnumSem TO fr_numSem
         START freserv KEY IS =fr_numSem
         INVALID KEY
           DISPLAY"Pas de reservation cette semaine"
         NOT INVALID KEY
           DISPLAY "Resevation semaine: " WnumSem
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin = 1
             READ freserv NEXT
             AT END
               MOVE 1 TO Wfin
             NOT AT END
               IF fr_numSem=WnumSem
                 MOVE fr_idEl TO fel_idEl
                 READ feleve KEY IS fel_idEl
*****************INVALID KEY DISPLAY "Eleve supprimé"
                 MOVE fr_idEn TO fen_idEn
                 READ fenseignant KEY IS fen_idEn
*****************INVALID KEY DISPLAY "Enseignant supprimé"
                 PERFORM AFFICHER_DETAILS_RESERVATION
               ELSE
                 MOVE 1 TO Wfin
               END-IF
             END-READ
           END-PERFORM
         END-START
       END-IF

       CLOSE feleve
       CLOSE fenseignant
       CLOSE freserv.

       AFFICHER_RES_UN_ELEVE.
       MOVE 1 TO Wel
       MOVE Wid TO fel_idEl
       READ feleve KEY IS fel_idEl
       INVALID KEY
           DISPLAY"Pas d'identifiant correspondant"
       NOT INVALID KEY
           DISPLAY' '
           DISPLAY'Liste des reservations de ',fel_prenom" ",fel_nom
           DISPLAY' '
           MOVE Wid TO fr_idEl
           START freserv KEY IS = fr_idEl
             INVALID KEY
               DISPLAY "Pas de reservation pour cet eleve"
               DISPLAY " "
             NOT INVALID KEY
               MOVE 0 TO Wfin
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                 READ freserv NEXT
                   AT END
                     MOVE 1 TO Wfin
                   NOT AT END
                     IF fr_idEl=Wid
                       MOVE fr_idEn TO fen_idEn
                       READ fenseignant KEY IS fen_idEn
                       PERFORM AFFICHER_DETAILS_RESERVATION
   ***********WensOk pour fonction création d'avis
                       MOVE 1 TO WensOk
                     ELSE
                       MOVE 1 TO Wfin
                     END-IF
                 END-READ
               END-PERFORM
           END-START
       MOVE 0 TO Wel.


       ANNULATION_RESERV.
       PERFORM AFFICHER_DETAILS_RESERVATION
       DISPLAY "Id de l'eleve de la réservation a supprimer ?"
       DISPLAY "Id de l'enseignant de la réservation a supprimer?"
         OPEN INPUT freserv
         ACCEPT fr_idEn
         ACCEPT fr_idEl
         START freserv KEY IS = fr_idEn
           INVALID KEY
             READ freserv
              INVALID KEY
                DISPLAY 'Auncun id correspondant'
              NOT INVALID KEY
                DELETE freserv RECORD
                DISPLAY "Suppression de la reservation reussie "
             END-READ
         END-START.


       MENU_AVIS.
       DISPLAY " xxxx  MENU AVIS  xxxx "
       DISPLAY"________________________________________________________"
       DISPLAY"|Selectionnez un chiffre en fonction de l'action voulue|"
       DISPLAY"|                                                      |"
       DISPLAY"| 0-Revenir au menu principal                          |"
       DISPLAY"| 1-Ajouter un avis                                    |"
       DISPLAY"| 2-Afficher les Avis via les id                       |"
       DISPLAY"| 3-Afficher les Avis                                  |"
       DISPLAY"| 5-Supprimer un Avis                                  |"
       DISPLAY"|______________________________________________________|"
       ACCEPT Wnb
       EVALUATE Wnb
         WHEN 0 PERFORM MENU
         WHEN 1 PERFORM AJOUT_AVIS
         WHEN 2 PERFORM AFFICHER_AVIS_ID
         WHEN 3 PERFORM AFFICHER_AVIS_NOMS
         WHEN 5 PERFORM SUPPRIMER_AVIS
         WHEN OTHER
          DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
          DISPLAY "Entree non valide"
          DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
       END-EVALUATE
       PERFORM MENU_AVIS.

       AJOUT_AVIS.
       MOVE 0 TO WensOk
       PERFORM DEMANDE_AFFICHAGE_ELEVE
       DISPLAY"********************************************"
       DISPLAY "Entrez l'id de l'eleve notant "
       DISPLAY"(Note possible uniquement si il y a eu reservation)"
       DISPLAY"********************************************"
       ACCEPT Wid
       OPEN INPUT freserv
       OPEN INPUT feleve
       OPEN INPUT fenseignant
       MOVE 1 TO Wel3
       PERFORM AFFICHER_RES_UN_ELEVE.
       MOVE 0 TO Wel3
       IF WensOk = 1
       DISPLAY" "
       DISPLAY "Entrez l'id de l'enseignant note"
       ACCEPT Wid2
       MOVE Wid TO fr_idEl
       START freserv KEY IS= fr_idEl
       INVALID KEY
         DISPLAY "Cet eleve n'a jamais reserve de cours"
       NOT INVALID KEY
        OPEN I-O favis
        MOVE Wid TO fa_idEl
        MOVE Wid2 TO fa_idEn
        READ favis KEY IS fa_cle
        INVALID KEY
         MOVE 0 TO Wnb
         PERFORM WITH TEST AFTER UNTIL fa_note>0 AND fa_note<6
         DISPLAY "Entrez la note que l'eleve a attrribue a l'enseignant"
         DISPLAY "(Note: entier entre 1 et 5)"
         ACCEPT fa_note
         END-PERFORM
         DISPLAY "Entrez le commentaire de l'eleve (-50 car)"
         ACCEPT fa_commentaire
         WRITE Tavis
          INVALID KEY
            DISPLAY 'Ajout impossible'
          NOT INVALID KEY
            DISPLAY 'Avis enregistre'
         END-WRITE
        NOT INVALID KEY
         DISPLAY "ATTENTION, la note a deja ete donnee"
        END-READ
        CLOSE favis
       END-START
       END-IF
       CLOSE freserv
       CLOSE feleve
       CLOSE fenseignant.

       AFFICHER_AVIS_ID.
       OPEN INPUT favis
       DISPLAY' '
       DISPLAY'Liste des avis par id'
       DISPLAY' '
       MOVE 0 TO Wfin
       PERFORM WITH TEST AFTER UNTIL Wfin = 1
           READ favis NEXT
              AT END MOVE 1 TO Wfin
           NOT AT END
              DISPLAY "******************************"
              DISPLAY "id Eleve notant: ", fa_idEl
              DISPLAY "id Enseignant note: ", fa_idEn
              DISPLAY "Note: ", fa_note"/5"
              DISPLAY "Commentaire: ", fa_commentaire
              DISPLAY "******************************"
       END-PERFORM
       CLOSE favis.


       AFFICHER_AVIS_NOMS.
       MOVE 0 TO Wnb3
       PERFORM WITH TEST AFTER UNTIL Wnb3>0 AND Wnb3<=3
           DISPLAY"1: Afficher l'ensemble des Avis"
           DISPLAY"2: Afficher l'ensemble des avis emis par un eleve"
           DISPLAY"3: Afficher l'ensemble des avis sur un enseignant"
           ACCEPT Wnb3
       END-PERFORM
       EVALUATE Wnb3
           WHEN 2 PERFORM DEMANDE_AFFICHAGE_ELEVE
             DISPLAY "Entrez le numero de l'eleve"
             ACCEPT Wid
           WHEN 3 PERFORM DEMANDE_AFFICHAGE_ENSEIGNANT
             DISPLAY "Entrez le numero de l'enseignant"
             ACCEPT Wid2
       END-EVALUATE
       OPEN INPUT feleve
       OPEN INPUT fenseignant
       OPEN INPUT favis
       EVALUATE Wnb3
         WHEN 1
           DISPLAY " "
           DISPLAY "Liste des avis"
           DISPLAY " "
           MOVE 0 TO Wfin
           PERFORM WITH TEST AFTER UNTIL Wfin=1
             READ favis
             AT END
               MOVE 1 TO Wfin
             NOT AT END
               MOVE fa_idEl TO fel_idEl
               READ feleve KEY IS fel_idEl
***************INVALID KEY DISPLAY "Eleve supprimé"
               MOVE fa_idEn TO fen_idEn
               READ fenseignant KEY IS fen_idEn
***************INVALID KEY DISPLAY "Enseignant supprimé"
               PERFORM AFFICHER_DETAILS_AVIS
           END-PERFORM
         WHEN 2
           MOVE 1 TO Wel
           MOVE Wid TO fel_idEl
           READ feleve KEY IS fel_idEl
           INVALID KEY
             DISPLAY"Pas d'identifiant correspondant"
           NOT INVALID KEY
             DISPLAY' '
             DISPLAY'Liste des avis donnes par ',fel_prenom" ",fel_nom
             DISPLAY' '
             MOVE Wid TO fa_idEl
             START favis KEY IS = fa_idEl
             INVALID KEY
               DISPLAY "Cet eleve n'a pas donne de notes"
               DISPLAY " "
             NOT INVALID KEY
               MOVE 0 TO Wfin
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                 READ favis NEXT
                   AT END
                     MOVE 1 TO Wfin
                   NOT AT END
                     IF fa_idEl=Wid
                       MOVE fa_idEn TO fen_idEn
                       READ fenseignant KEY IS fen_idEn
                       PERFORM AFFICHER_DETAILS_AVIS
                     ELSE
                       MOVE 1 TO Wfin
                     END-IF
                 END-READ
               END-PERFORM
             END-START
           MOVE 0 TO Wel
         WHEN 3
           MOVE 1 TO Wel2
           MOVE Wid2 TO fen_idEn
           READ fenseignant KEY IS fen_idEn
           INVALID KEY
             DISPLAY"Pas d'identifiant correspondant"
           NOT INVALID KEY
             DISPLAY' '
             DISPLAY'liste des notes donnees a ',fen_prenom" ",fen_nom
             DISPLAY' '
             MOVE Wid2 TO fa_idEn
             START favis KEY IS = fa_idEn
             INVALID KEY
               DISPLAY "Pas de note concernant cet enseignant"
               DISPLAY " "
             NOT INVALID KEY
               MOVE 0 TO Wfin
               PERFORM WITH TEST AFTER UNTIL Wfin = 1
                 READ favis NEXT
                 AT END
                     MOVE 1 TO Wfin
                 NOT AT END
                   IF fa_idEn=Wid2
                     MOVE fa_idEl TO fel_idEl
                     READ feleve KEY IS fel_idEl
                     PERFORM AFFICHER_DETAILS_AVIS
                   ELSE
                     MOVE 1 TO Wfin
                   END-IF
                 END-READ
               END-PERFORM
             END-START
           END-READ
           MOVE 0 TO Wel2
       END-EVALUATE
       CLOSE feleve
       CLOSE fenseignant
       CLOSE favis.


       AFFICHER_DETAILS_AVIS.
       DISPLAY"*****************************"
       IF Wel<>1
         DISPLAY"Nom Eleve: ",fel_nom
         DISPLAY"Prenom Eleve: ",fel_prenom
       END-IF
       IF Wel3=1
          DISPLAY"Id Eleve: ",fa_idEl
          DISPLAY"Id Enseignant: ",fa_idEn
       END-IF
       IF Wel2<>1
          DISPLAY"Nom Enseignant: ",fen_nom
          DISPLAY"Prenom Enseignant: ",fen_prenom
       END-IF
       DISPLAY "Note: ", fa_note
       DISPLAY "Commentaire: ", fa_commentaire
       DISPLAY "******************************".

       SUPPRIMER_AVIS.
       MOVE 0 TO Wnb
       PERFORM WITH TEST AFTER UNTIL Wnb>=1 and Wnb<=2
         DISPLAY"Voulez-vous afficher les avis (1:oui / 2:non)"
         ACCEPT Wnb
       END-PERFORM
       IF Wnb=1
         MOVE 1 TO Wel3
         PERFORM AFFICHER_AVIS_NOMS
         MOVE 0 TO Wel3
       END-IF
       OPEN I-O favis
       DISPLAY "Entrez les id correspondant a l'avis a supprimer"
       DISPLAY "Entrez l'id de l'eleve"
       ACCEPT fa_idEl
       DISPLAY "Entrez l'id de l'enseignant"
       ACCEPT fa_idEn
       READ favis KEY IS fa_cle
       INVALID KEY
         DISPLAY"Identifiants non valides"
       NOT INVALID KEY
         MOVE 0 TO Wnb
         PERFORM WITH TEST AFTER UNTIL Wnb>=1 and Wnb<=2
           DISPLAY"Voulez-vous vraiment supprimer cet avis(1:oui/2:non)"
           ACCEPT Wnb
         END-PERFORM
         IF Wnb=1
           DELETE favis END-DELETE
         END-IF
       END-READ
       CLOSE favis.

       MENU_STAT.
       DISPLAY " xxxx  MENU STAT  xxxx "
       DISPLAY"________________________________________________________"
       DISPLAY"|Selectionnez un chiffre en fonction de l'action voulue|"
       DISPLAY"|                                                      |"
       DISPLAY"| 0-Revenir au menu principal                          |"
       DISPLAY"| 1-Afficher le prix a payer d'un eleve sur l'annee    |"
       DISPLAY"| 2-Afficher le versement a faire pour un enseignant   |"
       DISPLAY"| 3-Afficher la marge actuelle                         |"
       DISPLAY"| 4-Afficher la Moyenne d'un enseignant                |"
       DISPLAY"|______________________________________________________|"
       ACCEPT Wnb
       EVALUATE Wnb
         WHEN 0 PERFORM MENU
         WHEN 1 PERFORM FACTURATION_ELEVE
         WHEN 2 PERFORM VERSEMENT_ENSEIGNANT
         WHEN 3 PERFORM CALCUL_MARGE
         WHEN 4 PERFORM MOYENNE_NOTE_ENS
         WHEN OTHER
          DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
          DISPLAY "Entrée non valide"
          DISPLAY "!!!!!!!!!!!!!!!!!!!!!"
       END-EVALUATE
       PERFORM MENU_STAT.


       FACTURATION_ELEVE.
       PERFORM DEMANDE_AFFICHAGE_ELEVE
       OPEN INPUT feleve
         DISPLAY "l'Id de l'eleve"
         ACCEPT Wid
         MOVE Wid TO fel_idEl
         READ feleve
            INVALID KEY
               DISPLAY 'Auncun id correspondant'
            NOT INVALID KEY
            OPEN INPUT freserv
            MOVE Wid TO fr_idEl
            START freserv KEY IS =fr_idEl
            INVALID KEY
              DISPLAY"cet eleve n'a jamais reserve de cours"
            NOT INVALID KEY
              MOVE 0 TO WnbHTotal
              MOVE 0 TO Wfin
              PERFORM WITH TEST AFTER UNTIL Wfin = 1
                READ freserv NEXT
                AT END
                   MOVE 1 TO Wfin
                NOT AT END
                READ freserv
                 IF fr_idEl= Wid
                   ADD fr_nbHeure TO WnbHTotal
                 ELSE
                   MOVE 1 TO Wfin
                 END-IF
                END-READ
              END-PERFORM
              IF WnbHTotal>20
                MOVE 10 TO Wfact
                COMPUTE WnbHTotal=WnbHTotal - 20
                MULTIPLY WnbHTotal BY Wfact GIVING WnbHTotal
                ADD 270 TO WnbHTotal
              END-IF
              IF WnbHTotal<=20 AND WnbHTotal>10
                MOVE 12 TO Wfact
                COMPUTE WnbHTotal=WnbHTotal - 10
                MULTIPLY WnbHTotal BY Wfact GIVING WnbHTotal
                ADD 150 TO WnbHTotal
              END-IF
              IF WnbHTotal<=10
                MOVE 15 TO Wfact
                MULTIPLY WnbHTotal BY Wfact GIVING WnbHTotal
              END-IF
              DISPLAY "|-----------------------------------------|"
              DISPLAY "|"fel_nom
              DISPLAY "|"fel_prenom
              DISPLAY "|Montant total a payer:" WnbHTotal
            END-START
            CLOSE freserv
         END-READ
       CLOSE feleve.

       VERSEMENT_ENSEIGNANT.
       PERFORM DEMANDE_AFFICHAGE_ENSEIGNANT
       OPEN INPUT fenseignant
         DISPLAY "l'Id de l'enseignant"
         ACCEPT Wid
         MOVE Wid TO fen_idEn
         READ fenseignant
            INVALID KEY
               DISPLAY 'Auncun id correspondant'
            NOT INVALID KEY
            OPEN INPUT freserv
            MOVE Wid TO fr_idEn
            START freserv KEY IS =fr_idEn
            INVALID KEY
              DISPLAY"Cet enseignant n'a jamais donne de cours"
            NOT INVALID KEY
              MOVE 0 TO WnbHTotal
              MOVE 0 TO Wfin
              PERFORM WITH TEST AFTER UNTIL Wfin = 1
                READ freserv NEXT
                AT END
                   MOVE 1 TO Wfin
                NOT AT END
                READ freserv
                 IF fr_idEn= Wid
                   ADD fr_nbHeure TO WnbHTotal
                 ELSE
                   MOVE 1 TO Wfin
                 END-IF
                END-READ
              END-PERFORM
              IF WnbHTotal>0
                MOVE 9 TO Wfact
                MULTIPLY WnbHTotal BY Wfact GIVING WnbHTotal
              DISPLAY "|-----------------------------------------|"
              DISPLAY "|"fen_nom
              DISPLAY "|"fen_prenom
              DISPLAY "|Montant total a payer:" WnbHTotal
            END-START
            CLOSE freserv
         END-READ
       CLOSE fenseignant.

       CALCUL_MARGE.
       MOVE 0 TO Wmontant
       MOVE 0 TO Wmontant2
       MOVE 0 TO Wmontant3
       OPEN INPUT feleve
       MOVE 0 TO Wfin
       PERFORM WITH TEST AFTER UNTIL Wfin=1
         READ feleve
         AT END
            MOVE 1 TO Wfin
         NOT AT END
            OPEN INPUT freserv
            MOVE fel_idEl TO fr_idEl
            START freserv KEY IS =fr_idEl
            NOT INVALID KEY
              MOVE 0 TO WnbHTotal
              MOVE 0 TO Wfin2
              PERFORM WITH TEST AFTER UNTIL Wfin2 = 1
                READ freserv NEXT
                AT END
                   MOVE 1 TO Wfin2
                NOT AT END
                READ freserv
                 IF fr_idEl= fel_idEl
                   MULTIPLY fr_nbHeure BY 10 GIVING Wmontant2
                   ADD Wmontant2 TO Wmontant3
                   ADD fr_nbHeure TO WnbHTotal
                 ELSE
                   MOVE 1 TO Wfin2
                 END-IF
                END-READ
              END-PERFORM
              display "nbh: "WnbHTotal
              IF WnbHTotal>20
                MOVE 10 TO Wfact
                COMPUTE WnbHTotal=WnbHTotal - 20
                MULTIPLY WnbHTotal BY Wfact GIVING WnbHTotal
                ADD 270 TO WnbHTotal
              END-IF
              IF WnbHTotal<=20 AND WnbHTotal>10
                MOVE 12 TO Wfact
                COMPUTE WnbHTotal=WnbHTotal - 10
                MULTIPLY WnbHTotal BY Wfact GIVING WnbHTotal
                ADD 150 TO WnbHTotal
              END-IF
              IF WnbHTotal<=10
                MOVE 15 TO Wfact
                MULTIPLY WnbHTotal BY Wfact GIVING WnbHTotal
              END-IF
              ADD WnbHTotal TO Wmontant
              display "Wm2 " Wmontant2
            END-START
            CLOSE freserv
       END-PERFORM
       DISPLAY"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
       DISPLAY"Recette Totale: "Wmontant
       DISPLAY"Salaire: "Wmontant3
       SUBTRACT Wmontant3 FROM Wmontant
       DISPLAY"Marge: "Wmontant
       DISPLAY"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
       CLOSE feleve.

       MOYENNE_NOTE_ENS.
       PERFORM DEMANDE_AFFICHAGE_ENSEIGNANT
       OPEN INPUT fenseignant
       DISPLAY "Entrez le numero de l'enseignant dont a afficher la moy"
       ACCEPT fen_idEn
       READ fenseignant KEY IS fen_idEn
       INVALID KEY
         DISPLAY "Aucun id correspondant"
       NOT INVALID KEY
         OPEN INPUT favis
         MOVE fen_idEn TO fa_idEl
         START favis KEY IS = fa_idEn
         INVALID KEY
           DISPLAY "Cet enseignant n'a jamais ete note"
         NOT INVALID KEY
           MOVE 0 TO Wfin
           MOVE 0 TO WnbNote
           MOVE 0 to WnoteTotal
           PERFORM WITH TEST AFTER UNTIL Wfin=1
             READ favis
             AT END
               MOVE 1 TO Wfin
             NOT AT END
               IF fa_idEn=fen_idEn
                 ADD 1 TO WnbNote
                 ADD fa_note TO WnoteTotal
               ELSE
                 MOVE 1 TO Wfin
               END-IF
             END-READ
           END-PERFORM
           DIVIDE WnoteTotal BY WnbNote GIVING WnoteMoy
           DISPLAY"---------------------------------------"
           DISPLAY"Note Moyenne de "fen_prenom , fen_nom
           DISPLAY"Nombre total de note: ",WnbNote
           DISPLAY"Total",WnoteTotal
           DISPLAY"Moyenne",WnoteMoy
           DISPLAY " "
         END-START
         CLOSE favis
       END-READ
       CLOSE fenseignant.
