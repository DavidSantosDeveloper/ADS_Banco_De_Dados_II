/*
 ========================================
 ||                                    ||
 ||Trigger da tabela Fornecedor        ||
 ||                                    ||
 ========================================
 */

-- >>>>>>>>>>>>>>>>  INSERT
create or replace function valida_fornecedor() returns trigger as $valida_fornecedor$
begin

    if exists(SELECT cod_fornecedor from fornecedor where cod_fornecedor=new.cod_fornecedor) is null then
        raise exception 'Já existe um fornecedor usando a chave primaria % na tabela! ',new.cod_fornecedor;
    end if;

    if new.cod_fornecedor is null then
        raise exception 'O valor % para chave primaria é invalido! ',new.cod_fornecedor;
    end if;

    if new.nome is null  then
        raise exception 'o campo % tem valor inválido!',new.nome;
    end if;

    if new.telefone is null then
        raise exception 'o campo % tem valor inválido!',new.telefone;
    end if;

    return new;
end;
$valida_fornecedor$ language plpgsql;


 create or replace trigger trigger_fornecedor_cadrastro after insert OR update
 on fornecedor for each row execute procedure valida_fornecedor();

-- >>>>>>>>>>> UPDATE

-- >>>>>>>>>>> DELETE

/*
 ========================================
 ||                                    ||
 ||Trigger da tabela Fornecedor        ||
 ||                                    ||
 ========================================
 */