BEGIN;


INSERT  INTO pessoa_usuario
        (pessoa_id,                                         usuario_id  )
VALUES  ((SELECT id FROM pessoa WHERE nusp = '33333333'),   1           ),
        ((SELECT id FROM pessoa WHERE nusp = '11111111'),   2           ),
        ((SELECT id FROM pessoa WHERE nusp = '22222222'),   3           ),
        ((SELECT id FROM pessoa WHERE nusp = '00000028'),   4           ),
        ((SELECT id FROM pessoa WHERE nusp = '00000027'),   5           ),
        ((SELECT id FROM pessoa WHERE nusp = '00000026'),   6           ),
        ((SELECT id FROM pessoa WHERE nusp = '00000025'),   7           ),
        ((SELECT id FROM pessoa WHERE nusp = '00000024'),   8           ),
        ((SELECT id FROM pessoa WHERE nusp = '00000023'),   9           ),
        ((SELECT id FROM pessoa WHERE nusp = '00000022'),   10          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000021'),   11          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000020'),   12          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000019'),   13          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000018'),   14          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000017'),   15          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000016'),   16          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000015'),   17          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000014'),   18          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000013'),   19          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000012'),   20          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000011'),   21          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000010'),   22          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000009'),   23          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000008'),   24          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000007'),   25          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000006'),   26          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000005'),   27          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000004'),   28          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000003'),   29          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000002'),   30          ),
        ((SELECT id FROM pessoa WHERE nusp = '00000001'),   31          );




COMMIT;
