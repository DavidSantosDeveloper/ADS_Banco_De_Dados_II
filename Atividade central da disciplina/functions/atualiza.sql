create or replace function calcula_total() returns trigger as $valida_cargo$
declare
total decimal;
begin

    select valor_total from venda into total;
    update venda set valor_total=total+new.valor_total where cod_venda=new.cod_venda;
    return new;
end;
$valida_cargo$ language plpgsql;


 create or replace trigger trigger_calcula_total after insert OR update
 on item_venda for each row execute procedure calcula_total();

create or replace function calcula_total_pedido() returns trigger as $valida_cargo$
declare
total decimal;
begin

    select valor_total from pedido into total;
    update pedido set valor_total=total+new.valor_total where cod_pedido=new.cod_pedido;
    return new;
end;
$valida_cargo$ language plpgsql;


 create or replace trigger trigger_calcula_total after insert OR update
 on item_pedido for each row execute procedure calcula_total_pedido();
