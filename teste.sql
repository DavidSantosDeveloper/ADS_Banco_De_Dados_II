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