-- 1 QUESTAO

CREATE OR REPLACE FUNCTION validacao_produto() RETURNS TRIGGER as $$
BEGIN

    if E_COMBO='s' THEN
        update produto set VALOR_VENDA=0 WHERE cod_prod=new.cod_prod;
    end if;
    RETURN new;
end;

$$ LANGUAGE plpgsql;


CREATE or REPLACE trigger trigger_validacao_produto after insert on  produto
for each row execute FUNCTION validacao_produto();


create or replace FUNCTION valida_combo() RETURNS trigger as $$
BEGIN

    return new;
end;
$$ LANGUAGE plpgsql;

