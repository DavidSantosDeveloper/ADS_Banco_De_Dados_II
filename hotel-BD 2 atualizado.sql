-- Criando Tabelas:

	CREATE TABLE CATEGORIA (
		COD_CAT INT NOT NULL,
		NOME VARCHAR(50) NOT NULL,
		VALOR_DIA FLOAT NOT NULL,
		CONSTRAINT PRI_CAT PRIMARY KEY(COD_CAT)
	);

	CREATE TABLE APARTAMENTO (
		NUM INT NOT NULL PRIMARY KEY,
		STATUS CHAR(1) NOT NULL,
		COD_CAT INT NOT NULL,
		CONSTRAINT EST_APTO FOREIGN KEY(COD_CAT) REFERENCES CATEGORIA(COD_CAT)
	);
	
	CREATE TABLE HOSPEDE (
		COD_HOSP INT NOT NULL,
		NOME VARCHAR(50) NOT NULL,
		DT_NASC DATE NOT NULL,
		CONSTRAINT PRI_HOSP PRIMARY KEY(COD_HOSP)
	);
	
	CREATE TABLE HOSPEDAGEM (
		COD_HOSPEDA INT NOT NULL,
		COD_HOSP INT NOT NULL,
		NUM INT NOT NULL,
		DT_ENT DATE NOT NULL,
		DT_SAI DATE,
		CONSTRAINT PRI_HOSPEDA PRIMARY KEY(COD_HOSPEDA),
		CONSTRAINT EST_HOSP FOREIGN KEY(COD_HOSP) REFERENCES HOSPEDE(COD_HOSP),
		CONSTRAINT EST_APTO FOREIGN KEY(NUM) REFERENCES APARTAMENTO(NUM)
	);

	/*
	CREATE TABLE SERVICO (
		COD_SERV INT NOT NULL,
		NOME VARCHAR(50) NOT NULL,
		VALOR FLOAT NOT NULL,
		CONSTRAINT PRI_SERV PRIMARY KEY(COD_SERV)
	);
	
	CREATE TABLE SOLICITACAO (
		COD_SOL INT NOT NULL,
		COD_HOSPEDA INT NOT NULL,
		COD_SERV INT NOT NULL,
		DT_SOL DATE NOT NULL,
		QUANT INT NOT NULL,
		CONSTRAINT PRI_SOLIC PRIMARY KEY(COD_SOL),
		CONSTRAINT EST_HOSPEDA FOREIGN KEY(COD_HOSPEDA) REFERENCES HOSPEDAGEM(COD_HOSPEDA),
		CONSTRAINT EST_SERV FOREIGN KEY(COD_SERV) REFERENCES SERVICO(COD_SERV)
	);
	*/

	CREATE TABLE RESERVA{
		COD_RES INT NOT NULL PRIMARY KEY,
		COD_HOSP INT NOT NULL REFERENCES HOSPEDE(COD_HOSP),
		NUM INT NOT NULL REFERENCES APARTAMENTO(NUM),
		DT_RES DATE NOT NULL,
		DT_PREV_ENT DATE NOT NULL,
		DT_PREV_SAI DATE NOT NULL
	}

	CREATE TABLE ATENDENTE (
		COD_ATEND INT NOT NULL,
		NOME VARCHAR(50) NOT NULL,
		DT_NASC DATE NOT NULL,
		CONSTRAINT PRI_ATEND PRIMARY KEY(COD_ATEND)
	);

	-- ALTER TABLE table_name ADD COLUMN column_definition;

	ALTER TABLE hospedagem ADD COLUMN cod_atend int not null REFERENCES ATENDENTE(cod_atend);

	ALTER TABLE reserva ADD COLUMN cod_atend int not null REFERENCES ATENDENTE(cod_atend);

-- Inserindo dados:
 
	INSERT INTO CATEGORIA (COD_CAT, NOME, VALOR_DIA) 
	VALUES 
		(1, 'Econômica', 100.00), 
		(2, 'Luxo', 300.00), 
		(3, 'Premium', 500.00);
		
	INSERT INTO APARTAMENTO (NUM, STATUS, COD_CAT) 
	VALUES 
		(101, 'L', 1), 
		(102, 'L', 1), 
		(103, 'O', 2);
		
	INSERT INTO HOSPEDE (COD_HOSP, NOME, DT_NASC) 
	VALUES 
		(1, 'João Silva', '1985-05-01'), 
		(2, 'Maria Santos', '1990-09-15'), 
		(3, 'Pedro Souza', '1978-02-22');
		
	INSERT INTO HOSPEDAGEM (COD_HOSPEDA, COD_HOSP, NUM, DT_ENT, DT_SAI) 
	VALUES 
		(1, 1, 101, '2022-02-28', '2022-03-03'), 
		(2, 2, 103, '2022-03-10', NULL), 
		(3, 3, 102, '2022-03-15', '2022-03-20');
		
	/*	
	INSERT INTO SERVICO (COD_SERV, NOME, VALOR) 
	VALUES 
		(1, 'Café da manhã', 15.00), 
		(2, 'Lavanderia', 50.00), 
		(3, 'Internet sem fio', 20.00);
		
	INSERT INTO SOLICITACAO (COD_SOL, COD_HOSPEDA, COD_SERV, DT_SOL, QUANT) 
	VALUES 
		(1, 1, 1, '2022-03-01', 2), 
		(2, 2, 3, '2022-03-11', 1), 
		(3, 3, 2, '2022-03-17', 3);
	*/

	
-- Operadores importantes:
	-- O operador "ilike" é utilizado para fazer a comparação de forma "case-insensitive"; 
	-- O caractere "_" (underline) representa uma posição para qualquer caractere na sequência de caracteres;
	-- O símbolo "%" é um caractere curinga na linguagem SQL que representa uma sequência de zero ou mais caracteres de qualquer tipo.
	
-- Operações básicas:
	-- 1. Selecionar o nome dos hóspedes com código maior do que 2:
		SELECT NOME 
		FROM HOSPEDE 
		WHERE COD_HOSP > 2;

	-- 2. Selecionar o nome dos hóspedes que nasceram em 2000:
		SELECT NOME 
		FROM HOSPEDE 
		WHERE DT_NASC >= '2000-01-01' AND DT_NASC <= '2000-12-31';

		-- Usando "between":
			SELECT NOME 
			FROM HOSPEDE 
			WHERE DT_NASC BETWEEN '2000-01-01' AND '2000-12-31';

	-- 3. Selecionar o nome dos hóspedes que começam com a letra "M":
		SELECT NOME 
		FROM HOSPEDE 
		WHERE NOME LIKE 'M%';

		-- Usando "ilike":
			SELECT NOME 
			FROM HOSPEDE 
			WHERE NOME ILIKE 'M%';
	
	-- 4. Selecionar o nome dos hóspedes cujos nomes contêm a letra "a":
		SELECT NOME 
		FROM HOSPEDE 
		WHERE NOME ILIKE '%A%';

	-- 5. Selecionar o nome dos hóspedes cujos nomes não contêm a letra "a":
		SELECT NOME 
		FROM HOSPEDE 
		WHERE NOME NOT ILIKE '%A%';

	-- 6. Selecionar o nome dos hóspedes cujo o nome começa com uma letra qualquer, seguida de "h"
		SELECT NOME 
		FROM HOSPEDE 
		WHERE NOME ILIKE '_H%';

	-- 7. Selecionar o código e o nome dos hóspedes que se hospedaram em um apartamento da categoria "2":
		SELECT COD_HOSP, NOME 
		FROM HOSPEDE 
		WHERE COD_HOSP IN 
		(SELECT COD_HOSP FROM HOSPEDAGEM WHERE NUM IN 
		(SELECT NUM FROM APARTAMENTO WHERE COD_CAT = 2));

	-- 8. Selecionar o nome dos hóspedes que se hospedaram na data "2022-03-15":
		SELECT NOME 
		FROM HOSPEDE 
		WHERE COD_HOSP IN 
		(SELECT COD_HOSP FROM HOSPEDAGEM WHERE DT_ENT = '2022-03-15');

	-- 9. Selecionar o código e o nome dos hóspedes que se hospedaram em um apartamento da categoria "Luxo":
		SELECT COD_HOSP, NOME 
		FROM HOSPEDE 
		WHERE COD_HOSP IN 
		(SELECT COD_HOSP FROM HOSPEDAGEM WHERE NUM IN 
		(SELECT NUM FROM APARTAMENTO WHERE COD_CAT IN 
		(SELECT COD_CAT FROM CATEGORIA WHERE NOME = 'Luxo')));

	-- 10. Selecionar o código e o nome dos hóspedes que se hospedaram em um apartamento da categoria "Luxo" ou que fizeram solicitação do serviço "3":
		SELECT COD_HOSP, NOME 
		FROM HOSPEDE 
		WHERE COD_HOSP IN 
		(SELECT COD_HOSP FROM HOSPEDAGEM WHERE NUM IN 
		(SELECT NUM FROM APARTAMENTO WHERE COD_CAT IN 
		(SELECT COD_CAT FROM CATEGORIA WHERE NOME = 'Luxo')) OR COD_HOSPEDA IN 
		(SELECT COD_HOSPEDA FROM SOLICITACAO WHERE COD_SERV = 3));

	-- 11. Selecionar o nome do hóspede com a data mais antiga de entrada:
		SELECT NOME 
		FROM HOSPEDE 
		WHERE COD_HOSP IN 
		(SELECT COD_HOSP FROM HOSPEDAGEM WHERE DT_ENT = (SELECT MIN(DT_ENT) FROM HOSPEDAGEM));

	-- 12. Selecionar o nome do hóspede com a data mais antiga de entrada em 2022:
		SELECT NOME 
		FROM HOSPEDE 
		WHERE COD_HOSP IN 
		(SELECT COD_HOSP FROM HOSPEDAGEM WHERE DT_ENT = (SELECT MIN(DT_ENT) FROM HOSPEDAGEM WHERE DT_ENT BETWEEN '2022-01-01' AND '2022-12-31'));
