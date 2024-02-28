-- setor(1)
INSERT INTO TB_SETOR(
    NOME
) VALUES(
    'triagem'
);

INSERT INTO TB_SETOR(
    NOME
) VALUES(
    'consultório'
);

INSERT INTO TB_SETOR(
    NOME
) VALUES(
    'nebulização'
);

INSERT INTO TB_SETOR(
    NOME
) VALUES(
    'medicação'
);

INSERT INTO TB_SETOR(
    NOME
) VALUES(
    'internação'
);

INSERT INTO TB_SETOR(
    NOME
) VALUES(
    'Radiologia'
);

INSERT INTO TB_SETOR(
    NOME
) VALUES(
    'Enfermaria'
);

INSERT INTO TB_SETOR(
    NOME
) VALUES(
    'Recepção'
);

INSERT INTO TB_SETOR(
    NOME
) VALUES(
    'Gerência'
);

--sala (2)

INSERT INTO TB_SALA (
    NUMERO,
    SETOR
) VALUES (
    1,
    (SELECT REF(S) FROM TB_SETOR S WHERE NOME = 'triagem')
);

INSERT INTO TB_SALA (
    NUMERO,
    SETOR
) VALUES (
    2,
    (SELECT REF(S) FROM TB_SETOR S WHERE NOME = 'consultório')
);

INSERT INTO TB_SALA (
    NUMERO,
    SETOR
) VALUES (
    3,
    (SELECT REF(S) FROM TB_SETOR S WHERE NOME = 'nebulização')
);

INSERT INTO TB_SALA (
    NUMERO,
    SETOR
) VALUES (
    4,
    (SELECT REF(S) FROM TB_SETOR S WHERE NOME = 'medicação')
);

INSERT INTO TB_SALA (
    NUMERO,
    SETOR
) VALUES (
    5,
    (SELECT REF(S) FROM TB_SETOR S WHERE NOME = 'internação')
);

INSERT INTO TB_SALA (
    NUMERO,
    SETOR
) VALUES (
    6,
    (SELECT REF(S) FROM TB_SETOR S WHERE NOME = 'radiologia')
);

INSERT INTO TB_SALA (
    NUMERO,
    SETOR
) VALUES (
    7,
    (SELECT REF(S) FROM TB_SETOR S WHERE NOME = 'Enfermaria')
);

INSERT INTO TB_SALA (
    NUMERO,
    SETOR
) VALUES (
    8,
    (SELECT REF(S) FROM TB_SETOR S WHERE NOME = 'Recepção')
);

INSERT INTO TB_SALA (
    NUMERO,
    SETOR
) VALUES (
    9,
    (SELECT REF(S) FROM TB_SETOR S WHERE NOME = 'Gerência')
);

INSERT INTO TB_MEDICO VALUES (
    TP_MEDICO( '12345678901', TP_ENDERECO('52050642', 'rua do limão', 600, 'limoeiro', 'São Paulo'), 'Jonescleison da silva', DATE '2001-05-04', TP_FONES(TP_FONE(993886666)), 14020, DATE '2024-01-28', 1400000, NULL, '424242', TP_ESPECIALIDADES_MEDICO(TP_ESPECIALIDADE_MEDICO('Cirurgião Cardíaco')), NULL )
)