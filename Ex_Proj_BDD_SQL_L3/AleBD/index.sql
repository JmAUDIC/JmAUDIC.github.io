CREATE BITMAP INDEX IndeX_mat_type
ON MATERIEL (type_mat);

CREATE BITMAP INDEX IndeX_entr_type
ON ENTRETIEN (type_entr);

CREATE BITMAP INDEX IndeX_emprunt_nummat
ON EMPRUNT (num_mat);
