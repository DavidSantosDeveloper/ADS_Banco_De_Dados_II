-- 19. O nome e a data de nascimento dos funcionários, além do valor de diária mais cara
-- reservado por cada um deles.

select * from reserva natural join apartamento natural join categoria

insert into funcionario values (2,'Antonia santos',1412.00,'1998-05-13')
insert into funcionario values (3,'Joana machado',1412.00,'1995-05-13')

insert into reserva values(2,1,105,'2024-03-01','2024-03-09','2024-03-30',2)

insert into reserva values(3,1,105,'2024-03-01','2024-03-09','2024-03-30',2)


insert into reserva values(4,1,105,'2024-03-01','2024-03-09','2024-03-30',3)

insert into reserva values(5,1,101,'2024-03-01','2024-03-09','2024-03-30',3)
insert into reserva values(6,1,101,'2024-03-01','2024-03-09','2024-03-30',3)

delete from reserva where cod_res=101


-- todos que se hospedaram e reservaram hoje

(select * from hospede h,hospedagem hp
    WHERE h.cod_hosp=hp.cod_hosp
          and dt_ent='2024-03-18')
intersect
(select * from hospede h,reserva r
    WHERE h.cod_hosp=hp.cod_hosp
          and dt_res='2024-03-18')



select h.nome from hospede h 
	join hospedagem hpg on h.cod_hosp=hpg.cod_hosp
    join apartamento a on hpg.num=a.num
    group by h.nome having count(distinct hpg.num) = select count(num) from apartamento
