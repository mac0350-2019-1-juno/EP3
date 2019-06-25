BEGIN;


INSERT  INTO aluno_curso
        (aluno_id,                                                                                  curso_id,                                       inicio          )
VALUES  ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '33333333')),  (SELECT id FROM curso WHERE codigo = 45052),    '2015-01-01'    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '11111111')),  (SELECT id FROM curso WHERE codigo = 45052),    '2015-01-01'    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '22222222')),  (SELECT id FROM curso WHERE codigo = 45052),    '2015-01-01'    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000028')),  (SELECT id FROM curso WHERE codigo = 45052),    '2015-01-01'    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000027')),  (SELECT id FROM curso WHERE codigo = 45052),    '2015-01-01'    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000026')),  (SELECT id FROM curso WHERE codigo = 45052),    '2015-01-01'    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000025')),  (SELECT id FROM curso WHERE codigo = 45052),    '2015-01-01'    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000024')),  (SELECT id FROM curso WHERE codigo = 45052),    '2015-01-01'    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000023')),  (SELECT id FROM curso WHERE codigo = 45052),    '2015-01-01'    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000022')),  (SELECT id FROM curso WHERE codigo = 45052),    '2015-01-01'    );


INSERT  INTO administrador_curso
        (administrador_id,                                                                                  curso_id,                                       inicio,         termino         )
VALUES  ((SELECT id FROM administrador WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000011')),  (SELECT id FROM curso WHERE codigo = 45052),    '2012-01-01',   '2022-12-13'    ),
        ((SELECT id FROM administrador WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000010')),  (SELECT id FROM curso WHERE codigo = 00001),    '2012-01-01',   '2022-12-13'    ),
        ((SELECT id FROM administrador WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000009')),  (SELECT id FROM curso WHERE codigo = 00002),    '2012-01-01',   '2022-12-13'    ),
        ((SELECT id FROM administrador WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000008')),  (SELECT id FROM curso WHERE codigo = 00003),    '2012-01-01',   '2022-12-13'    ),
        ((SELECT id FROM administrador WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000007')),  (SELECT id FROM curso WHERE codigo = 00004),    '2012-01-01',   '2022-12-13'    ),
        ((SELECT id FROM administrador WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000001')),  (SELECT id FROM curso WHERE codigo = 00006),    '2012-01-01',   '2022-12-13'    ),
        ((SELECT id FROM administrador WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000006')),  (SELECT id FROM curso WHERE codigo = 45052),    '2012-01-01',   '2022-12-13'    ),
        ((SELECT id FROM administrador WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000005')),  (SELECT id FROM curso WHERE codigo = 00001),    '2012-01-01',   '2022-12-13'    ),
        ((SELECT id FROM administrador WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000004')),  (SELECT id FROM curso WHERE codigo = 45052),    '2012-01-01',   '2022-12-13'    ),
        ((SELECT id FROM administrador WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000003')),  (SELECT id FROM curso WHERE codigo = 00008),    '2012-01-01',   '2022-12-13'    ),
        ((SELECT id FROM administrador WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000002')),  (SELECT id FROM curso WHERE codigo = 00009),    '2012-01-01',   '2022-12-13'    );

INSERT  INTO ministra
        (professor_id,                                                                                  disciplina_id,                                          semestre,   ano     )
VALUES  ((SELECT id FROM professor WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000021')),  (SELECT id FROM disciplina WHERE sigla = 'MAC0110'),    1,          2015    ),
        ((SELECT id FROM professor WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000020')),  (SELECT id FROM disciplina WHERE sigla = 'MAC0425'),    2,          2015    ),
        ((SELECT id FROM professor WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000018')),  (SELECT id FROM disciplina WHERE sigla = 'MAC0318'),    1,          2016    ),
        ((SELECT id FROM professor WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000017')),  (SELECT id FROM disciplina WHERE sigla = 'MAC0216'),    2,          2016    ),
        ((SELECT id FROM professor WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000017')),  (SELECT id FROM disciplina WHERE sigla = 'MAC0218'),    1,          2017    ),
        ((SELECT id FROM professor WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000012')),  (SELECT id FROM disciplina WHERE sigla = 'MAT0349'),    2,          2017    ),
        ((SELECT id FROM professor WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000013')),  (SELECT id FROM disciplina WHERE sigla = 'MAE0119'),    1,          2018    ),
        ((SELECT id FROM professor WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000013')),  (SELECT id FROM disciplina WHERE sigla = 'MAE0228'),    2,          2018    ),
        ((SELECT id FROM professor WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000019')),  (SELECT id FROM disciplina WHERE sigla = '4302112'),    1,          2019    ),
        ((SELECT id FROM professor WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000014')),  (SELECT id FROM disciplina WHERE sigla = 'MAC0335'),    1,          2019    );

INSERT  INTO planejamento
        (aluno_id,                                                                                  disciplina_id,                                          semestre,   ano     )
VALUES  ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '33333333')),  (SELECT id FROM disciplina WHERE sigla = 'MAC0335'),    2,          2019    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '33333333')),  (SELECT id FROM disciplina WHERE sigla = 'MAE0228'),    2,          2019    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '11111111')),  (SELECT id FROM disciplina WHERE sigla = 'MAC0335'),    2,          2019    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '11111111')),  (SELECT id FROM disciplina WHERE sigla = 'MAE0228'),    2,          2019    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '22222222')),  (SELECT id FROM disciplina WHERE sigla = '4302112'),    2,          2019    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '22222222')),  (SELECT id FROM disciplina WHERE sigla = 'MAC0335'),    2,          2019    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000028')),  (SELECT id FROM disciplina WHERE sigla = 'MAC0218'),    2,          2019    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000028')),  (SELECT id FROM disciplina WHERE sigla = 'MAC0335'),    2,          2019    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000027')),  (SELECT id FROM disciplina WHERE sigla = '4302112'),    2,          2019    ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000027')),  (SELECT id FROM disciplina WHERE sigla = 'MAE0228'),    2,          2019    );


INSERT  INTO oferecimento
        (ministra_id    )
VALUES  ( 1             ),
        ( 2             ),
        ( 3             ),
        ( 4             ),
        ( 5             ),
        ( 6             ),
        ( 7             ),
        ( 8             ),
        ( 9             ),
        (10             );


INSERT  INTO matricula
        (aluno_id,                                                                                  oferecimento_id,    estado, nota,   frequencia  )
VALUES  ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '33333333')),  1,                  'C',    10.0,   75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '11111111')),  1,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '22222222')),  1,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000028')),  1,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000027')),  1,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000026')),  1,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000025')),  1,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000024')),  1,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000023')),  1,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000022')),  1,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '33333333')),  4,                  'C',    10.0,   75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '11111111')),  4,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '22222222')),  4,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000028')),  4,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000027')),  4,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000026')),  4,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000025')),  4,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000024')),  4,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000023')),  4,                  'C',    8.1,    75.0        ),
        ((SELECT id FROM aluno WHERE pessoa_id = (SELECT id FROM pessoa WHERE nusp = '00000022')),  4,                  'C',    8.1,    75.0        );


COMMIT;
