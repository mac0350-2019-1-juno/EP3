BEGIN;

INSERT  INTO instituto
        (nome       )
VALUES  ('IME'      ),
        ('Poli'     ),
        ('FFLCH'    ),
        ('ECA'      ),
        ('IF'       ),
        ('FAU'      ),
        ('IAG'      ),
        ('IP'       ),
        ('IQ'       ),
        ('FEA'      ),
        ('IO'       );

INSERT  INTO pessoa
        (nusp,          nome,               cpf             )
VALUES  ('33333333',    'Victor',           '222.333.444-55'),
        ('11111111',    'César',            '666.777.888-99'),
        ('22222222',    'Lais',             '123.456.789-10'),
        ('00000028',    'Vitor',            '111.111.111-00'),
        ('00000027',    'Carime',           '111.111.111-01'),
        ('00000026',    'Thiago',           '111.111.111-02'),
        ('00000025',    'PP',               '111.111.111-03'),
        ('00000024',    'Matheus',          '111.111.111-04'),
        ('00000023',    'Nathy',            '111.111.111-05'),
        ('00000022',    'Madame Carisma',   '111.111.111-06'),
        ('00000021',    'Nina',             '111.111.111-07'),
        ('00000020',    'João',             '111.111.111-08'),
        ('00000019',    'Jefferson',        '111.111.111-09'),
        ('00000018',    'Yoshi',            '111.111.111-10'),
        ('00000017',    'Gubi',             '111.111.111-11'),
        ('00000016',    'Senhorita Crime',  '111.111.111-12'),
        ('00000015',    'Marcel',           '111.111.111-13'),
        ('00000014',    'Coelho',           '111.111.111-14'),
        ('00000013',    'Beti',             '111.111.111-15'),
        ('00000012',    'Elói',             '111.111.111-16'),
        ('00000011',    'Carlinhos',        '111.111.111-17'),
        ('00000010',    'Flávio',           '111.111.111-18'),
        ('00000009',    'Mary',             '111.111.111-19'),
        ('00000008',    'Morettin',         '111.111.111-20'),
        ('00000007',    'TGrando',          '111.111.111-21'),
        ('00000006',    'Aguilar',          '111.111.111-22'),
        ('00000005',    'Piccione',         '111.111.111-23'),
        ('00000004',    'Décio',            '111.111.111-24'),
        ('00000003',    'Nataly',           '111.111.111-25'),
        ('00000002',    'Pedro',            '111.111.111-26'),
        ('00000001',    'Felipe',           '111.111.111-27');

INSERT  INTO departamento
        (sigla,     instituto_id                                    )
VALUES  ('MAC',     (SELECT id FROM instituto WHERE nome ='IME' )   ),
        ('MAT',     (SELECT id FROM instituto WHERE nome ='IME' )   ),
        ('MAP',     (SELECT id FROM instituto WHERE nome ='IME' )   ),
        ('MAE',     (SELECT id FROM instituto WHERE nome ='IME' )   ),
        ('PCC',     (SELECT id FROM instituto WHERE nome ='Poli')   ),
        ('PCS',     (SELECT id FROM instituto WHERE nome ='Poli')   ),
        ('EAD',     (SELECT id FROM instituto WHERE nome ='FEA' )   ),
        ('EAE',     (SELECT id FROM instituto WHERE nome ='FEA' )   ),
        ('ACH',     (SELECT id FROM instituto WHERE nome ='ECA' )   ),
        ('AUP',     (SELECT id FROM instituto WHERE nome ='FAU' )   ),
        ('430',     (SELECT id FROM instituto WHERE nome ='IF'  )   );

INSERT  INTO aluno
        (pessoa_id                                          )
VALUES  ((SELECT id FROM pessoa WHERE nusp = '33333333')    ),
        ((SELECT id FROM pessoa WHERE nusp = '11111111')    ),
        ((SELECT id FROM pessoa WHERE nusp = '22222222')    ),
        ((SELECT id FROM pessoa WHERE nusp = '00000028')    ),
        ((SELECT id FROM pessoa WHERE nusp = '00000027')    ),
        ((SELECT id FROM pessoa WHERE nusp = '00000026')    ),
        ((SELECT id FROM pessoa WHERE nusp = '00000025')    ),
        ((SELECT id FROM pessoa WHERE nusp = '00000024')    ),
        ((SELECT id FROM pessoa WHERE nusp = '00000023')    ),
        ((SELECT id FROM pessoa WHERE nusp = '00000022')    );


INSERT  INTO administrador
        (pessoa_id,                                         departamento_id                                     )
VALUES  ((SELECT id FROM pessoa WHERE nusp = '00000011'),   (SELECT id FROM departamento WHERE sigla = 'MAC')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000010'),   (SELECT id FROM departamento WHERE sigla = 'MAT')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000009'),   (SELECT id FROM departamento WHERE sigla = 'MAT')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000008'),   (SELECT id FROM departamento WHERE sigla = 'MAE')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000007'),   (SELECT id FROM departamento WHERE sigla = 'MAT')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000006'),   (SELECT id FROM departamento WHERE sigla = 'MAC')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000005'),   (SELECT id FROM departamento WHERE sigla = 'MAT')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000004'),   (SELECT id FROM departamento WHERE sigla = 'MAC')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000003'),   (SELECT id FROM departamento WHERE sigla = 'EAE')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000002'),   (SELECT id FROM departamento WHERE sigla = 'EAD')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000001'),   (SELECT id FROM departamento WHERE sigla = 'PCC')   );

INSERT  INTO professor
        (pessoa_id,                                         departamento_id                                     )
VALUES  ((SELECT id FROM pessoa WHERE nusp = '00000021'),   (SELECT id FROM departamento WHERE sigla = 'MAC')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000020'),   (SELECT id FROM departamento WHERE sigla = 'MAC')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000019'),   (SELECT id FROM departamento WHERE sigla = '430')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000018'),   (SELECT id FROM departamento WHERE sigla = 'MAC')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000017'),   (SELECT id FROM departamento WHERE sigla = 'MAC')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000016'),   (SELECT id FROM departamento WHERE sigla = 'PCC')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000015'),   (SELECT id FROM departamento WHERE sigla = 'MAC')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000014'),   (SELECT id FROM departamento WHERE sigla = 'MAC')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000013'),   (SELECT id FROM departamento WHERE sigla = 'MAE')   ),
        ((SELECT id FROM pessoa WHERE nusp = '00000012'),   (SELECT id FROM departamento WHERE sigla = 'MAT')   );


COMMIT;
