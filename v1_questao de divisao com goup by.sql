select * from hospede natural join hospedagem 


select h.nome from hospede h 
	join hospedagem hpg on h.
	
	
	select h.nome,count(distinct hpg.num),count(a.num) from hospede h 
		join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
		join apartamento a on hpg.num=a.num
		group by h.nome having count(distinct hpg.num) = (select count(num) from apartamento)
		
		
		
-- 		1 forma
select h.cod_hosp,h.nome,h.dt_nasc,count(distinct hpg.num),count(a.num) from hospede h 
		join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
		join apartamento a on hpg.num=a.num
		group by h.cod_hosp,h.nome,h.dt_nasc having count(distinct hpg.num) = (select count(num) from apartamento)
-- 		2 forma
select * from hospede 
	where NOME in(
		select h.nome from hospede h 
			join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
			join apartamento a on hpg.num=a.num
			group by h.nome having count(distinct hpg.num) = (select count(num) from apartamento)
	)