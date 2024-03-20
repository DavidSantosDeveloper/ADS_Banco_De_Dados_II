-- Exercício (continuação)

-- 1. Listagem dos hóspedes contendo nome e data de nascimento, ordenada em ordem
-- crescente por nome e decrescente por data de nascimento.
select nome,dt_nasc from hospede order by nome ASC,dt_nasc DESC
-- 2. Listagem contendo os nomes das categorias, ordenados alfabeticamente. A coluna de
-- nomes deve ter a palavra ‘Categoria’ como título.
select nome as Categoria from categoria order by nome ASC
-- 3. Listagem contendo os valores de diárias e os números dos apartamentos, ordenada em
-- ordem decrescente de valor.
select num,valor_dia from apartamento a join categoria c on a.cod_cat=c.cod_cat order by valor_dia DESC
-- 4. Categorias que possuem apenas um apartamento.
select c.cod_cat,count(num) as quantidade from apartamento a  full join categoria c on a.cod_cat=c.cod_cat group by c.cod_cat having count(num)=1
-- 5. Listagem dos nomes dos hóspedes brasileiros com mês e ano de nascimento, por ordem
-- decrescente de idade e por ordem crescente de nome do hóspede.
select nome,to_char( h.dt_nasc, 'MM/YYYY' ) from hospede where nascionalidade ilike 'brasil' order by dt_nasc DESC,nome ASC
-- 6. Listagem com 3 colunas, nome do hóspede, número do apartamento e quantidade (número
-- de vezes que aquele hóspede se hospedou naquele apartamento), em ordem decrescente de
-- quantidade.
select nome,num,count(num) as quantidade from 
    hospede h cross join hospedagem  hpg  where h.cod_hosp=hpg.cod_hosp or hpg.cod_hospeda is NULL
        group by nome,num order by quantidade DESC,nome ASC
-- 7. Categoria cujo nome tenha comprimento superior a 15 caracteres.
select nome from categoria where char_length(nome)>15;
-- 8. Número dos apartamentos ocupados no ano de 2017 com o respectivo nome da sua
-- categoria.ss
select * from 
    hospedagem h join apartamento a on h.num=a.num
    join categoria c on a.cod_cat=c.cod_cat
        where dt_ent between '2017-01-01' and '2017-12-31'
-- 9. Título do livro, nome da editora que o publicou e a descrição do assunto  [ANULADA]
-- 10. Crie a tabela funcionário com as atributos: cod_func, nome, dt_nascimento e salário.
-- Depois disso, acrescente o cod_func como chave estrangeira nas tabelas hospedagem e
-- reserva.
	CREATE TABLE FUNCIONARIO (
		COD_FUNC INT NOT NULL,
		NOME VARCHAR(50) NOT NULL,
		SALARIO float null,
		DT_NASC DATE NOT NULL,	
		CONSTRAINT PRI_FUNC PRIMARY KEY(COD_FUNC)
	);

-- 11. Mostre o nome e o salário de cada funcionário. Extraordinariamente, cada funcionário
-- receberá um acréscimo neste salário de 10 reais para cada hospedagem realizada.
 /*update funcionario  f1 
    set salario=salario+( 
            ( select count(*) from funcionario f
                    full join hospedagem hpg on f.cod_func=hpg.cod_func
                        where hpg.cod_func=f1.cod_func
            )*10
        )
  */  
select nome,salario,count(cod_hospeda) as qtde_hospedagens,salario+ count(cod_hospeda) * 10 from 
    funcionario f full join  hospedagem hpg
    on f.cod_func=hpg.cod_func 
        group by  nome,salario

-- 12. Listagem das categorias cadastradas e para aquelas que possuem apartamentos, relacionar
-- também o número do apartamento, ordenada pelo nome da categoria e pelo número do
-- apartamento.
select nome,count(num) from 
    categoria c full join apartamento a on c.cod_cat=a.cod_cat group by nome 
-- 13. Listagem das categorias cadastradas e para aquelas que possuem apartamentos, relacionar
-- também o número do apartamento, ordenada pelo nome da categoria e pelo número do
-- apartamento. Para aquelas que não possuem apartamentos associados, escrever "não possui
-- apartamento".
SELECT C.NOME,COALESCE(NUM::VARCHAR,'NÃO POSSUI APARTAMENTO') NUM_APTO FROM CATEGORIA C
LEFT JOIN APARTAMENTO A ON A.COD_CAT = C.COD_CAT
GROUP BY NOME, NUM
-- 14. O nome dos funcionário que atenderam o João (hospedando ou reservando) ou que
-- hospedaram ou reservaram apartamentos da categoria luxo.

(
        select f.nome from funcionario f,hospedagem hpg ,hospede h
            where f.cod_func=hpg.cod_func and hpg.cod_hosp=h.cod_hosp
                and h.nome ilike '%João%'
    UNION
        select f.nome from funcionario f,reserva r ,hospede h
            where f.cod_func=r.cod_func and r.cod_hosp=h.cod_hosp
                and h.nome ilike '%João%'
)
UNION
(
        select f.nome from funcionario f,hospedagem hpg,apartamento a,categoria c
            where f.cod_func=hpg.cod_func and hpg.num=a.num and a.cod_cat=c.cod_cat
                and c.nome ilike '%luxo%'
    UNION
    
        select f.nome from funcionario f,reserva r,apartamento a,categoria c
            where f.cod_func=r.cod_func and r.num=a.num and a.cod_cat=c.cod_cat
                and c.nome ilike '%luxo%' 
)


-- 15. O código das hospedagens realizadas pelo hóspede mais velho que se hospedou no 
-- apartamento mais caro.
IDEIA:
-- produto cartesiano:
-- -filtrar pelas hospedagens dos aptos da cat. mais cara
-- -filtrar pelo hospede mais velho dentre os que se hospedaram no apartamento mais caro
select * from 
	hospedagem hpg join hospede h on hpg.cod_hosp=h.cod_hosp 
	join apartamento a on hpg.num=a.num 
	join categoria c on a.cod_cat=c.cod_cat
		where c.nome in(
			select nome from categoria where valor_dia in(select max(valor_dia) from categoria)
		)
		and h.dt_nasc in(
			select min(h.dt_nasc) from 
			hospedagem hpg join hospede h on hpg.cod_hosp=h.cod_hosp 
			join apartamento a on hpg.num=a.num 
			join categoria c on a.cod_cat=c.cod_cat
				where c.nome in(
					select nome from categoria where valor_dia in(select max(valor_dia) from categoria)
				)
		)

-- 16. Sem usar subquery, o nome dos hóspedes que nasceram na mesma data do hóspede de
-- código 2.
-- select nome from hospede where dt_nasc in(select dt_nasc from hospede where cod_hosp=2) and cod_hosp!=2
SELECT H2.NOME
FROM HOSPEDE H 
JOIN HOSPEDE H2
ON (H.COD_HOSP = 2 
AND H2.COD_HOSP != 2 )
WHERE H.DT_NASC = H2.DT_NASC
-- 17. O nome do hóspede mais velho que se hospedou na categoria mais cara mo ano de 2017.
select * from 
	hospede h join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
    join apartamento a on hpg.num=a.num
    join categoria c on a.cod_cat=c.cod_cat
        where  c.nome in(
            select nome from categoria where valor_dia in(select max(valor_dia) from categoria)
        )
       and hpg.dt_ent between '2017-01-01' and '2017-12-31'
       and h.dt_nasc in(
            select min(h.dt_nasc) from 
                hospede h join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
                join apartamento a on hpg.num=a.num
                join categoria c on a.cod_cat=c.cod_cat
                    where  c.nome in(
                        select nome from categoria where valor_dia in(select max(valor_dia) from categoria)
                    )
                    and hpg.dt_ent between '2017-01-01' and '2017-12-31'
       ) 




        -- and hpg.dt_ent in(
            -- select extract(year from dt_ent) from hospedagem where extract(year from dt_ent)=2017
        -- )

-- 18. O nome das categorias que foram reservadas pela Maria ou que foram ocupadas pelo João
-- quando ele foi atendido pelo Joaquim.

   select c.nome from 
        categoria c join apartamento a on c.cod_cat=a.cod_cat
        join reserva r on a.num=r.num
        join hospede h on r.cod_hosp=h.cod_hosp
        join funcionario f on r.cod_func=f.cod_func 
            where h.nome ilike '%maria%' 
 UNION
    select c.nome from 
        categoria c join apartamento a on c.cod_cat=a.cod_cat
        join hospedagem hpg on a.num=hpg.num
        join hospede h on hpg.cod_hosp=h.cod_hosp
        join funcionario f on hpg.cod_func=f.cod_func 
            where h.nome ilike '%joão%' and f.nome ilike '%joaquim%'
-- 19. O nome e a data de nascimento dos funcionários, além do valor de diária mais cara
-- reservado por cada um deles.
select  f.nome,f.dt_nasc,max(c.valor_dia)  from 
    funcionario f join reserva r on f.cod_func=r.cod_func
    join apartamento a on r.num=a.num 
    join categoria c on a.cod_cat=c.cod_cat 
        group by f.nome,f.dt_nasc
-- 20. A quantidade de apartamentos ocupados por cada um dos hóspedes (mostrar o nome).
select h.nome,count(num) as quantidade_de_aptos from 
    hospede h full join hospedagem hpg on h.cod_hosp=hpg.cod_hosp group by h.nome
-- 21. A relação com o nome dos hóspedes, a data de entrada, a data de saída e o valor total
-- pago em diárias (não é necessário considerar a hora de entrada e saída, apenas as datas).
SELECT H.NOME AS Nome_Hospede,
       HOS.DT_ENT AS Data_Entrada,
       HOS.DT_SAI AS Data_Saida,
       CAST(HOS.DT_SAI AS DATE) - CAST(HOS.DT_ENT AS DATE) AS Duracao_Dias,
       C.VALOR_DIA * (CAST(HOS.DT_SAI AS DATE) - CAST(HOS.DT_ENT AS DATE)) AS Valor_Total
FROM HOSPEDE H
INNER JOIN HOSPEDAGEM HOS ON H.COD_HOSP = HOS.COD_HOSP
INNER JOIN APARTAMENTO A ON HOS.NUM = A.NUM
INNER JOIN CATEGORIA C ON A.COD_CAT = C.COD_CAT;
-- 22. O nome dos hóspedes que já se hospedaram em todos os apartamentos do hotel.

SELECT H.NOME
FROM HOSPEDE H
WHERE NOT EXISTS (
    SELECT A.NUM
    FROM APARTAMENTO A
    WHERE NOT EXISTS (
        SELECT *
        FROM HOSPEDAGEM HS
        WHERE HS.COD_HOSP = H.COD_HOSP AND HS.NUM = A.NUM
    )
);
-- SOLUCAO 2
SELECT H.NOME FROM HOSPEDE H 
NATURAL JOIN HOSPEDAGEM HO NATURAL JOIN APARTAMENTO GROUP BY H.NOME 
HAVING COUNT(DISTINCT HO.NUM) = (SELECT COUNT(NUM) FROM APARTAMENTO)
	  