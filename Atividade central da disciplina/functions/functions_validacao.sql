/*
 ============================================
 ||                                    	   ||
 ||      Função para Validar TELEFONE      ||
 ||                                        ||
 ============================================
 */

CREATE OR REPLACE FUNCTION VALIDAR_TELEFONE(_TELEFONE VARCHAR(20)) 
RETURNS BOOLEAN AS $$
BEGIN
    IF LENGTH(_TELEFONE) != 11 THEN 
        return FALSE;
    END IF;

    return TRUE;

END;

$$ LANGUAGE 'plpgsql';


/*
 ========================================
 ||                                    ||
 ||      Função para Validar CPF       ||
 ||                                    ||
 ========================================
 */
CREATE
OR REPLACE FUNCTION VALIDAR_CPF(CPF VARCHAR(11)) RETURNS BOOLEAN AS $ $ DECLARE CPF_ARRAY INT [] := STRING_TO_ARRAY(CPF, NULL);

SOMA_DIGITO_1 INT := 0;

SOMA_DIGITO_2 INT := 0;

BEGIN IF LENGTH(CPF) != 11 THEN return FALSE;

END IF;

FOR INDICE IN 1..9 LOOP SOMA_DIGITO_1 := SOMA_DIGITO_1 + CPF_ARRAY [INDICE] * (11 - INDICE);

END LOOP;

SOMA_DIGITO_1 := 11 - (SOMA_DIGITO_1 % 11);

IF SOMA_DIGITO_1 > 9 THEN SOMA_DIGITO_1 := 0;

END IF;

FOR INDICE IN 1..10 LOOP SOMA_DIGITO_2 := SOMA_DIGITO_2 + CPF_ARRAY [INDICE] * (12 - INDICE);

END LOOP;

SOMA_DIGITO_2 := 11 - (SOMA_DIGITO_2 % 11);

IF SOMA_DIGITO_2 > 9 THEN SOMA_DIGITO_2 = 0;

END IF;

IF SOMA_DIGITO_1 != CPF_ARRAY [10]
OR SOMA_DIGITO_2 != CPF_ARRAY [11] THEN return FALSE;

END IF;

return TRUE;

END;

$$ LANGUAGE 'plpgsql';

