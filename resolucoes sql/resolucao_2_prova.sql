----------------TABELA PRODUTO------------------
CREATE TABLE PRODUTO
(COD_PROD INT NOT NULL PRIMARY KEY,
NOME_PROD VARCHAR NOT NULL,
VALOR_VENDA FLOAT NOT NULL,
E_COMBO CHAR(1) NOT NULL CHECK (E_COMBO='s' OR E_COMBO='n'));
/*OBS: O CAMPO 'E_COMBO' INDICARÁ SE O PRODUTO É COMBO OU NÃO
       ELE PODERÁ RECEBER APENAS OS VALORES 's' MINÚSCULO 
	   QUE SIGNIFICARÁ 'SIM' OU 'n' MINÚSCULO QUE 
	   SIGNIFICARÁ 'NÃO'.*/

INSERT INTO PRODUTO VALUES
(1,'refrigerante',10,'n'),
(2,'sanduíche',15,'n'),
(3,'combo da semana',40,'s'),
(4,'mini-pizza',20,'n');

----------------TABELA COMBO------------------
CREATE TABLE COMBO
(COD_PROD_COMBO INT NOT NULL REFERENCES PRODUTO(COD_PROD),
COD_PROD_COMPOE INT NOT NULL REFERENCES PRODUTO(COD_PROD),
QUANT INT NOT NULL,
CONSTRAINT PRI_COMBO PRIMARY KEY(COD_PROD_COMBO,COD_PROD_COMPOE));

INSERT INTO COMBO VALUES
(3,1,2),
(3,2,1);

------------------TABELA FORNECEDOR-------------------
CREATE TABLE FORNECEDOR
(COD_FORN INT NOT NULL PRIMARY KEY,
NOME_FORN VARCHAR NOT NULL);

INSERT INTO FORNECEDOR VALUES
(1,'fornecedor 1'),
(2,'fornecedor 2'),
(3,'fornecedor 3');

--------------TABELA PEDIDO-----------------
CREATE TABLE PEDIDO
(COD_PEDIDO INT NOT NULL PRIMARY KEY,
COD_FORN INT NOT NULL REFERENCES FORNECEDOR(COD_FORN),
DT_PEDIDO DATE NOT NULL);

INSERT INTO PEDIDO VALUES
(1,1,'2024-08-11'),
(2,2,'2024-09-11');

-------------TABELA ITEM_PEDIDO---------------------
CREATE TABLE ITEM_PEDIDO
(COD_ITEM SERIAL NOT NULL PRIMARY KEY,
COD_PEDIDO INT NOT NULL REFERENCES PEDIDO(COD_PEDIDO),
COD_PROD INT NOT NULL REFERENCES PRODUTO(COD_PROD),
QUANTIDADE INT NOT NULL,
VALOR_TOTAL_ITEM FLOAT NOT NULL);

INSERT INTO ITEM_PEDIDO VALUES
(default,1,1,1,10),
(default,1,2,1,15),
(default,1,4,1,20),
(default,2,3,2,80);

-------------------TABELA TAB_PRECOS------------------
CREATE TABLE TAB_PRECOS
(COD_FORN INT NOT NULL REFERENCES FORNECEDOR(COD_FORN),
COD_PROD INT NOT NULL REFERENCES PRODUTO(COD_PROD),
VALOR_COMPRA FLOAT NOT NULL,
CONSTRAINT PRI_TAB_PRECOS PRIMARY KEY(COD_PROD,COD_FORN));

INSERT INTO TAB_PRECOS VALUES
(1,1,8),
(2,1,7.5),
(1,2,12.50),
(2,2,13),
(3,4,15);



-- QUESTÃO 1 - TRIGGER TABELA PRODUTO
CREATE OR REPLACE FUNCTION T_VALIDACAO_PRODUTO()
RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.E_COMBO = 's') THEN
		UPDATE PRODUTO SET VALOR_VENDA = 0 WHERE COD_PROD = NEW.COD_PROD;
	END IF;
RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE TRIGGER TRIGGER_VALIDACAO_PRODUTO AFTER INSERT ON PRODUTO
FOR EACH ROW EXECUTE FUNCTION T_VALIDACAO_PRODUTO();

-- QUESTÃO 1 - TRIGGER TABELA COMBO
CREATE OR REPLACE FUNCTION T_VALIDACAO_COMBO()
RETURNS TRIGGER AS $$
DECLARE VALOR_ITEM_COMBO FLOAT;
VALOR_ATUAL FLOAT;
BEGIN
	IF NOT EXISTS (SELECT 1 FROM PRODUTO WHERE COD_PROD = NEW.COD_PROD_COMBO AND E_COMBO = 's') THEN
		RAISE EXCEPTION 'COD_PROD_COMBO % NÃO É UM COMBO', NEW.COD_PROD_COMBO;
	END IF;

	VALOR_ITEM_COMBO := 0.80 * (NEW.QUANT * (SELECT VALOR_VENDA FROM PRODUTO WHERE COD_PROD = NEW.COD_PROD_COMPOE));

	SELECT COALESCE((VALOR_VENDA),0) INTO VALOR_ATUAL 
	FROM PRODUTO WHERE COD_PROD = NEW.COD_PROD_COMBO;

	UPDATE PRODUTO SET VALOR_VENDA = VALOR_ATUAL + VALOR_ITEM_COMBO WHERE COD_PROD = NEW.COD_PROD_COMBO;

	RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE TRIGGER TRIGGER_VALIDACAO_COMBO AFTER INSERT ON COMBO 
FOR EACH ROW EXECUTE FUNCTION T_VALIDACAO_COMBO();

-- QUESTAO 2 - FUNÇÃO REALIZAR PEDIDO
CREATE OR REPLACE FUNCTION REALIZAR_PEDIDO(COD INT, NOME_PRODUTO VARCHAR, QTD INT, NOME_FORNECEDOR VARCHAR)
RETURNS VOID AS $$
DECLARE MENOR_VALOR FLOAT;
VALOR_DESEJADO FLOAT;
COD_FORNECEDOR INT;
COD_PRODUTO_ITEM INT;
VALOR_TOTAL FLOAT;
BEGIN
	SELECT MIN(VALOR_COMPRA) INTO MENOR_VALOR
	FROM TAB_PRECOS WHERE COD_PROD = (SELECT COD_PROD 
	FROM PRODUTO P WHERE P.NOME_PROD ILIKE NOME_PRODUTO);

	SELECT VALOR_COMPRA INTO VALOR_DESEJADO
	FROM TAB_PRECOS WHERE COD_FORN = (SELECT COD_FORN FROM FORNECEDOR WHERE NOME_FORN ILIKE NOME_FORNECEDOR);

	SELECT COD_FORN INTO COD_FORNECEDOR FROM FORNECEDOR WHERE NOME_FORN ILIKE NOME_FORNECEDOR;

	SELECT COD_PROD INTO COD_PRODUTO_ITEM FROM PRODUTO WHERE NOME_PROD ILIKE NOME_PRODUTO;

	IF VALOR_DESEJADO > MENOR_VALOR THEN
	RAISE EXCEPTION 'EXISTE UM FORNECEDOR QUE OFERECE ESTE PRODUTO POR UM VALOR MENOR';
	END IF;

	VALOR_TOTAL := QTD * (SELECT VALOR_VENDA FROM PRODUTO WHERE COD_PROD = COD_PRODUTO_ITEM);

	IF EXISTS (SELECT 1 FROM PEDIDO WHERE COD_PEDIDO = COD) THEN
		INSERT INTO ITEM_PEDIDO VALUES(DEFAULT, COD, COD_PRODUTO_ITEM, QTD, VALOR_TOTAL);
	END IF;

	IF NOT EXISTS (SELECT 1 FROM PEDIDO WHERE COD_PEDIDO = COD) THEN
		INSERT INTO PEDIDO VALUES(COD, COD_FORNECEDOR, CURRENT_DATE);
		INSERT INTO ITEM_PEDIDO VALUES(DEFAULT, COD, COD_PRODUTO_ITEM, QTD, VALOR_TOTAL);
	END IF;
END;
$$ LANGUAGE PLPGSQL;


