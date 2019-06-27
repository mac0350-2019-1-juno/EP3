BEGIN;

INSERT  INTO curso
        (codigo,    nome,                       instituto_id                                    )
VALUES  (45052,     'BCC',                      (SELECT id FROM instituto WHERE nome = 'IME'  ) ),
        (00001,     'Lic',                      (SELECT id FROM instituto WHERE nome = 'IME'  ) ),
        (00002,     'Pura',                     (SELECT id FROM instituto WHERE nome = 'IME'  ) ),
        (00003,     'Estat',                    (SELECT id FROM instituto WHERE nome = 'IME'  ) ),
        (00004,     'Aplicada',                 (SELECT id FROM instituto WHERE nome = 'IME'  ) ),
        (00005,     'Engenharia da computação', (SELECT id FROM instituto WHERE nome = 'Poli' ) ),
        (00006,     'Engenharia Civil',         (SELECT id FROM instituto WHERE nome = 'Poli' ) ),
        (00007,     'Engenharia Ambiental',     (SELECT id FROM instituto WHERE nome = 'Poli' ) ),
        (00008,     'Moda',                     (SELECT id FROM instituto WHERE nome = 'ECA'  ) ),
        (00009,     'Filosofia',                (SELECT id FROM instituto WHERE nome = 'FFLCH') );

INSERT  INTO disciplina
        (sigla,     departamento_id,                                    nome,                                               credito_aula,   credito_trabalho,   semestre_ideal  )
VALUES  ('MAC0110', (SELECT id FROM departamento WHERE sigla = 'MAC'),  'Introdução à Computação',                          4,              0,                  1               ),
        ('MAC0425', (SELECT id FROM departamento WHERE sigla = 'MAC'),  'IA',                                               4,              0,                  1               ),
        ('MAC0318', (SELECT id FROM departamento WHERE sigla = 'MAC'),  'Introdução à Programação de Robôs Móveis',         4,              0,                  2               ),
        ('MAC0216', (SELECT id FROM departamento WHERE sigla = 'MAC'),  'Técnicas de Programação',                          4,              2,                  2               ),
        ('MAC0218', (SELECT id FROM departamento WHERE sigla = 'MAC'),  'Técnicas de Programação 2',                        4,              2,                  3               ),
        ('MAT0349', (SELECT id FROM departamento WHERE sigla = 'MAT'),  'Introdução à Lógica',                              4,              0,                  4               ),
        ('MAE0119', (SELECT id FROM departamento WHERE sigla = 'MAE'),  'Introdução à Probabilidade e à Estatística',       6,              0,                  5               ),
        ('MAE0228', (SELECT id FROM departamento WHERE sigla = 'MAE'),  'Noções de Probabilidade e Processos Estocásticos', 4,              0,                  6               ),
        ('4302112', (SELECT id FROM departamento WHERE sigla = '430'),  'Física II',                                        6,              0,                  7               ),
        ('MAC0335', (SELECT id FROM departamento WHERE sigla = 'MAC'),  'Leitura Dramática',                                3,              0,                  8               );


INSERT  INTO enfase
        (nome,          min_modulos,    curso_id                                    )
VALUES  ('IA',          4,              (SELECT id FROM curso WHERE codigo = 45052) ),
        ('Dados',       5,              (SELECT id FROM curso WHERE codigo = 45052) ),
        ('Sistemas',    4,              (SELECT id FROM curso WHERE codigo = 45052) ),
        ('Teoria',      2,              (SELECT id FROM curso WHERE codigo = 45052) ),
        ('Obrigatória', 1,              (SELECT id FROM curso WHERE codigo = 45052) ),
        ('Estatística', 1,              (SELECT id FROM curso WHERE codigo = 45052) ),
        ('Cientifica',  1,              (SELECT id FROM curso WHERE codigo = 45052) ),
        ('Eletiva',     1,              (SELECT id FROM curso WHERE codigo = 45052) ),
        ('Livre',       1,              (SELECT id FROM curso WHERE codigo = 45052) ),
        ('Freud',       3,              (SELECT id FROM curso WHERE codigo = 00009) );

INSERT  INTO prerrequisito
        (curso_id,                                      disciplina_id,                                          requisito_id                                        )
VALUES  ((SELECT id FROM curso WHERE codigo = 45052),   (SELECT id FROM disciplina WHERE sigla = 'MAC0216'),    (SELECT id FROM disciplina WHERE sigla = 'MAC0218') ),
        ((SELECT id FROM curso WHERE codigo = 45052),   (SELECT id FROM disciplina WHERE sigla = 'MAE0119'),    (SELECT id FROM disciplina WHERE sigla = 'MAE0228') ),
        ((SELECT id FROM curso WHERE codigo = 45052),   (SELECT id FROM disciplina WHERE sigla = 'MAC0110'),    (SELECT id FROM disciplina WHERE sigla = 'MAC0318') ),
        ((SELECT id FROM curso WHERE codigo = 45052),   (SELECT id FROM disciplina WHERE sigla = 'MAC0110'),    (SELECT id FROM disciplina WHERE sigla = 'MAT0349') ),
        ((SELECT id FROM curso WHERE codigo = 45052),   (SELECT id FROM disciplina WHERE sigla = 'MAC0110'),    (SELECT id FROM disciplina WHERE sigla = 'MAC0335') ),
        ((SELECT id FROM curso WHERE codigo = 45052),   (SELECT id FROM disciplina WHERE sigla = 'MAC0216'),    (SELECT id FROM disciplina WHERE sigla = 'MAC0318') ),
        ((SELECT id FROM curso WHERE codigo = 45052),   (SELECT id FROM disciplina WHERE sigla = 'MAC0216'),    (SELECT id FROM disciplina WHERE sigla = 'MAT0349') ),
        ((SELECT id FROM curso WHERE codigo = 45052),   (SELECT id FROM disciplina WHERE sigla = 'MAC0216'),    (SELECT id FROM disciplina WHERE sigla = 'MAC0335') ),
        ((SELECT id FROM curso WHERE codigo = 45052),   (SELECT id FROM disciplina WHERE sigla = 'MAC0110'),    (SELECT id FROM disciplina WHERE sigla = 'MAC0216') ),
        ((SELECT id FROM curso WHERE codigo = 45052),   (SELECT id FROM disciplina WHERE sigla = 'MAC0425'),    (SELECT id FROM disciplina WHERE sigla = 'MAC0318') );


INSERT  INTO modulo
        (nome,                      min_disciplinas,    enfase_id                                           )
VALUES  ('Obrigatórias',            23,                 (SELECT id FROM enfase WHERE nome = 'Obrigatória')  ),
        ('Estatísticas',            1,                  (SELECT id FROM enfase WHERE nome = 'Estatística')  ),
        ('Cientificas',             1,                  (SELECT id FROM enfase WHERE nome = 'Cientifica' )  ),
        ('Eletivas',                9,                  (SELECT id FROM enfase WHERE nome = 'Eletiva'    )  ),
        ('Livres',                  4,                  (SELECT id FROM enfase WHERE nome = 'Livre'      )  ),
        ('IA',                      1,                  (SELECT id FROM enfase WHERE nome = 'IA'         )  ),
        ('Introdução à IA',         2,                  (SELECT id FROM enfase WHERE nome = 'IA'         )  ),
        ('Sistemas',                2,                  (SELECT id FROM enfase WHERE nome = 'IA'         )  ),
        ('Teoria associada à IA',   1,                  (SELECT id FROM enfase WHERE nome = 'IA'         )  ),
        ('Bancos de Dados',         2,                  (SELECT id FROM enfase WHERE nome = 'IA'         )  );


INSERT  INTO disciplina_modulo
        (disciplina_id,                                         modulo_id                                                       )
VALUES  ((SELECT id FROM disciplina WHERE sigla = 'MAC0110'),   (SELECT id FROM modulo WHERE nome = 'Obrigatórias'         )    ),
        ((SELECT id FROM disciplina WHERE sigla = 'MAC0216'),   (SELECT id FROM modulo WHERE nome = 'Obrigatórias'         )    ),
        ((SELECT id FROM disciplina WHERE sigla = 'MAE0119'),   (SELECT id FROM modulo WHERE nome = 'Obrigatórias'         )    ),
        ((SELECT id FROM disciplina WHERE sigla = 'MAE0228'),   (SELECT id FROM modulo WHERE nome = 'Estatísticas'         )    ),
        ((SELECT id FROM disciplina WHERE sigla = '4302112'),   (SELECT id FROM modulo WHERE nome = 'Cientificas'          )    ),
        ((SELECT id FROM disciplina WHERE sigla = 'MAC0335'),   (SELECT id FROM modulo WHERE nome = 'Livres'               )    ),
        ((SELECT id FROM disciplina WHERE sigla = 'MAC0318'),   (SELECT id FROM modulo WHERE nome = 'Introdução à IA'      )    ),
        ((SELECT id FROM disciplina WHERE sigla = 'MAC0218'),   (SELECT id FROM modulo WHERE nome = 'Sistemas'             )    ),
        ((SELECT id FROM disciplina WHERE sigla = 'MAT0349'),   (SELECT id FROM modulo WHERE nome = 'Teoria associada à IA')    ),
        ((SELECT id FROM disciplina WHERE sigla = 'MAC0425'),   (SELECT id FROM modulo WHERE nome = 'IA'                   )    );


COMMIT;
