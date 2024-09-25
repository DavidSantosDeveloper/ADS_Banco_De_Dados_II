CREATE OR REPLACE FUNCTION DELETAR(
    TABELA TEXT,
    NOME TEXT DEFAULT NULL,
    CODIGO BIGINT DEFAULT NULL
) RETURNS VOID AS $$
BEGIN
    IF TABELA ILIKE 'LOJA' THEN
        IF NOME IS NOT NULL THEN
            PERFORM DELETAR_LOJA(NOME);
        ELSE
            PERFORM DELETAR_LOJA_COD(CODIGO);
        END IF;

    ELSIF TABELA ILIKE 'FORNECEDOR' THEN
        IF NOME IS NOT NULL THEN
            PERFORM DELETAR_FORNECEDOR(NOME);
        ELSE
            PERFORM DELETAR_FORNECEDOR_COD(CODIGO);
        END IF;

    ELSIF TABELA ILIKE 'PRODUTO' THEN
        IF NOME IS NOT NULL THEN
            PERFORM DELETAR_PRODUTO(NOME);
        ELSE
            PERFORM DELETAR_PRODUTO_COD(CODIGO);
        END IF;

    ELSIF TABELA ILIKE 'CLIENTE' THEN
        IF NOME IS NOT NULL THEN
            PERFORM DELETAR_CLIENTE(NOME);
        ELSE
            PERFORM DELETAR_CLIENTE_COD(CODIGO);
        END IF;

    ELSIF TABELA ILIKE 'CARGO' THEN
        IF NOME IS NOT NULL THEN
            PERFORM DELETAR_CARGO(NOME);
        ELSE
            PERFORM DELETAR_CARGO_COD(CODIGO);
        END IF;

    ELSIF TABELA ILIKE 'FUNCIONARIO' THEN
        IF NOME IS NOT NULL THEN
            PERFORM DELETAR_FUNCIONARIO(NOME);
        ELSE
            PERFORM DELETAR_FUNCIONARIO_COD(CODIGO);
        END IF;

    ELSIF TABELA ILIKE 'PEDIDO' THEN
        IF NOME IS NOT NULL THEN
            PERFORM DELETAR_PEDIDO(NOME);
        ELSE
            PERFORM DELETAR_PEDIDO_COD(CODIGO);
        END IF;

    ELSIF TABELA ILIKE 'ESTOQUE' THEN
        IF NOME IS NOT NULL THEN
            PERFORM DELETAR_ESTOQUE(NOME);
        ELSE
            PERFORM DELETAR_ESTOQUE_COD(CODIGO);
        END IF;

    ELSIF TABELA ILIKE 'ITEM_PEDIDO' THEN
        IF NOME IS NOT NULL THEN
            PERFORM DELETAR_ITEM_PEDIDO(NOME);
        ELSE
            PERFORM DELETAR_ITEM_PEDIDO_COD(CODIGO);
        END IF;

    ELSIF TABELA ILIKE 'VENDA' THEN
        IF NOME IS NOT NULL THEN
            PERFORM DELETAR_VENDA(NOME);
        ELSE
            PERFORM DELETAR_VENDA_COD(CODIGO);
        END IF;

    ELSIF TABELA ILIKE 'ITEM_VENDA' THEN
        IF NOME IS NOT NULL THEN
            PERFORM DELETAR_ITEM_VENDA(NOME);
        ELSE
            PERFORM DELETAR_ITEM_VENDA_COD(CODIGO);
        END IF;

    ELSE
        RAISE EXCEPTION 'Tabela % não encontrada', TABELA;
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao deletar %: %', TABELA, SQLERRM;
END;
$$ LANGUAGE PLPGSQL;




CREATE OR REPLACE FUNCTION DELETAR_LOJA(
    _nome TEXT
) RETURNS VOID AS $$
BEGIN
     UPDATE estoque set cod_loja=null WHERE cod_loja in (select cod_loja from loja WHERE loja.nome=_nome);
    
    -- Deleta a loja
    DELETE FROM loja WHERE loja.nome = _nome;
   
    RAISE NOTICE 'Loja e suas referências excluídas com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir loja: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;





CREATE OR REPLACE FUNCTION DELETAR_FORNECEDOR(
    _nome TEXT
) RETURNS VOID AS $$
BEGIN
    
     UPDATE pedido set cod_fornecedor=null WHERE cod_fornecedor in (select cod_fornecedor from fornecedor WHERE fornecedor.nome=_nome);
    
    -- Deleta o fornecedor
    DELETE FROM fornecedor WHERE fornecedor.nome = _nome;

    RAISE NOTICE 'Fornecedor e suas referências excluídas com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir fornecedor: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;






CREATE OR REPLACE FUNCTION DELETAR_PRODUTO(
    _nome TEXT
) RETURNS VOID AS $$
BEGIN
    -- -- Deleta todos os registros na tabela estoque que referenciam o produto
    -- DELETE FROM estoque WHERE cod_produto IN (
    --     SELECT cod_produto FROM produto WHERE nome = nome
    -- );
      UPDATE estoque set cod_produto=null WHERE cod_produto in (select cod_produto from produto WHERE produto.nome=_nome);
    

    -- Deleta o produto
    DELETE FROM produto WHERE produto.nome = _nome;

    RAISE NOTICE 'Produto e suas referências excluídas com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir produto: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;







CREATE OR REPLACE FUNCTION DELETAR_CLIENTE(
    _nome TEXT
) RETURNS VOID AS $$
BEGIN
    -- Deleta todos os registros na tabela venda que referenciam o cliente
    -- DELETE FROM venda WHERE cod_cliente IN (
    --     SELECT cod_cliente FROM cliente WHERE nome = nome
    -- );
    UPDATE venda set cod_cliente=null WHERE cod_cliente in (select cod_cliente from cliente WHERE cliente.nome=_nome);
    
    -- Deleta o cliente
    DELETE FROM cliente WHERE cliente.nome = _nome;

    RAISE NOTICE 'Cliente e suas referências excluídas com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir cliente: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION DELETAR_CARGO(
    _nome TEXT
) RETURNS VOID AS $$
BEGIN
    -- -- Deleta todos os registros na tabela funcionario que referenciam o cargo
    -- DELETE FROM funcionario WHERE cod_cargo IN (
    --     SELECT cod_cargo FROM cargo WHERE nome = nome
    -- );

    UPDATE funcionario set cod_cargo=null WHERE cod_cargo in (select cod_cargo from cargo WHERE cargo.nome=_nome);
    

   
    -- Deleta o cargo
    DELETE FROM cargo WHERE cargo.nome =_nome;

    RAISE NOTICE 'Cargo e suas referências excluídas com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir cargo: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;





CREATE OR REPLACE FUNCTION DELETAR_FUNCIONARIO(
    _nome TEXT
) RETURNS VOID AS $$
BEGIN
    -- Deleta todos os registros na tabela pedido que referenciam o funcionário
    -- DELETE FROM pedido WHERE cod_funcionario IN (
    --     SELECT cod_funcionario FROM funcionario WHERE nome = nome
    -- );
     UPDATE pedido set cod_funcionario=null WHERE cod_funcionario in (select cod_funcionario from funcionario WHERE funcionario.nome=_nome);
    

    -- -- Deleta todos os registros na tabela venda que referenciam o funcionário
    -- DELETE FROM venda WHERE cod_funcionario IN (
    --     SELECT cod_funcionario FROM funcionario WHERE nome = nome
    -- );
     UPDATE venda set cod_funcionario=null WHERE cod_funcionario in (select cod_funcionario from funcionario WHERE funcionario.nome=_nome);
    
    -- Deleta o funcionário
    DELETE FROM funcionario WHERE funcionario.nome = _nome;

    RAISE NOTICE 'Funcionário e suas referências excluídas com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir funcionário: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;





CREATE OR REPLACE FUNCTION DELETAR_PEDIDO_COD(
    _cod_pedido BIGINT
) RETURNS VOID AS $$
BEGIN
    -- -- Deleta todos os registros na tabela item_pedido que referenciam o pedido
    -- DELETE FROM item_pedido WHERE cod_pedido = cod_pedido;
    UPDATE item_pedido set cod_pedido=null WHERE item_pedido.cod_pedido=_cod_pedido;
    


    -- Deleta o pedido
    DELETE FROM pedido WHERE cod_pedido = _cod_pedido;

    RAISE NOTICE 'Pedido e suas referências excluídas com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir pedido: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION DELETAR_ESTOQUE_COD(
    _cod_estoque BIGINT
) RETURNS VOID AS $$
BEGIN
    -- -- Deleta todos os registros na tabela item_pedido que referenciam o estoque
    -- DELETE FROM item_pedido WHERE cod_estoque = cod_estoque;
    UPDATE item_pedido set cod_estoque=null WHERE estoque.cod_estoque=_cod_estoque;

    -- -- Deleta todos os registros na tabela item_venda que referenciam o estoque
    -- DELETE FROM item_venda WHERE cod_estoque = cod_estoque;
    UPDATE item_venda set cod_estoque=null WHERE estoque.cod_estoque=_cod_estoque;

    -- Deleta o estoque
    DELETE FROM estoque WHERE cod_estoque = _cod_estoque;

    RAISE NOTICE 'Estoque e suas referências excluídas com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir estoque: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;






CREATE OR REPLACE FUNCTION DELETAR_ITEM_PEDIDO_COD(
    _cod_item_pedido BIGINT
) RETURNS VOID AS $$
BEGIN
    -- Deleta o item do pedido
    DELETE FROM item_pedido WHERE cod_item_pedido = _cod_item_pedido;

    RAISE NOTICE 'Item do pedido excluído com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir item do pedido: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;






CREATE OR REPLACE FUNCTION DELETAR_VENDA_COD(
    _cod_venda BIGINT
) RETURNS VOID AS $$
BEGIN
    -- -- Deleta todos os registros na tabela item_venda que referenciam a venda
    -- DELETE FROM item_venda WHERE cod_venda = cod_venda;
      UPDATE item_venda set cod_venda=null WHERE item_venda.cod_venda=_cod_venda; 

    -- Deleta a venda
    DELETE FROM venda WHERE cod_venda = _cod_venda;

    RAISE NOTICE 'Venda e suas referências excluídas com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir venda: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;







CREATE OR REPLACE FUNCTION DELETAR_ITEM_VENDA_COD(
    _cod_item_venda BIGINT
) RETURNS VOID AS $$
BEGIN
    -- Deleta o item da venda
    DELETE FROM item_venda WHERE cod_item_venda = _cod_item_venda;

    RAISE NOTICE 'Item da venda excluído com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir item da venda: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;
