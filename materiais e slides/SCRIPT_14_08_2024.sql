CREATE TABLE LEITOR(
	COD_LEITOR INT NOT NULL PRIMARY KEY,
	NOME VARCHAR(50) NOT NULL,
	DT_NASC DATE NOT NULL
);

CREATE TABLE FUNCIONARIO(
	COD_FUNC INT NOT NULL PRIMARY KEY,
	NOME VARCHAR(20) NOT NULL
);

CREATE TABLE AUTOR(
	COD_AUTOR INT NOT NULL PRIMARY KEY,
	NOME VARCHAR(20) NOT NULL,
	DT_NASC DATE NOT NULL
);

CREATE TABLE TITULO(
	COD_TIT INT NOT NULL PRIMARY KEY,
	NOME VARCHAR(20) NOT NULL
);

CREATE TABLE EXEMPLAR(
	COD_EX INT NOT NULL PRIMARY KEY,
	COD_TIT INT REFERENCES TITULO(COD_TIT)
);

CREATE TABLE AUTORIA(
	COD_AUTORIA INT NOT NULL PRIMARY KEY,
	COD_TIT INT REFERENCES TITULO(COD_TIT),
	COD_AUTOR INT REFERENCES AUTOR(COD_AUTOR)
);


CREATE TABLE EMPRESTIMO(
	COD_EMP INT NOT NULL PRIMARY KEY,
	COD_LEITOR INT REFERENCES LEITOR(COD_LEITOR),
	COD_EX INT REFERENCES EXEMPLAR(COD_EX),
	COD_FUNC INT REFERENCES FUNCIONARIO(COD_FUNC),
	DT_EMP DATE NOT NULL,
	DT_DEV DATE);

----------FUNÇÕES NO POSTGRESQL------
select testa1(4)

CREATE or replace FUNCTION testa1(i int) 
RETURNS int
AS $$
BEGIN
return i*i;
END;
$$ 
LANGUAGE 'plpgsql'	

select testa2(2,4,4)

CREATE or replace FUNCTION testa2(int,int,int) 
RETURNS int 
AS $$
BEGIN
return $1*$2*$3;
END;
$$ LANGUAGE 'plpgsql';

select testa1(9,2);

-------------------------------------------------------------
Drop function testa3();

select * from leitor

select testa3(3,'José Maria')

select * from leitor

CREATE or replace FUNCTION testa3(cod int, novo_nome varchar(30)) 
RETURNS void 
AS $$
BEGIN
update leitor
set nome=novo_nome
where cod_leitor=cod;
END;
$$ LANGUAGE 'plpgsql';

select * from fornecedor;
select testa3(3,'FORNECEDOR3');

----------------------------------------------------------------
Drop function testa4();

select testa4('now()',1)
CREATE or replace FUNCTION testa4(dat date, dias int) 
RETURNS date 
AS $$
BEGIN
return dat+dias;
END;
$$ LANGUAGE 'plpgsql';

select testa4('2017-04-03',50);

-------------------------------------------------------------
drop function faz_insercao1(varchar(128),varchar(128));

CREATE FUNCTION faz_insercao1(varchar(128),varchar(128)) 
RETURNS void 
AS $$
BEGIN
	insert into fornecedor values (default,$1,$2);
	
END;
$$ LANGUAGE 'plpgsql'

SELECT faz_insercao1('fornedor444','nao sei');


select * from fornecedor;

select * from leitor

insert into leitor('joão','2000-09-09')

select * from leitor

-------------------------------------------------------------
drop function faz_insercao2();
select faz_insercao2('João','2000-05-05')
CREATE FUNCTION faz_insercao2(varchar(30),date) 
RETURNS void 
AS $$
DECLARE
	var1 int;

BEGIN
    Select cod_leitor into var1 from leitor where cod_leitor = (select max(cod_leitor) from leitor);
	insert into leitor values (var1+1,$1,$2);
	
END;
$$ LANGUAGE 'plpgsql'

SELECT faz_insercao2();
select * from fornecedor;

-------------------------------------------------------------
drop function get1();
select cod_leitor,nome from get1()
select get1()
CREATE or replace FUNCTION get1() 
RETURNS setof leitor
AS $$
BEGIN
return query select * FROM leitor;
END;
$$ LANGUAGE 'plpgsql'

select * from get1();
select cod_fornecedor from get1();
select cod_fornecedor,nome_fornecedor from get1();
select get1();

----------------------------------------------------------
drop function get2();
select * from get2('leitor') as (c int, n varchar,d date)
DROP FUNCTION get2(i varchar) 

CREATE or replace FUNCTION get2(i varchar) 
RETURNS setof record
AS $$
BEGIN
return query EXECUTE FORMAT('select * from %I',i);
END;
$$ LANGUAGE 'plpgsql'

select get2()
select * from get2('leitor') as (codigo int, nome varchar, nascimento date);

----------------------------------------------------------------------
drop function get3();

select * from get3()
select * from leitor
drop function get3()
CREATE or replace FUNCTION get3() 
RETURNS TABLE(cod_leitorr INT, nnome VARCHAR) 
AS $$
BEGIN
	RETURN query SELECT cod_leitor, nome FROM leitor;
END;
$$ LANGUAGE 'plpgsql'

SELECT * FROM get3();
SELECT cod_leitorr codigo FROM get3() where cod_leitorr>1;

-------------------------------------------------------------------------

-----------------ESTRUTURA DE REPETIÇÃO!!!!!!!!!-------------------------
select count(*) from leitor

DROP FUNCTION testa_loop1() 

SELECT testa_loop1() 
CREATE FUNCTION testa_loop1() 
RETURNS TEXT 
AS $$
DECLARE
	CONT INT:=0;
	REGISTRO RECORD;
	
BEGIN
	FOR REGISTRO IN SELECT * FROM leitor LOOP
		CONT := CONT + 1;
	END LOOP;
	RETURN 'EXISTEM ' || CAST(CONT AS TEXT) || ' LEITORES';
END;
$$ LANGUAGE 'plpgsql'

SELECT TESTA_LOOP1();
SELECT * FROM FORNECEDOR

------------------------------------------------------------------------------
DROP FUNCTION testa_loop2() 
SELECT * FROM LEITOR

SELECT * FROM testa_loop2() 
DROP FUNCTION TESTA_LOOP2()
CREATE FUNCTION testa_loop2() 
RETURNS setof LEITOR
AS $$
DECLARE
	REGISTRO RECORD;
	
BEGIN
	FOR REGISTRO IN SELECT * FROM LEITOR LOOP
		RETURN NEXT REGISTRO;
	END LOOP;
	RETURN;
END;
$$ LANGUAGE 'plpgsql'


SELECT * FROM TESTA_LOOP2();



------------EXERCÍCIO 1--------------
/*Crie uma função que realiza o pedido de um único livro que possui estoque suficiente. O ato de realizar
pedido consiste em inserir registros nas tabelas Pedido e Item_pedido, além de decrementar a quantidade 
em estoque. Essa funcão deve receber apenas os seguintes parâmetros: Código do pedido, código do livro,
nome do fornecedor (imagine que não existam dois fornecedores com o mesmo nome) e quantidade vendida.*/


--------------------------EXERCÍCIO 2-----------------------------------------
/*Crie uma função que realiza o pedido como deve ser. Inserções nas tabelas PEdido e Item_pedido, além
da atualização da quantidade em estoque. No primeiro produto, deve haver inserções nas duas tabelas.
A partir do segundo, apenas na tebela Item_pedido. Não esqueça de decrementar a quantidade em estoque, 
de atualizar o valor total do pedido e a quantidade de itens da tabela pedido.
Os parâmetros passados para a função são os mesmos da questão anterior.*/


CREATE TABLE CLIENTE (
    COD_CLI SERIAL PRIMARY KEY NOT NULL,
    NOME VARCHAR,
    ENDERECO VARCHAR
);


CREATE TABLE TITULO (
    COD_TITULO SERIAL PRIMARY KEY NOT NULL,
    DESCR_TITULO VARCHAR(128)
);

INSERT INTO TITULO VALUES(DEFAULT, 'A VOLTA DOS QUE NÃO FORAM');
INSERT INTO TITULO VALUES(DEFAULT, 'BRUXEIRO 3: A CAÇADA SELVAGEM');
INSERT INTO TITULO VALUES(DEFAULT, 'BRUXEIRO 2: MATADOR DE REIS');

CREATE TABLE LIVRO (
    COD_LIVRO SERIAL PRIMARY KEY NOT NULL,
    COD_TITULO INT NOT NULL REFERENCES TITULO(COD_TITULO),
    QUANT_ESTOQUE INT,
    VALOR_UNITARIO REAL
);

INSERT INTO LIVRO VALUES(DEFAULT, 1, 10, 80);
INSERT INTO LIVRO VALUES(DEFAULT, 2, 5, 50);
INSERT INTO LIVRO VALUES(DEFAULT, 3, 3, 30);

CREATE TABLE PEDIDO (
    COD_PEDIDO INT,
    COD_CLI INT,
    DATA_PEDIDO DATE,
    HORA_PEDIDO TIMESTAMP,
    VALOR_TOTAL_PEDIDO REAL,
    QUANT_ITENS_PEDIDOS INT
);

INSERT INTO PEDIDO VALUES(1, 1, CURRENT_DATE, 'now', 400, 5);
INSERT INTO PEDIDO VALUES(2, 2, CURRENT_DATE, 'now', 100, 2);
INSERT INTO PEDIDO VALUES(3, 3, CURRENT_DATE, 'now', 90, 3);

CREATE TABLE ITEM_PEDIDO (
    COD_LIVRO INT,
    COD_PEDIDO INT,
    QUANTIDADE_ITEM INT,
    VALOR_TOTAL_ITEM REAL
);

INSERT INTO ITEM_PEDIDO VALUES(1, 1, 5, 400);
INSERT INTO ITEM_PEDIDO VALUES(2, 2, 2, 100);
INSERT INTO ITEM_PEDIDO VALUES(3, 3, 3, 90);







