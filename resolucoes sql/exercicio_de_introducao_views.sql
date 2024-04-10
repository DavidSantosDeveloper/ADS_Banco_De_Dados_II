
-- 1 questao
CREATE TABLE venda (
    Cod_venda SERIAL PRIMARY KEY,
    Nome_vendedor VARCHAR(100),
    data_venda DATE,
    Valor_vendido NUMERIC(10, 2)
);


-- 2 questao   Populando a tabela com 10 vendas
INSERT INTO venda (Nome_vendedor, data_venda, Valor_vendido) VALUES
('João Silva', '2024-03-05', 100),
('Maria Santos', '2024-03-10', 200),
('Pedro Oliveira', '2024-03-15', 150),
('Ana Pereira', '2024-03-20', 300),
('Carlos Silva', '2024-03-25', 250),
('Patrícia Costa', '2024-03-01', 180),
('Lucas Oliveira', '2024-03-08', 220),
('Fernanda Rodrigues', '2024-03-12', 280),
('Gabriel Almeida', '2024-03-18', 190),
('Juliana Santos', '2024-03-28', 350);

-- 3 questao
-- Encontrando os vendedores que venderam mais de X reais no mês de março de 2024
SELECT Nome_vendedor
FROM venda
WHERE EXTRACT(MONTH FROM data_venda) = 3 -- Filtrando pelo mês de março
AND EXTRACT(YEAR FROM data_venda) = 2024 -- Filtrando pelo ano de 2024
GROUP BY Nome_vendedor
HAVING SUM(Valor_vendido) > 200; -- Substitua 200 por X


-- 4 questao
-- Encontrando o nome de um dos vendedores que mais vendeu no mês de março de 2024
SELECT Nome_vendedor
FROM venda
WHERE EXTRACT(MONTH FROM data_venda) = 3 -- Filtrando pelo mês de março
AND EXTRACT(YEAR FROM data_venda) = 2024 -- Filtrando pelo ano de 2024
GROUP BY Nome_vendedor
ORDER BY SUM(Valor_vendido) DESC
LIMIT 1;

-- 5 questao
create or replace view melhor_vendedor_em_marco
as (
   -- Encontrando os nomes dos vendedores que mais venderam no mês de março de 2024
	SELECT Nome_vendedor
	FROM (
		SELECT Nome_vendedor, SUM(Valor_vendido) AS total_vendas
		FROM venda
		WHERE EXTRACT(MONTH FROM data_venda) = 3 -- Filtrando pelo mês de março
		AND EXTRACT(YEAR FROM data_venda) = 2024 -- Filtrando pelo ano de 2024
		GROUP BY Nome_vendedor
	) AS vendas_por_vendedor
	WHERE total_vendas = (
		SELECT MAX(total_vendas)
		FROM (
			SELECT SUM(Valor_vendido) AS total_vendas
			FROM venda
			WHERE EXTRACT(MONTH FROM data_venda) = 3
			AND EXTRACT(YEAR FROM data_venda) = 2024
			GROUP BY Nome_vendedor
		) AS max_vendas_por_vendedor
	)
	ORDER BY Nome_vendedor
)


SELECT * FROM melhor_vendedor_em_marco

