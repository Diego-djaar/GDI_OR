DECLARE
    MEDICO_ TP_MEDICO;
BEGIN
    SELECT
        DEREF(REF(M)) INTO MEDICO_
    FROM
        TB_MEDICO M
    WHERE
        M.CRM = '424500';
    MEDICO_.EXIBIR_DADOS();
END;