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
    nome TEXT
) RETURNS VOID AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM estoque WHERE cod_loja IN (SELECT cod_loja FROM loja WHERE nome = nome)
    ) THEN
        RAISE NOTICE 'Não é possível excluir loja. Existem registros na tabela estoque.';
    ELSE
        DELETE FROM loja WHERE nome = nome;
        RAISE NOTICE 'Loja excluída com sucesso.';
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir loja: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;







CREATE OR REPLACE FUNCTION DELETAR_FORNECEDOR(
    nome TEXT
) RETURNS VOID AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM pedido WHERE cod_fornecedor IN (SELECT cod_fornecedor FROM fornecedor WHERE nome = nome)
    ) THEN
        RAISE NOTICE 'Não é possível excluir fornecedor. Existem registros na tabela pedido.';
    ELSE
        DELETE FROM fornecedor WHERE nome = nome;
        RAISE NOTICE 'Fornecedor excluído com sucesso.';
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir fornecedor: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;







CREATE OR REPLACE FUNCTION DELETAR_PRODUTO(
    nome TEXT
) RETURNS VOID AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM estoque WHERE cod_produto IN (SELECT cod_produto FROM produto WHERE nome = nome)
    ) OR EXISTS (
        SELECT 1 FROM item_pedido WHERE cod_estoque IN (SELECT cod_estoque FROM estoque WHERE cod_produto IN (SELECT cod_produto FROM produto WHERE nome = nome))
    ) OR EXISTS (
        SELECT 1 FROM item_venda WHERE cod_estoque IN (SELECT cod_estoque FROM estoque WHERE cod_produto IN (SELECT cod_produto FROM produto WHERE nome = nome))
    ) THEN
        RAISE NOTICE 'Não é possível excluir produto. Existem registros nas tabelas estoque, item_pedido ou item_venda.';
    ELSE
        DELETE FROM produto WHERE nome = nome;
        RAISE NOTICE 'Produto excluído com sucesso.';
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir produto: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;





CREATE OR REPLACE FUNCTION DELETAR_CLIENTE(
    nome TEXT
) RETURNS VOID AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM venda WHERE cod_cliente IN (SELECT cod_cliente FROM cliente WHERE nome = nome)
    ) THEN
        RAISE NOTICE 'Não é possível excluir cliente. Existem registros na tabela venda.';
    ELSE
        DELETE FROM cliente WHERE nome = nome;
        RAISE NOTICE 'Cliente excluído com sucesso.';
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir cliente: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;









CREATE OR REPLACE FUNCTION DELETAR_CARGO(
    nome TEXT
) RETURNS VOID AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM funcionario WHERE cod_cargo IN (SELECT cod_cargo FROM cargo WHERE nome = nome)
    ) THEN
        RAISE NOTICE 'Não é possível excluir cargo. Existem registros na tabela funcionario.';
    ELSE
        DELETE FROM cargo WHERE nome = nome;
        RAISE NOTICE 'Cargo excluído com sucesso.';
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir cargo: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION DELETAR_FUNCIONARIO(
    nome TEXT
) RETURNS VOID AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM pedido WHERE cod_funcionario IN (SELECT cod_funcionario FROM funcionario WHERE nome = nome)
    ) OR EXISTS (
        SELECT 1 FROM venda WHERE cod_funcionario IN (SELECT cod_funcionario FROM funcionario WHERE nome = nome)
    ) THEN
        RAISE NOTICE 'Não é possível excluir funcionário. Existem registros nas tabelas pedido ou venda.';
    ELSE
        DELETE FROM funcionario WHERE nome = nome;
        RAISE NOTICE 'Funcionário excluído com sucesso.';
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir funcionário: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;







CREATE OR REPLACE FUNCTION DELETAR_PEDIDO_COD(
    cod_pedido BIGINT
) RETURNS VOID AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM item_pedido WHERE cod_pedido = cod_pedido
    ) THEN
        RAISE NOTICE 'Não é possível excluir pedido. Existem registros na tabela item_pedido.';
    ELSE
        DELETE FROM pedido WHERE cod_pedido = cod_pedido;
        RAISE NOTICE 'Pedido excluído com sucesso.';
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir pedido: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;









CREATE OR REPLACE FUNCTION DELETAR_ESTOQUE_COD(
    cod_estoque BIGINT
) RETURNS VOID AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM item_pedido WHERE cod_estoque = cod_estoque
    ) OR EXISTS (
        SELECT 1 FROM item_venda WHERE cod_estoque = cod_estoque
    ) THEN
        RAISE NOTICE 'Não é possível excluir estoque. Existem registros nas tabelas item_pedido ou item_venda.';
    ELSE
        DELETE FROM estoque WHERE cod_estoque = cod_estoque;
        RAISE NOTICE 'Estoque excluído com sucesso.';
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir estoque: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;







CREATE OR REPLACE FUNCTION DELETAR_ITEM_PEDIDO_COD(
    cod_item_pedido BIGINT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM item_pedido WHERE cod_item_pedido = cod_item_pedido;
    RAISE NOTICE 'Item do pedido excluído com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir item do pedido: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;





CREATE OR REPLACE FUNCTION DELETAR_VENDA_COD(
    cod_venda BIGINT
) RETURNS VOID AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM item_venda WHERE cod_venda = cod_venda
    ) THEN
        RAISE NOTICE 'Não é possível excluir venda. Existem registros na tabela item_venda.';
    ELSE
        DELETE FROM venda WHERE cod_venda = cod_venda;
        RAISE NOTICE 'Venda excluída com sucesso.';
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir venda: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;






CREATE OR REPLACE FUNCTION DELETAR_ITEM_VENDA_COD(
    cod_item_venda BIGINT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM item_venda WHERE cod_item_venda = cod_item_venda;
    RAISE NOTICE 'Item da venda excluído com sucesso.';
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao excluir item da venda: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;

