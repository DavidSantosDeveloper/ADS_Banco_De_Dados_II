/*
 ========================================
 ||                                    ||
 ||Trigger da tabela Fornecedor        ||
 ||                                    ||
 ========================================
 */

-- >>>>>>>>>>>>>>>>  INSERT e UPDATE
create or replace function valida_fornecedor() returns trigger as $valida_fornecedor$
begin
     -- Cod_fornecedor (Cod_fornecedor é a chave primária da tabela, 
    --  só devemos nos preocupar em validar ela na operação INSERT)
    if TG_OP='INSERT' then
            if exists(SELECT cod_fornecedor from fornecedor where cod_fornecedor=new.cod_fornecedor) then
                raise exception 'Já existe um fornecedor usando a chave primaria % na tabela! ',new.cod_fornecedor;
            end if;

            if new.cod_fornecedor is null then
                raise exception 'chave primaria não pode ser nula! ';
            end if;
    end if;
   
    
     -- TODOS OS DEMAIS CAMPOS precisam ser validados nas operacoes INSERT e UPDATE
    if new.nome is null  then
        raise exception 'o campo nome tem valor inválido!';
    end if;

    if new.telefone is null or  not VALIDAR_TELEFONE(new.telefone) then
        raise exception 'o campo telefone tem valor inválido!';
    end if;

    return new;
end;
$valida_fornecedor$ language plpgsql;


 create or replace trigger trigger_valida_fornecedor before insert OR update
 on fornecedor for each row execute procedure valida_fornecedor();

-- >>>>>>>>>>> DELETE
-- somente tabelas com chaves estrangeiras precisam de trigger para excluir as linhas referenciadas na tabela estrangeira



/*
 ========================================
 ||                                    ||
 ||Trigger da tabela     CLIENTE       ||
 ||                                    ||
 ========================================
 */

-- >>>>>>>>>>>>>>>>  INSERT e UPDATE
create or replace function valida_cliente() returns trigger as $valida_cliente$
begin

    -- cod_cliente (cod_cliente é a chave primária da tabela, 
    --  só devemos nos preocupar em validar ela na operação INSERT)
    if TG_OP='INSERT' then
            if exists(SELECT cod_cliente from cliente where cod_cliente=new.cod_cliente)  then
                raise exception 'Já existe um cliente usando a chave primaria % na tabela! ',new.cod_fornecedor;
            end if;

            if new.cod_cliente is null then
                raise exception 'A chave primaria não pode ser nula!';
            end if;      
    end if;

     -- TODOS OS DEMAIS CAMPOS precisam ser validados nas operacoes INSERT e UPDATE
    if new.nome is null  then
        raise exception 'o campo nome tem valor inválido!';
    end if;

    if new.telefone is null or  not VALIDAR_TELEFONE(new.telefone) then
        raise exception 'o campo telefone tem valor inválido!';
    end if;

    return new;
end;
$valida_cliente$ language plpgsql;


 create or replace trigger trigger_valida_cliente before insert OR update
 on cliente for each row execute procedure valida_cliente();




/*
 ========================================
 ||                                    ||
 ||Trigger da tabela    CARGO          ||
 ||                                    ||
 ========================================
 */

 -- >>>>>>>>>>>>>>>>  INSERT e UPDATE
create or replace function valida_cargo() returns trigger as $valida_cargo$
begin

    -- cod_cargo (cod_cargo é a chave primária da tabela, 
    --  só devemos nos preocupar em validar ela na operação INSERT)
    if TG_OP='INSERT' then
        if exists(SELECT cod_cargo from cargo where cod_cargo=new.cod_cargo)  then
            raise exception 'Já existe um cargo usando a chave primaria % na tabela! ',new.cod_cargo;
        end if;

        if new.cod_cargo is null then
            raise exception 'A chave primaria não pode ser nula!';
        end if;       
    end if;

     -- TODOS OS DEMAIS CAMPOS precisam ser validados nas operacoes INSERT e UPDATE
    if new.nome is null  then
        raise exception 'o campo nome tem valor inválido!';
    end if;

    return new;
end;
$valida_cargo$ language plpgsql;


 create or replace trigger trigger_valida_cargo before insert OR update
 on cargo for each row execute procedure valida_cargo();



/*
 ========================================
 ||                                    ||
 ||Trigger da tabela   LOJA            ||
 ||                                    ||
 ========================================
 */

 -- >>>>>>>>>>>>>>>>  INSERT e UPDATE
create or replace function valida_loja() returns trigger as $valida_loja$
begin

    
    -- cod_loja (cod_loja é a chave primária da tabela, 
    --  só devemos nos preocupar em validar ela na operação INSERT)
    if TG_OP = 'INSERT' then
        if exists(SELECT cod_loja from loja where cod_loja = new.cod_loja) then
            raise exception 'Já existe uma loja usando a chave primaria % na tabela!', new.cod_loja;
        end if;

        if new.cod_loja is null then
            raise exception 'A chave primaria não pode ser nula!';
        end if;
    end if;



    -- TODOS OS DEMAIS CAMPOS precisam ser validados nas operacoes INSERT e UPDATE
    if new.nome is null  then
        raise exception 'o campo nome tem valor inválido!';
    end if;
     if new.telefone is null or  not VALIDAR_TELEFONE(new.telefone) then
        raise exception 'o campo telefone tem valor inválido!';
    end if;
    if new.cep is null  then
        raise exception 'o campo cep tem valor inválido!';
    end if;
    if new.pais is null  then
        raise exception 'o campo pais tem valor inválido!';
    end if;
    if new.estado is null  then
        raise exception 'o campo estado tem valor inválido!';
    end if;
    if new.cidade is null  then
        raise exception 'o campo cidade tem valor inválido!';
    end if;
    if new.bairro is null  then
        raise exception 'o campo bairro tem valor inválido!';
    end if;
    if new.logradouro is null  then
        raise exception 'o campo logradouro tem valor inválido!';
    end if;
    if new.numero is null  then
        raise exception 'o campo numero tem valor inválido!';
    end if;

    return new;
end;
$valida_loja$ language plpgsql;


 create or replace trigger trigger_valida_loja before insert OR update
 on loja for each row execute procedure valida_loja();




/*
 ========================================
 ||                                    ||
 ||Trigger da tabela   PRODUTO         ||
 ||                                    ||
 ========================================
 */

 -- >>>>>>>>>>>>>>>>  INSERT e UPDATE
create or replace function valida_produto() returns trigger as $valida_produto$
begin

     -- cod_produto (cod_produto é a chave primária da tabela, 
    --  só devemos nos preocupar em validar ela na operação INSERT)
    if TG_OP='INSERT' then
        if exists(SELECT cod_produto from produto where cod_produto=new.cod_produto)  then
            raise exception 'Já existe um produto  usando a chave primaria % na tabela! ',new.cod_loja;
        end if;

        if new.cod_produto is null then
            raise exception 'A chave primaria não pode ser nula!';
        end if;
    end if;


    -- TODOS OS DEMAIS CAMPOS precisam ser validados nas operacoes INSERT e UPDATE
    if new.nome is null  then
        raise exception 'o campo nome tem valor inválido!';
    end if;
     if new.valor  is null  or new.valor <0 then
        raise exception 'o campo valor tem valor inválido!';
    end if;
    if new.categoria is null  then
        raise exception 'o campo categoria tem valor inválido!';
    end if;


    return new;
end;
$valida_produto$ language plpgsql;


 create or replace trigger trigger_valida_produto before insert OR update
 on produto for each row execute procedure valida_produto();




/*
 ========================================
 ||                                    ||
 ||Trigger da tabela   FUNCIONARIO     ||
 ||                                    ||
 ========================================
 */

 -- >>>>>>>>>>>>>>>>  INSERT e UPDATE
create or replace function valida_funcionario() returns trigger as $valida_funcionario$
begin

    -- cod_funcionario (cod_funcionario é a chave primária da tabela, 
    --  só devemos nos preocupar em validar ela na operação INSERT)
    if TG_OP='INSERT' then
        if exists(SELECT cod_funcionario from funcionario where cod_funcionario=new.cod_funcionario) then
            raise exception 'Já existe um funcionário usando a chave primaria % na tabela! ',new.cod_funcionario;
        end if;

        if new.cod_funcionario is null then
            raise exception 'A chave primaria não pode ser nula!';
        end if;
    end if;
   
  -- TODOS OS DEMAIS CAMPOS precisam ser validados nas operacoes INSERT e UPDATE
    if new.nome is null  then
        raise exception 'o campo nome tem valor inválido!';
    end if;
     if new.telefone  is null or not VALIDAR_TELEFONE (new.telefone) then
        raise exception 'o campo telefone tem valor inválido!';
    end if;
    if new.salario is null or new.salario<0 then
        raise exception 'o campo salario tem valor inválido!';
    end if;
    if new.dt_nasc is null  then
        raise exception 'o campo dt_nasc tem valor inválido!';
    end if;
    if new.cpf is null  then
        raise exception 'o campo cpf tem valor inválido!';
    end if;
    if new.cep is null  then
        raise exception 'o campo cep tem valor inválido!';
    end if;
    if new.pais is null  then
        raise exception 'o campo pais tem valor inválido!';
    end if;
    if new.estado is null  then
        raise exception 'o campo estado tem valor inválido!';
    end if;
    if new.cidade is null  then
        raise exception 'o campo cidade tem valor inválido!';
    end if;
    if new.bairro is null  then
        raise exception 'o campo bairro tem valor inválido!';
    end if;
    if new.logradouro is null  then
        raise exception 'o campo logradouro tem valor inválido!';
    end if;
    if new.numero is null  then
        raise exception 'o campo numero tem valor inválido!';
    end if;

    if new.cod_cargo is not null  then
        IF NOT EXISTS (SELECT 1 FROM cargo WHERE cod_cargo = NEW.cod_cargo) THEN
            RAISE EXCEPTION 'VALIDACAO: Não foi encontrado nenhum cargo com o código % na tabela. ', NEW.cod_cargo;
        END IF;
    end if;



    return new;
end;
$valida_funcionario$ language plpgsql;


 create or replace trigger trigger_valida_funcionario before insert OR update
 on funcionario for each row execute procedure valida_funcionario();





/*
 ========================================
 ||                                    ||
 ||Trigger da tabela   ESTOQUE         ||
 ||                                    ||
 ========================================
 */
 
 -- >>>>>>>>>>>>>>>>  INSERT e UPDATE
create or replace function valida_estoque() returns trigger as $valida_estoque$
begin

    -- cod_estoque (cod_estoque é a chave primária da tabela, 
    --  só devemos nos preocupar em validar ela na operação INSERT)
    if TG_OP='INSERT' then
        if exists(SELECT cod_estoque from estoque where cod_estoque=new.cod_estoque) then
            raise exception 'Já existe um estoque usando a chave primaria % na tabela! ',new.cod_estoque;
        end if;

        if new.cod_estoque is null then
            raise exception 'A chave primaria não pode ser nula!';
        end if;
    end if;

    -- TODOS OS DEMAIS CAMPOS precisam ser validados nas operacoes INSERT e UPDATE
    
    -- quantidade
    if new.quantidade is null or new.quantidade<0 then
        raise exception 'o campo quant  invalido!';
    end if;
    if new.quantidade<0 then
        raise exception 'o campo quantidade  invalido!';
    end if;
    -- cod_loja
    if new.cod_loja is not null  then
        IF NOT EXISTS (SELECT 1 FROM loja WHERE cod_loja = NEW.cod_loja) THEN
            RAISE EXCEPTION 'VALIDACAO: Não foi encontrado nenhuma loja com o código % na tabela . ', NEW.cod_loja;
        END IF;
    end if;
   

   -- cod_produto
    if new.cod_produto is not null  then
        IF NOT EXISTS (SELECT 1 FROM produto WHERE cod_produto = NEW.cod_produto) THEN
            RAISE EXCEPTION 'VALIDACAO: Não foi encontrado nenhum produto com o código % na tabela . ', NEW.cod_produto;
        END IF;
    end if;
    
    
    

    return new;
end;
$valida_estoque$ language plpgsql;


 create or replace trigger trigger_valida_estoque before insert OR update
 on estoque for each row execute procedure valida_estoque();


 /*
 ========================================
 ||                                    ||
 ||Trigger da tabela  ITEM_PEDIDO      ||
 ||                                    ||
 ========================================
 */

 
 
 -- >>>>>>>>>>>>>>>>  INSERT
create or replace function valida_item_pedido() returns trigger as $valida_item_pedido$
begin
    -- cod_item_pedido (cod_item_pedido é a chave primária da tabela, 
    --  só devemos nos preocupar em validar ela na operação INSERT)
    if TG_OP='INSERT' then
         if exists(SELECT cod_item_pedido from item_pedido where cod_item_pedido=new.cod_item_pedido) then
            raise exception 'Já existe um item_pedido usando a chave primaria % na tabela! ',new.cod_item_pedido;
         end if;

         UPDATE estoque set quantidade=quantidade+new.quantidade WHERE cod_estoque=NEW.cod_estoque;
    end if;
   
     -- TODOS OS DEMAIS CAMPOS precisam ser validados nas operacoes INSERT e UPDATE
    
     -- cod_estoque
    if new.cod_estoque is null then
        raise exception 'A chave primaria não pode ser nula!';
    end if;

     IF NOT EXISTS (SELECT 1 FROM estoque WHERE cod_estoque = NEW.cod_estoque) THEN
        RAISE EXCEPTION 'VALIDACAO: Não foi encontrado nenhum estoque com o código % na tabela. ', NEW.cod_estoque;
    END IF;

      -- quantidade
    if new.quantidade is null or new.quantidade<0 then
        raise exception 'o campo quant  invalido!';
    end if;
    if  new.quantidade<0 then
        raise exception 'o campo quantidade  invalido!';
    end if;
     -- valor_unitario
    if  new.valor_unitario<0 then
        raise exception 'o campo valor_unitario  invalido!';
    end if;
     -- valor_total
    if new.valor_total<0 then
        raise exception 'o campo valor_total  invalido!';
    end if;

   -- cod_pedido
    if new.cod_pedido is not null  then
        IF NOT EXISTS (SELECT 1 FROM pedido WHERE cod_pedido = NEW.cod_pedido) THEN
            RAISE EXCEPTION 'VALIDACAO: Não foi encontrado nenhum pedido com o código % na tabela. ', NEW.cod_pedido;
        END IF;
    end if;
   
    
    

    return new;
end;
$valida_item_pedido$ language plpgsql;


 create or replace trigger trigger_valida_item_pedido before insert OR update
 on item_pedido for each row execute procedure valida_item_pedido();


 /*
 ========================================
 ||                                    ||
 ||Trigger da tabela    PEDIDO         ||
 ||                                    ||
 ========================================
 */
 
 -- >>>>>>>>>>>>>>>>  INSERT
create or replace function valida_pedido() returns trigger as $valida_pedido$
begin


    -- cod_pedido (cod_pedido é a chave primária da tabela, 
    --  só devemos nos preocupar em validar ela na operação INSERT)
    if TG_OP='INSERT' then
          if exists(SELECT cod_pedido from pedido where cod_pedido=new.cod_pedido) then
             raise exception 'Já existe um pedido usando a chave primaria % na tabela! ',new.cod_pedido;
          end if;

          if new.cod_pedido is null then
             raise exception 'A chave primaria não pode ser nula!';
          end if;

    end if;
   
   -- TODOS OS DEMAIS CAMPOS precisam ser validados nas operacoes INSERT e UPDATE


   -- cod_fornecedor
    if new.cod_fornecedor is not null  then
        IF NOT EXISTS (SELECT 1 FROM fornecedor  WHERE cod_fornecedor = NEW.cod_fornecedor) THEN
            RAISE EXCEPTION 'VALIDACAO: Não foi encontrado nenhum fornecedor com o código % na tabela. ', NEW.cod_fornecedor;
        END IF;   
    end if;
    

    -- cod_funcionario
    if new.cod_funcionario is not null  then
        IF NOT EXISTS (SELECT 1 FROM funcionario  WHERE cod_funcionario = NEW.cod_funcionario) THEN
            RAISE EXCEPTION 'VALIDACAO: Não foi encontrado nenhum funcionario com o código % na tabela. ', NEW.cod_funcionario;
        END IF;
    end if;
    
    
    

    return new;
end;
$valida_pedido$ language plpgsql;


 create or replace trigger trigger_valida_pedido before insert OR update
 on pedido for each row execute procedure valida_pedido();


 /*
 ========================================
 ||                                    ||
 ||Trigger da tabela    VENDA          ||
 ||                                    ||
 ========================================
 */
 
 -- >>>>>>>>>>>>>>>>  INSERT e UPDATE
create or replace function valida_venda() returns trigger as $valida_venda$
begin

    -- cod_venda (cod_venda é a chave primária da tabela, 
    --  só devemos nos preocupar em validar ela na operação INSERT)
    if TG_OP='INSERT' then
        if exists(SELECT cod_venda from venda where cod_venda=new.cod_venda) then
            raise exception 'Já existe uma venda usando a chave primaria % na tabela! ',new.cod_venda;
        end if;

        if new.cod_venda is null then
            raise exception 'A chave primaria não pode ser nula!';
        end if;

    end if;
   
   -- TODOS OS DEMAIS CAMPOS precisam ser validados nas operacoes INSERT e UPDATE

    -- dt_venda
    if new.dt_venda is null  then
        raise exception 'o campo dt_venda  invalido!';
    end if;
     -- valor_total
    if new.valor_total<0 then
        raise exception 'o campo valor_total  invalido!';
    end if;
   -- cod_cliente
    if new.cod_cliente is not null  then
        IF NOT EXISTS (SELECT 1 FROM cliente  WHERE cod_cliente = NEW.cod_cliente) THEN
            RAISE EXCEPTION 'VALIDACAO: Não foi encontrado nenhum cliente com o código % na tabela cliente. ', NEW.cod_cliente;
        END IF;
    end if;
   
    -- cod_funcionario
    if new.cod_funcionario is not null  then
        IF NOT EXISTS (SELECT 1 FROM funcionario  WHERE cod_funcionario = NEW.cod_funcionario) THEN
            RAISE EXCEPTION 'VALIDACAO: Não foi encontrado nenhum funcionario com o código % na tabela. ', NEW.cod_funcionario;
        END IF;
    end if;
    
    
    
    return new;
end;
$valida_venda$ language plpgsql;


 create or replace trigger trigger_valida_venda before insert OR update
 on venda for each row execute procedure valida_venda();




 /*
 ========================================
 ||                                    ||
 ||Trigger da tabela  ITEM_VENDA       ||
 ||                                    ||
 ========================================
 */
 
 -- >>>>>>>>>>>>>>>>  INSERT
create or replace function valida_item_venda() returns trigger as $valida_item_venda$
begin

    
    -- cod_item_venda (cod_item_venda é a chave primária da tabela, 
    --  só devemos nos preocupar em validar ela na operação INSERT)
    if TG_OP='INSERT' then
        if new.cod_item_venda is  null then
            raise exception 'A chave primaria nao pode ser nula! ';
        end if;
        if exists(SELECT cod_item_venda from item_venda where cod_item_venda=new.cod_item_venda) then
            raise exception 'Já existe um item_venda usando a chave primaria % na tabela! ',new.cod_item_venda;
        end if; 

        UPDATE estoque set quantidade=quantidade-new.quantidade WHERE cod_estoque=NEW.cod_estoque;
    

    end if;
   
   -- TODOS OS DEMAIS CAMPOS precisam ser validados nas operacoes INSERT e UPDATE

     -- cod_estoque
    if new.cod_estoque is not null then
        IF NOT EXISTS (SELECT 1 FROM estoque WHERE cod_estoque = NEW.cod_estoque) THEN
            RAISE EXCEPTION 'VALIDACAO: Não foi encontrado nenhum estoque com o código % na tabela. ', NEW.cod_estoque;
        END IF;
    end if;

    

    -- cod_venda
    if new.cod_venda is not null  then
        IF NOT EXISTS (SELECT 1 FROM venda WHERE cod_venda = NEW.cod_venda) THEN
            RAISE EXCEPTION 'VALIDACAO: Não foi encontrado nenhuma venda com o código % na tabela. ', NEW.cod_venda;
        END IF;
    end if;
   
    
      -- quantidade
    if new.quantidade is null or new.quantidade<0 then
        raise exception 'o campo quantidade  invalido!';
    end if;
     -- valor_unitario
    if  new.valor_unitario<0 then
        raise exception 'o campo valor_unitario  invalido!';
    end if;
     -- valor_total
    if  new.valor_total<0 then
        raise exception 'o campo valor_total  invalido!';
    end if;

    return new;
end;
$valida_item_venda$ language plpgsql;


 create or replace trigger trigger_valida_item_venda before insert OR update
 on item_venda for each row execute procedure valida_item_venda();
