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

-- 7. Categoria cujo nome tenha comprimento superior a 15 caracteres.
select nome from categoria where char_length(nome)>15;
-- 8. Número dos apartamentos ocupados no ano de 2017 com o respectivo nome da sua
-- categoria.ss
select * from 
    hospedagem h join apartamento a on h.num=a.num
    join categoria c on a.cod_cat=c.cod_cat
        where dt_ent between '2017-01-01' and '2017-12-31'
-- 9. Título do livro, nome da editora que o publicou e a descrição do assunto.
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
-- update funcionario set salario=salario+( ( )*10)

-- 12. Listagem das categorias cadastradas e para aquelas que possuem apartamentos, relacionar
-- também o número do apartamento, ordenada pelo nome da categoria e pelo número do
-- apartamento.
select nome,count(num) from 
    categoria c full join apartamento a on c.cod_cat=a.cod_cat group by nome 
-- 13. Listagem das categorias cadastradas e para aquelas que possuem apartamentos, relacionar
-- também o número do apartamento, ordenada pelo nome da categoria e pelo número do
-- apartamento. Para aquelas que não possuem apartamentos associados, escrever "não possui
-- apartamento".

-- 14. O nome dos funcionário que atenderam o João (hospedando ou reservando) ou que
-- hospedaram ou reservaram apartamentos da categoria luxo.

--********************>>>>>>>> EM ANDAMENTO ESSA RESPOSTA<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
select f.nome from funcionario f,hospedagem hpg ,hospede h
    where f.cod_func=hpg.cod_func and hpg.cod_hosp=h.cod_hosp
        and h.nome ilike 'João'
UNION
select f.nome from funcionario f,reserva r ,hospede h
    where f.cod_func=r.cod_func and r.cod_hosp=h.cod_hosp
        and h.nome ilike 'João'

-- apartamento mais caro.
-- 16. Sem usar subquery, o nome dos hóspedes que nasceram na mesma data do hóspede de
-- código 2.
-- 17. O nome do hóspede mais velho que se hospedou na categoria mais cara mo ano de 2017.
-- 18. O nome das categorias que foram reservadas pela Maria ou que foram ocupadas pelo João
-- quando ele foi atendido pelo Joaquim.
-- 19. O nome e a data de nascimento dos funcionários, além do valor de diária mais cara
-- reservado por cada um deles.
-- 20. A quantidade de apartamentos ocupados por cada um dos hóspedes (mostrar o nome).
select h.nome,count(num) as quantidade_de_aptos from 
    hospede h full join hospedagem hpg on h.cod_hosp=hpg.cod_hosp group by h.nome
-- 21. A relação com o nome dos hóspedes, a data de entrada, a data de saída e o valor total
-- pago em diárias (não é necessário considerar a hora de entrada e saída, apenas as datas).

-- 22. O nome dos hóspedes que já se hospedaram em todos os apartamentos do hotel.
select nome from hospede 
    where 