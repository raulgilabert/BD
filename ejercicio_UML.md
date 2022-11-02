PAIS({nom_pais})

CIUTAT({nom_ciutat, nom_pais})
nom_pais referencia a PAIS

COMPANYIA({nom_companyia})

REPRESENTACIÓ({nom_companyia, nom_ciutat, nom_pais}, adreça)
nom_companyia referencia a COMPANYIA
nom_ciutat referencia a CIUTAT
nom_pais referencia a PAIS

CINÉFIL({num_cinèfil}, nom_cinèfil, any_naixement, sexe)

DIRECTOR({num_cinèfil})
num_cinèfil referencia a CINÈFIL

ACTOR({num_cinèfil})
num_cinèfil referencia a CINÈFIL

CONTRACTACIÓ({num_cinèfil, data_alta}, nom_companyia, data_baixa)
num_cinèfil referencia a CINÈFIL
nom_companyia NOT NULL, referencia a COMPANYIA

SUBSISTUCIÓ({actor_substituit, actor_substitut}, grau_substitució)
actor_substituit referencia a ACTOR
actor_substitut referencia a ACTOR

TEMA({nom_tema})

HABILITAT({})





