/*
 ========================================
 ||                                    ||
 ||       Função para CADASTRAR        ||
 ||                                    ||
 ========================================
 */


CREATE OR REPLACE FUNCTION CADASTRAR(
    TABELA TEXT,
    P1 TEXT DEFAULT NULL,
    P2 TEXT DEFAULT NULL,
    P3 TEXT DEFAULT NULL,
    P4 TEXT DEFAULT NULL,
    P5 TEXT DEFAULT NULL,
    P6 TEXT DEFAULT NULL,
    P7 TEXT DEFAULT NULL,
    P8 TEXT DEFAULT NULL,
    P9 TEXT DEFAULT NULL,
    P10 TEXT DEFAULT NULL,
    P11 TEXT DEFAULT NULL,
    P12 TEXT DEFAULT NULL,
    P13 TEXT DEFAULT NULL
) RETURNS VOID AS $$
BEGIN
    IF TABELA ILIKE 'LOJA' THEN
        -- Chama função de cadastro de loja
        EXECUTE FORMAT('SELECT CADASTRAR_LOJA(%L, %L, %L, %L, %L, %L, %L, %L, %L)', P1, P2, P3, P4, P5, P6, P7, P8, P9);

    ELSIF TABELA ILIKE 'FORNECEDOR' THEN
        -- Chama função de cadastro de fornecedor
        EXECUTE FORMAT('SELECT CADASTRAR_FORNECEDOR(%L, %L)', P1, P2);

    ELSIF TABELA ILIKE 'PRODUTO' THEN
        -- Chama função de cadastro de produto
        EXECUTE FORMAT('SELECT CADASTRAR_PRODUTO(%L, %L, %L)', P1, P2, P3);

    ELSIF TABELA ILIKE 'CLIENTE' THEN
        -- Chama função de cadastro de cliente
        EXECUTE FORMAT('SELECT CADASTRAR_CLIENTE(%L, %L)', P1, P2);

    ELSIF TABELA ILIKE 'CARGO' THEN
        -- Chama função de cadastro de cargo
        EXECUTE FORMAT('SELECT CADASTRAR_CARGO(%L, %L)', P1, P2);

    ELSIF TABELA ILIKE 'FUNCIONARIO' THEN
        -- Chama função de cadastro de funcionário
        EXECUTE FORMAT(
            'SELECT CADASTRAR_FUNCIONARIO(%L, %L, %L, %L, %L, %L, %L, %L, %L, %L, %L, %L, %L)', 
            P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13
        );

    ELSIF TABELA ILIKE 'PEDIDO' THEN
        -- Chama função de cadastro de pedido
        EXECUTE FORMAT('SELECT CADASTRAR_PEDIDO(%L, %L)', P1, P2);

    ELSIF TABELA ILIKE 'ESTOQUE' THEN
        -- Chama função de cadastro de estoque
        EXECUTE FORMAT('SELECT CADASTRAR_ESTOQUE(%L, %L, %L)', P1, P2, P3);

    ELSIF TABELA ILIKE 'ITEM_PEDIDO' THEN
        -- Chama função de cadastro de item de pedido
        EXECUTE FORMAT('SELECT CADASTRAR_ITEM_PEDIDO(%L, %L, %L, %L, %L)', P1, P2, P3, P4, P5);

    ELSIF TABELA ILIKE 'VENDA' THEN
        -- Chama função de cadastro de venda
        EXECUTE FORMAT('SELECT CADASTRAR_VENDA(%L, %L, %L, %L)', P1, P2, P3, P4);

    ELSIF TABELA ILIKE 'ITEM_VENDA' THEN
        -- Chama função de cadastro de item de venda
        EXECUTE FORMAT('SELECT CADASTRAR_ITEM_VENDA(%L, %L, %L, %L, %L)', P1, P2, P3, P4, P5);

    ELSE
        -- Caso a tabela não seja encontrada
        RAISE EXCEPTION 'TABELA NÃO ENCONTRADA';
    END IF;
END;
$$ LANGUAGE PLPGSQL;





/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR LOJA        ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION CADASTRAR_LOJA(
    nome TEXT, telefone VARCHAR, cep VARCHAR, pais VARCHAR, estado VARCHAR, 
    cidade VARCHAR, bairro VARCHAR, logradouro VARCHAR, numero INT) RETURNS VOID AS $$
BEGIN
    INSERT INTO loja VALUES (DEFAULT, nome, telefone, cep, pais, estado, cidade, bairro, logradouro, numero);
END;
$$ LANGUAGE PLPGSQL;


/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR FORNECEDOR  ||
 ||                                    ||
 ========================================
 */
CREATE OR REPLACE FUNCTION CADASTRAR_FORNECEDOR(nome TEXT, telefone VARCHAR) RETURNS VOID AS $$
BEGIN
    INSERT INTO fornecedor VALUES (DEFAULT, nome, telefone);
END;
$$ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR PRODUTO     ||
 ||                                    ||
 ========================================
 */
CREATE OR REPLACE FUNCTION CADASTRAR_PRODUTO(
    nome TEXT, valor NUMERIC, categoria VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO produto VALUES (DEFAULT, nome, valor, categoria);
END;
$$ LANGUAGE PLPGSQL;
/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR CLIENTE     ||
 ||                                    ||
 ========================================
 */
CREATE OR REPLACE FUNCTION CADASTRAR_CLIENTE(
    nome TEXT, telefone VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO cliente VALUES (DEFAULT, nome, telefone);
END;
$$ LANGUAGE PLPGSQL;
/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR CARGO       ||
 ||                                    ||
 ========================================
 */
 CREATE OR REPLACE FUNCTION CADASTRAR_CARGO(
    nome VARCHAR, descricao TEXT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO cargo VALUES (DEFAULT, nome, descricao);
END;
$$ LANGUAGE PLPGSQL;
/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR FUNCIONARIO ||
 ||                                    ||
 ========================================
 */
 CREATE OR REPLACE FUNCTION CADASTRAR_FUNCIONARIO(
    nome TEXT, telefone VARCHAR, salario DECIMAL, dt_nasc DATE, cpf VARCHAR, 
    cep VARCHAR, pais VARCHAR, estado VARCHAR, cidade VARCHAR, bairro VARCHAR, 
    logradouro VARCHAR, numero VARCHAR, cod_cargo BIGINT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO funcionario VALUES (DEFAULT, nome, telefone, salario, dt_nasc, cpf, cep, pais, estado, cidade, bairro, logradouro, numero, cod_cargo);
END;
$$ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR PEDIDO      ||
 ||                                    ||
 ========================================
 */

 CREATE OR REPLACE FUNCTION CADASTRAR_PEDIDO(
    cod_fornecedor BIGINT, cod_funcionario BIGINT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO pedido VALUES (DEFAULT, cod_fornecedor, cod_funcionario);
END;
$$ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR ESTOQUE     ||
 ||                                    ||
 ========================================
 */
 CREATE OR REPLACE FUNCTION CADASTRAR_ESTOQUE(
    quantidade BIGINT, cod_loja BIGINT, cod_produto BIGINT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO estoque VALUES (DEFAULT, quantidade, cod_loja, cod_produto);
END;
$$ LANGUAGE PLPGSQL;
/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR ITEM_PEDIDO ||
 ||                                    ||
 ========================================
 */
 CREATE OR REPLACE FUNCTION CADASTRAR_ITEM_PEDIDO(
    quantidade BIGINT, valor_unitario NUMERIC, valor_total NUMERIC, cod_estoque BIGINT, cod_pedido BIGINT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO item_pedido VALUES (DEFAULT, quantidade, valor_unitario, valor_total, cod_estoque, cod_pedido);
END;
$$ LANGUAGE PLPGSQL;
/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR   VENDA     ||
 ||                                    ||
 ========================================
 */
 CREATE OR REPLACE FUNCTION CADASTRAR_VENDA(
    dt_venda DATE, valor_total NUMERIC, cod_cliente BIGINT, cod_funcionario BIGINT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO venda VALUES (DEFAULT, dt_venda, valor_total, cod_cliente, cod_funcionario);
END;
$$ LANGUAGE PLPGSQL;
/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR  ITEM_VENDA ||
 ||                                    ||
 ========================================
 */
 CREATE OR REPLACE FUNCTION CADASTRAR_ITEM_VENDA(
    quantidade BIGINT, valor_unitario NUMERIC, valor_total NUMERIC, cod_estoque BIGINT, cod_venda BIGINT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO item_venda VALUES (DEFAULT, quantidade, valor_unitario, valor_total, cod_estoque, cod_venda);
END;
$$ LANGUAGE PLPGSQL;
