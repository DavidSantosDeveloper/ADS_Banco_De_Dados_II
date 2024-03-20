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
	
