-- infomaçoes dos hospedes que se hospedaram em todos os aptos
select h.nome from  hospede h
	join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
	join apartamento a on hpg.num=a.num
	group by h.nome having count (distinct hpg.num) = (select count(num) from apartamento)
	



-- infomaçoes dos hospedes que foram atendidos por todos os funcionarios
select  h.nome from hospede h
	join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
	join funcionario f on hpg.cod_func=f.cod_func
	group by h.nome having count(distinct hpg.cod_func) =(select count(cod_func) from funcionario)
	
	
select *from hospede h
	join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
	join funcionario f on hpg.cod_func=f.cod_func where h.nome ilike '%silva%'
	select * from funcionario

insert into hospedagem values(12,4,105,'2024-03-18','2024-03-18',5)
insert into hospedagem values(14,1,105,'2024-03-18','2024-03-18',3)

-- >>>>>>>>>>informacoes dos hospedes que foram atendidos por todos os funcionarios com excecao do  funcionario de nome fulano


-- os que foram atendidos por todos incluindo pelo fulano e tambem os que foram atendidos por todos exceto pelo funcionario fulano
(
	select  h.nome from hospede h
	join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
	join funcionario f on hpg.cod_func=f.cod_func
	group by h.nome having count(distinct hpg.cod_func) =(select count(cod_func) from funcionario)
)
except
--todos os que foram atendidos pelo fulano
(
	select  h.nome from hospede h
	join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
	join funcionario f on hpg.cod_func=f.cod_func
		where f.nome!='fulano'
)
-- A DIFERENÇA ENTRE ESSES 2 VAI RESULTAR NOS QUE FORAM ATENDIDOS POR TODOS EXCETO PELO FULANO


-- 2 opcao

(
	select  h.nome from hospede h
	join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
	join funcionario f on hpg.cod_func=f.cod_func
	where f.nome!='fulano'
	group by h.nome having count(distinct hpg.cod_func) =(select count(cod_func) from funcionario where nome not ilike 'fulano')
)
except
(
	select  h.nome from hospede h
	join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
	join funcionario f on hpg.cod_func=f.cod_func
		where f.nome='fulano'
)

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
	
	
	
-- infomaçoes dos APTOS que se hospedaram em todos os HOSPEDES
select A.num from  hospede h
	join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
	join apartamento a on hpg.num=a.num
	group by a.num having count (distinct hpg.cod_hosp) = (select count(cod_hosp) from hospede)	 
	
	


--ORDENACAO 
	select  * from hospede h
	join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
	join funcionario f on hpg.cod_func=f.cod_func order by h.cod_hosp DESC,h.dt_nasc ASC
	
	
-- 3. Nomes \de categorias de apartamentos que foram ocupados há mais de 5 anos.
SELECT NOME FROM CATEGORIA C 
JOIN APARTAMENTO A ON C.COD_CAT = A.COD_CAT 
JOIN HOSPEDAGEM H ON A.NUM = H.NUM
  WHERE DT_ENT <= NOW() - INTERVAL '5 YEARS';
  
--   tempo
  select now(),now()-interval '5 seconds'
select now(),now()-interval '5 minutes'
select now(),now()-interval '5 hours'
select now(),now()-interval '5 days'
select now(),now()-interval '5 months'
select now(),now()-interval '5 years'


select nome,char_length(nome), to_char( h.dt_nasc, 'MM/YYYY' ) from hospede h
where nascionalidade ilike 'brasil' order by dt_nasc DESC,nome ASC



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
	
-- 13. Listagem das categorias cadastradas e para aquelas que possuem apartamentos, relacionar
-- também o número do apartamento, ordenada pelo nome da categoria e pelo número do
-- apartamento. Para aquelas que não possuem apartamentos associados, escrever "não possui
-- apartamento".
SELECT C.NOME,COALESCE( CAST(NUM as varchar) ,'NÃO POSSUI APARTAMENTO') NUM_APTO FROM CATEGORIA C
LEFT JOIN APARTAMENTO A ON A.COD_CAT = C.COD_CAT
GROUP BY NOME, NUM	


-- 16. Sem usar subquery, o nome dos hóspedes que nasceram na mesma data do hóspede de
-- código 2.
-- select nome from hospede where dt_nasc in(select dt_nasc from hospede where cod_hosp=2) and cod_hosp!=2

SELECT H2.NOME
FROM HOSPEDE H 
JOIN HOSPEDE H2
ON (H.COD_HOSP = 2 
AND H2.COD_HOSP != 2 )
WHERE H.DT_NASC = H2.DT_NASC




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