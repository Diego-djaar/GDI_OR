CREATE OR REPLACE TYPE TP_ENDERECO AS
    OBJECT (
        CEP VARCHAR2(8),
        RUA VARCHAR2(50),
        NUMERO NUMBER,
        BAIRRO VARCHAR2(50),
        CIDADE VARCHAR2(50)
    );
/

CREATE OR REPLACE TYPE TP_FONE AS
    OBJECT (
        NUMERO NUMBER
    );
/

CREATE OR REPLACE TYPE TP_FONES AS
    VARRAY(5) OF TP_FONE;
/

CREATE OR REPLACE TYPE TP_PESSOA AS
    OBJECT (
        CPF VARCHAR2(11),
        ENDERECO TP_ENDERECO,
        NOME VARCHAR2(50),
        DATA_DE_NASCIMENTO DATE,
        TELEFONES TP_FONES,
        MEMBER FUNCTION IDADE RETURN NUMBER
    ) NOT FINAL NOT INSTANTIABLE;
/

CREATE OR REPLACE TYPE BODY TP_PESSOA IS

    MEMBER FUNCTION IDADE RETURN NUMBER IS
    BEGIN
        RETURN EXTRACT(YEAR FROM SYSDATE()) - EXTRACT(YEAR FROM DATA_DE_NASCIMENTO);
    END;
END;
/

CREATE OR REPLACE TYPE TP_CIRURGIA AS
    OBJECT(
        DESCRICAO VARCHAR2(255)
    );
/

CREATE OR REPLACE TYPE TP_CIRURGIAS AS
    VARRAY(50) OF TP_CIRURGIA;
/

CREATE OR REPLACE TYPE TP_ALERGIA AS
    OBJECT(
        DESCRICAO VARCHAR2(255)
    );
/

CREATE OR REPLACE TYPE TP_ALERGIAS AS
    VARRAY(50) OF TP_ALERGIA;
/

CREATE OR REPLACE TYPE TP_DOENCA_CRONICA AS
    OBJECT(
        DESCRICAO VARCHAR2(255)
    );
/

CREATE OR REPLACE TYPE TP_DOENCAS_CRONICAS AS
    VARRAY(50) OF TP_DOENCA_CRONICA;
/

CREATE OR REPLACE TYPE TP_HISTORICO_MEDICO AS
    OBJECT (
        ID NUMBER,
        CIRURGIAS TP_CIRURGIAS,
        ALERGIAS TP_ALERGIAS,
        DOENCAS_CRONICAS TP_DOENCAS_CRONICAS
    );
/

CREATE OR REPLACE TYPE TP_PACIENTE UNDER TP_PESSOA (
    PRESSAO_ARTERIAL VARCHAR2(20),
    PESO NUMBER,
    ALTURA NUMBER,
    TIPO_SANGUINEO VARCHAR2(10),
    HISTORICO_MEDICO REF TP_HISTORICO_MEDICO
);
/

CREATE OR REPLACE TYPE TP_FUNCIONARIO UNDER TP_PESSOA (
    SALARIO NUMBER,
    DATA_DE_ADMISSAO DATE,
    NUM_CLT NUMBER
) NOT FINAL;
/

CREATE OR REPLACE TYPE TP_ESPECIALIDADE_MEDICO AS
    OBJECT(
        ESPECIALIDADE VARCHAR2(50)
    );
/

CREATE OR REPLACE TYPE TP_ESPECIALIDADES_MEDICO AS
    VARRAY(20) OF TP_ESPECIALIDADE_MEDICO;
/

CREATE OR REPLACE TYPE TP_MEDICO UNDER TP_FUNCIONARIO (
    CRM VARCHAR2(8),
    ESPECIALIDADES TP_ESPECIALIDADES_MEDICO,
    SUPERVISOR REF TP_MEDICO,
    MEMBER PROCEDURE EXIBIR_DADOS (SELF TP_MEDICO)
);
/

CREATE OR REPLACE TYPE BODY TP_MEDICO AS

    MEMBER PROCEDURE EXIBIR_DADOS (
        SELF TP_MEDICO
    ) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DADOS DO MÉDICO: ');
        DBMS_OUTPUT.PUT_LINE('NOME: '
                             || NOME);
        DBMS_OUTPUT.PUT_LINE('CPF: '
                             || TO_CHAR(CPF));
        DBMS_OUTPUT.PUT_LINE('CLT: '
                             || TO_CHAR(NUM_CLT));
        DBMS_OUTPUT.PUT_LINE('SALARIO: '
                             || TO_CHAR(SALARIO));
        DBMS_OUTPUT.PUT_LINE('CRM: '
                             || TO_CHAR(CRM));
        DBMS_OUTPUT.PUT_LINE('SALARIO: '
                             || TO_CHAR(SALARIO));
        IF SELF.ESPECIALIDADES IS NOT NULL THEN
            FOR I IN 1..SELF.ESPECIALIDADES.COUNT LOOP
                DBMS_OUTPUT.PUT_LINE(' - '
                                     || SELF.ESPECIALIDADES(I).ESPECIALIDADE);
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Nenhuma especialidade cadastrada.');
        END IF;
    END;
END;
/

--ve se ta rodando
-- Roda sim

CREATE OR REPLACE TYPE TP_ENFERMEIRO UNDER TP_FUNCIONARIO(
    COREN VARCHAR2(6),
    SUPERVISOR REF TP_ENFERMEIRO
);
/

CREATE OR REPLACE TYPE TP_ATENDENTE UNDER TP_FUNCIONARIO (
);
/

CREATE OR REPLACE TYPE TP_SETOR AS
    OBJECT(
        NOME VARCHAR2(30)
    );
/

CREATE OR REPLACE TYPE TP_SALA AS
    OBJECT(
        NUMERO NUMBER,
        SETOR REF TP_SETOR
    );
/

CREATE OR REPLACE TYPE TP_ACOMPANHANTE AS
    OBJECT(
        PACIENTE REF TP_PACIENTE,
        NOME VARCHAR2(50),
        GRAU_DE_PARENTESCO NUMBER,
        CPF VARCHAR2(11),
        MAP MEMBER FUNCTION ACOMPANHANTENOME RETURN VARCHAR2
    ) FINAL;
/

CREATE OR REPLACE TYPE BODY TP_ACOMPANHANTE AS

    MAP MEMBER FUNCTION ACOMPANHANTENOME RETURN VARCHAR2 IS
        P VARCHAR2(50) := NOME;
    BEGIN
        RETURN P;
    END;
END;
/

-- Adiciona uma possível bonificação aos funcionários
ALTER TYPE TP_FUNCIONARIO ADD ATTRIBUTE (BONIFICACAO NUMBER) CASCADE;

ALTER TYPE TP_FUNCIONARIO ADD FINAL MEMBER FUNCTION PAGAMENTO RETURN NUMBER CASCADE;

CREATE OR REPLACE TYPE BODY TP_FUNCIONARIO AS

    FINAL MEMBER FUNCTION PAGAMENTO RETURN NUMBER IS
    BEGIN
        RETURN SALARIO + BONIFICACAO;
    END;
END;
/

CREATE OR REPLACE TYPE TP_RECEITA AS
    OBJECT (
        RECEITA VARCHAR2(50),
        DATA_E_HORA TIMESTAMP,
        MEDICO REF TP_MEDICO,
        PACIENTE REF TP_PACIENTE
    );
/

CREATE OR REPLACE TYPE TP_DIAGNOSTICO AS
    OBJECT(
        DIAGNOSTICO VARCHAR2(50),
        DATA_E_HORA TIMESTAMP,
        MEDICO REF TP_MEDICO,
        PACIENTE REF TP_PACIENTE
    );
/

CREATE OR REPLACE TYPE TP_CONSULTA AS
    OBJECT(
        DATA_E_HORA TIMESTAMP,
        SALA REF TP_SALA,
        MEDICO REF TP_MEDICO,
        PACIENTE REF TP_PACIENTE,
        RECEITA REF TP_RECEITA,
        DIAGNOSTICO REF TP_DIAGNOSTICO
    );
/

CREATE OR REPLACE TYPE TP_ENFERMEIRO_RESPONSAVEL AS
    OBJECT(
        ENFERMEIRO REF TP_ENFERMEIRO,
        PACIENTE REF TP_PACIENTE
    );
/

CREATE OR REPLACE TYPE TP_MEDICO_RESPONSAVEL AS
    OBJECT(
        MEDICO REF TP_MEDICO,
        ENFERMEIRO_PACIENTE REF TP_ENFERMEIRO_RESPONSAVEL
    );
/