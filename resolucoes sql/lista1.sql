-- Exercício
-- Crie os scripts SQL de criação e inserção de dados nas tabelas do banco de dados HOTEL. Em seguida, escreva consultas SQL para os itens abaixo.

-- 1. Categorias que possuam preços entre R$ 100,00 e R$ 200,00.
SELECT NOME FROM CATEGORIA WHERE valor_dia between 100.00 and 200.00;
-- 2. Categorias cujos nomes possuam a palavra ‘Luxo’.
select nome from categoria where nome ilike '%luxo%';
-- 3. Nomes \de categorias de apartamentos que foram ocupados há mais de 5 anos.
SELECT NOME FROM CATEGORIA C 
JOIN APARTAMENTO A ON C.COD_CAT = A.COD_CAT 
JOIN HOSPEDAGEM H ON A.NUM = H.NUM
  WHERE DT_ENT <= NOW() - INTERVAL '5 YEARS';
-- 4. Apartamentos que estão ocupados, ou seja, a data de saída está vazia.
select num from hospedagem where dt_sai is NULL;
-- 5. Apartamentos cuja categoria tenha código 1, 2, 3, 11, 34, 54, 24, 12.
select num from categoria where cod_cat in(1,2,3,11,34,54,24,12);
-- 6. Apartamentos cujas categorias iniciam com a palavra ‘Luxo’.
select num from apartamento as a,categoria as c where a.num=c.num and nome ilike 'luxo%';
-- 7. Quantidade de apartamentos cadastrados no sistema.
select count(num) from apartamento ;
-- 8. Somatório dos preços das categorias.
select sum(valor_dia) from categoria ;
-- 9. Média de preços das categorias.
select avg(valor_dia) from categoria ;
-- 10. Maior preço de categoria.
select max(valor_dia) from categoria ;
-- 11. Menor preço de categoria.
select min(valor_dia) from categoria ;
-- 12. O preço média das diárias dos apartamentos ocupados por cada hóspede.
select  h.cod_hosp,avg(c.valor_dia)  from  hospedagem h,apartamento a,categoria c where h.num=a.num and a.cod_cat=c.cod_cat group by h.cod_hosp 
-- 13. Quantidade de apartamentos para cada categoria.
  select c.cod_cat,nome,count(num) from apartamento as a full join categoria as c  on a.cod_cat=c.cod_cat  group by c.cod_cat
-- 14. Categorias que possuem pelo menos 2 apartamentos.
select c.cod_cat,nome,count(num) from apartamento as a full join categoria as c  on a.cod_cat=c.cod_cat  group by c.cod_cat having count(num)>=2
-- 15. Nome dos hóspedes que nasceram após 1° de janeiro de 1970.
select nome from hospede where dt_nasc> '1970-01-01'
-- 16. Quantidade de hóspedes.
select count(cod_hosp) from hospede;
-- 17. Apartamentos que foram ocupados pelo menos 2 vezes.
  select num,count(num) from hospedagem    group by num having count(num)>=2
-- 18. Altere a tabela Hóspede, acrescentando o campo "Nacionalidade".
Alter table hospede Add nascionalidade varchar(50) not null default 'brasil'.
-- 19.Quantidade de hóspedes para cada nacionalidade.
select nascionalidade,count(nascionalidade) from hospede group by nascionalidade;
-- 20. A data de nascimento do hóspede mais velho.
select dt_nasc from hospede where dt_nasc in(
    select min(dt_nasc) from hospede
)
-- 21. A data de nascimento do hóspede mais novo.
select dt_nasc from hospede where dt_nasc in(
    select max(dt_nasc) from hospede
)
-- 22. Reajuste em 10% o valor das diárias das categorias.
UPDATE hospede SET nascionalidade = nascionalidade*1.1;
-- 23. O nome das categorias que não possuem apartamentos.
select nome from apartamento as a full join categoria as c on a.cod_cat=c.cod_cat where a.num is null
-- 24. O número dos apartamentos que nunca foram ocupados.
select a.num from hospedagem h full join apartamento a on h.num=a.num where h.num is null group by a.num;
-- 25. O número do apartamento mais caro ocupado pelo João.
select a.num from hospede h,hospedagem hpd,apartamento a ,categoria c 
where h.cod_hosp=hpd.cod_hosp and hpd.num=a.num and a.cod_cat=c.cod_cat and h.nome ilike '%joão%' 
and c.valor_dia in(
    select max(c.valor_dia) from hospede h,hospedagem hpd,apartamento a ,categoria c 
		where h.cod_hosp=hpd.cod_hosp and hpd.num=a.num and a.cod_cat=c.cod_cat and h.nome ilike '%joão%'
)
-- 26. O nome dos hóspedes que nunca se hospedaram no apartamento 201.
select * from hospede h full join hospedagem hp on h.cod_hosp=hp.cod_hosp where hp.num!=201 or h.cod_hosp is null
-- 27. O nome dos hóspedes que nunca se hospedaram em apartamentos da categoria LUXO.
select * from 
    hospede h full join hospedagem hp on h.cod_hosp=hp.cod_hosp 
    full join apartamento a on hp.num=a.num 
    full join categoria c on a.cod_cat=c.cod_cat where c.nome not ilike '%luxo%' or h.cod_hosp is null
-- 28. O nome dos hóspedes que se hospedaram ou reservaram apartamento do tipo LUXO.
select * from 
    hospede h full join hospedagem hp on h.cod_hosp=hp.cod_hosp 
    full join apartamento a on hp.num=a.num 
    full join categoria c on a.cod_cat=c.cod_cat where c.nome  ilike '%luxo%' or h.cod_hosp is null
-- 29. O nome dos hóspedes que se hospedaram mas nunca reservaram apartamentos do tipo  LUXO.

  select * from hospede h,hospedagem hp,apartamento a,categoria c 
  		where h.cod_hosp=hp.cod_hosp and hp.num=a.num and a.cod_cat=c.cod_cat
			  and c.nome ilike 'luxo'
        and h.cod_hosp not in(
            select h.cod_hosp from hospede h,reserva r,apartamento a,categoria c 
  		          where h.cod_hosp=r.cod_hosp and r.num=a.num and a.cod_cat=c.cod_cat
                      and c.nome ilike 'luxo' 
        )
-- 30. O nome dos hóspedes que se hospedaram e reservaram apartamento do tipo LUXO
 select * from hospede h,hospedagem hp,apartamento a,categoria c 
  		where h.cod_hosp=hp.cod_hosp and hp.num=a.num and a.cod_cat=c.cod_cat
			  and c.nome ilike 'luxo'
        and h.cod_hosp in(
            select h.cod_hosp from hospede h,reserva r,apartamento a,categoria c 
  		          where h.cod_hosp=r.cod_hosp and r.num=a.num and a.cod_cat=c.cod_cat
                      and c.nome ilike 'luxo' 
        )