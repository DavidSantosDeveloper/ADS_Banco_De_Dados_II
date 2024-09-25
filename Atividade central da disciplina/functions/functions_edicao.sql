CREATE OR REPLACE FUNCTION EDITAR(
    TABELA TEXT,
    CAMPO TEXT, 
    NOVO_VALOR TEXT, 
    NOME TEXT DEFAULT NULL,
    CODIGO BIGINT DEFAULT NULL
) RETURNS VOID AS $$
BEGIN
    IF TABELA ILIKE 'LOJA' THEN
        IF NOME IS NOT NULL THEN
            PERFORM EDITAR_LOJA(NOME, CAMPO, NOVO_VALOR);
        ELSE
            PERFORM EDITAR_LOJA_COD(CODIGO, CAMPO, NOVO_VALOR);
        END IF;

    ELSIF TABELA ILIKE 'FORNECEDOR' THEN
        IF NOME IS NOT NULL THEN
            PERFORM EDITAR_FORNECEDOR(NOME, CAMPO, NOVO_VALOR);
        ELSE
            PERFORM EDITAR_FORNECEDOR_COD(CODIGO, CAMPO, NOVO_VALOR);
        END IF;

    ELSIF TABELA ILIKE 'PRODUTO' THEN
        IF NOME IS NOT NULL THEN
            PERFORM EDITAR_PRODUTO(NOME, CAMPO, NOVO_VALOR);
        ELSE
            PERFORM EDITAR_PRODUTO_COD(CODIGO, CAMPO, NOVO_VALOR);
        END IF;

    ELSIF TABELA ILIKE 'CLIENTE' THEN
        IF NOME IS NOT NULL THEN
            PERFORM EDITAR_CLIENTE(NOME, CAMPO, NOVO_VALOR);
        ELSE
            PERFORM EDITAR_CLIENTE_COD(CODIGO, CAMPO, NOVO_VALOR);
        END IF;

    ELSIF TABELA ILIKE 'CARGO' THEN
        IF NOME IS NOT NULL THEN
            PERFORM EDITAR_CARGO(NOME, CAMPO, NOVO_VALOR);
        ELSE
            PERFORM EDITAR_CARGO_COD(CODIGO, CAMPO, NOVO_VALOR);
        END IF;

    ELSIF TABELA ILIKE 'FUNCIONARIO' THEN
        IF NOME IS NOT NULL THEN
            PERFORM EDITAR_FUNCIONARIO(NOME, CAMPO, NOVO_VALOR);
        ELSE
            PERFORM EDITAR_FUNCIONARIO_COD(CODIGO, CAMPO, NOVO_VALOR);
        END IF;

    ELSIF TABELA ILIKE 'PEDIDO' THEN
        IF NOME IS NOT NULL THEN
            PERFORM EDITAR_PEDIDO(NOME, CAMPO, NOVO_VALOR);
        ELSE
            PERFORM EDITAR_PEDIDO_COD(CODIGO, CAMPO, NOVO_VALOR);
        END IF;

    ELSIF TABELA ILIKE 'ESTOQUE' THEN
        IF NOME IS NOT NULL THEN
            PERFORM EDITAR_ESTOQUE(NOME, CAMPO, NOVO_VALOR);
        ELSE
            PERFORM EDITAR_ESTOQUE_COD(CODIGO, CAMPO, NOVO_VALOR);
        END IF;

    ELSIF TABELA ILIKE 'ITEM_PEDIDO' THEN
        IF NOME IS NOT NULL THEN
            PERFORM EDITAR_ITEM_PEDIDO(NOME, CAMPO, NOVO_VALOR);
        ELSE
            PERFORM EDITAR_ITEM_PEDIDO_COD(CODIGO, CAMPO, NOVO_VALOR);
        END IF;

    ELSIF TABELA ILIKE 'VENDA' THEN
        IF NOME IS NOT NULL THEN
            PERFORM EDITAR_VENDA(NOME, CAMPO, NOVO_VALOR);
        ELSE
            PERFORM EDITAR_VENDA_COD(CODIGO, CAMPO, NOVO_VALOR);
        END IF;

    ELSIF TABELA ILIKE 'ITEM_VENDA' THEN
        IF NOME IS NOT NULL THEN
            PERFORM EDITAR_ITEM_VENDA(NOME, CAMPO, NOVO_VALOR);
        ELSE
            PERFORM EDITAR_ITEM_VENDA_COD(CODIGO, CAMPO, NOVO_VALOR);
        END IF;

    ELSE
        RAISE EXCEPTION 'Tabela % não encontrada', TABELA;
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar %: %', TABELA, SQLERRM;
END;
$$ LANGUAGE PLPGSQL;







CREATE OR REPLACE FUNCTION EDITAR_LOJA(
    nome TEXT,
    campo TEXT,
    novo_valor TEXT
) RETURNS VOID AS $$
BEGIN
    IF campo NOT IN ('nome', 'telefone', 'cep', 'pais', 'estado', 'cidade', 'bairro', 'logradouro', 'numero') THEN
        RAISE EXCEPTION 'Campo inválido para a tabela loja';
    END IF;

    EXECUTE FORMAT('UPDATE loja SET %I = %L WHERE nome = %L', campo, novo_valor, nome);
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar loja: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION EDITAR_FORNECEDOR(
    nome TEXT,
    campo TEXT,
    novo_valor TEXT
) RETURNS VOID AS $$
BEGIN
    IF campo NOT IN ('nome', 'telefone') THEN
        RAISE EXCEPTION 'Campo inválido para a tabela fornecedor';
    END IF;

    EXECUTE FORMAT('UPDATE fornecedor SET %I = %L WHERE nome = %L', campo, novo_valor, nome);
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar fornecedor: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;





CREATE OR REPLACE FUNCTION EDITAR_PRODUTO(
    nome TEXT,
    campo TEXT,
    novo_valor TEXT
) RETURNS VOID AS $$
BEGIN
    IF campo NOT IN ('nome', 'valor', 'categoria') THEN
        RAISE EXCEPTION 'Campo inválido para a tabela produto';
    END IF;

    EXECUTE FORMAT('UPDATE produto SET %I = %L WHERE nome = %L', campo, novo_valor, nome);
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar produto: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;






CREATE OR REPLACE FUNCTION EDITAR_CLIENTE(
    nome TEXT,
    campo TEXT,
    novo_valor TEXT
) RETURNS VOID AS $$
BEGIN
    IF campo NOT IN ('nome', 'telefone') THEN
        RAISE EXCEPTION 'Campo inválido para a tabela cliente';
    END IF;

    EXECUTE FORMAT('UPDATE cliente SET %I = %L WHERE nome = %L', campo, novo_valor, nome);
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar cliente: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;







CREATE OR REPLACE FUNCTION EDITAR_CARGO(
    nome TEXT,
    campo TEXT,
    novo_valor TEXT
) RETURNS VOID AS $$
BEGIN
    IF campo NOT IN ('nome', 'descricao') THEN
        RAISE EXCEPTION 'Campo inválido para a tabela cargo';
    END IF;

    EXECUTE FORMAT('UPDATE cargo SET %I = %L WHERE nome = %L', campo, novo_valor, nome);
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar cargo: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;







CREATE OR REPLACE FUNCTION EDITAR_FUNCIONARIO(
    nome TEXT,
    campo TEXT,
    novo_valor TEXT
) RETURNS VOID AS $$
BEGIN
    IF campo NOT IN ('nome', 'telefone', 'salario', 'dt_nasc', 'cpf', 'cep', 'pais', 'estado', 'cidade', 'bairro', 'logradouro', 'numero', 'cod_cargo') THEN
        RAISE EXCEPTION 'Campo inválido para a tabela funcionario';
    END IF;

    EXECUTE FORMAT('UPDATE funcionario SET %I = %L WHERE nome = %L', campo, novo_valor, nome);
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar funcionario: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;







CREATE OR REPLACE FUNCTION EDITAR_PEDIDO_COD(
    cod_pedido BIGINT,
    campo TEXT,
    novo_valor TEXT
) RETURNS VOID AS $$
BEGIN
    IF campo NOT IN ('cod_fornecedor', 'cod_funcionario') THEN
        RAISE EXCEPTION 'Campo inválido para a tabela pedido';
    END IF;

    EXECUTE FORMAT('UPDATE pedido SET %I = %L WHERE cod_pedido = %L', campo, novo_valor, cod_pedido);
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar pedido: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;









CREATE OR REPLACE FUNCTION EDITAR_ESTOQUE_COD(
    cod_estoque BIGINT,
    campo TEXT,
    novo_valor TEXT
) RETURNS VOID AS $$
BEGIN
    IF campo NOT IN ('quantidade', 'cod_loja', 'cod_produto') THEN
        RAISE EXCEPTION 'Campo inválido para a tabela estoque';
    END IF;

    EXECUTE FORMAT('UPDATE estoque SET %I = %L WHERE cod_estoque = %L', campo, novo_valor, cod_estoque);
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar estoque: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;







CREATE OR REPLACE FUNCTION EDITAR_ITEM_PEDIDO_COD(
    cod_item_pedido BIGINT,
    campo TEXT,
    novo_valor TEXT
) RETURNS VOID AS $$
BEGIN
    IF campo NOT IN ('quantidade', 'valor_unitario', 'valor_total', 'cod_estoque', 'cod_pedido') THEN
        RAISE EXCEPTION 'Campo inválido para a tabela item_pedido';
    END IF;

    EXECUTE FORMAT('UPDATE item_pedido SET %I = %L WHERE cod_item_pedido = %L', campo, novo_valor, cod_item_pedido);
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar item_pedido: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;




CREATE OR REPLACE FUNCTION EDITAR_VENDA_COD(
    cod_venda BIGINT,
    campo TEXT,
    novo_valor TEXT
) RETURNS VOID AS $$
BEGIN
    IF campo NOT IN ('dt_venda', 'valor_total', 'cod_cliente', 'cod_funcionario') THEN
        RAISE EXCEPTION 'Campo inválido para a tabela venda';
    END IF;

    EXECUTE FORMAT('UPDATE venda SET %I = %L WHERE cod_venda = %L', campo, novo_valor, cod_venda);
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar venda: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;





CREATE OR REPLACE FUNCTION EDITAR_ITEM_VENDA_COD(
    cod_item_venda BIGINT,
    campo TEXT,
    novo_valor TEXT
) RETURNS VOID AS $$
BEGIN
    IF campo NOT IN ('quantidade', 'valor_unitario', 'valor_total', 'cod_estoque', 'cod_venda') THEN
        RAISE EXCEPTION 'Campo inválido para a tabela item_venda';
    END IF;

    EXECUTE FORMAT('UPDATE item_venda SET %I = %L WHERE cod_item_venda = %L', campo, novo_valor, cod_item_venda);
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erro ao editar item_venda: %', SQLERRM;
END;
$$ LANGUAGE PLPGSQL;





