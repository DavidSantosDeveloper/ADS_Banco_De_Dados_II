-- 1 QUESTAO

create or replace FUNCTION valida_produto() returns trigger as $$
BEGIN
    if new.E_COMBO='s' THEN
        update produto set valor_total=0 where cod_prod=new.cod_prod;
    end if;
    return new;
end;
$$ language plpgsql;

create or replace trigger trigger_valida_produto after insert 
on produto for each row execute function valida_produto();


create or replace function valida_combo() returns trigger as $$
DECLARE
-- valor decimal;
valor_item_combo float;
valor_combo float;
BEGIN
    if not exists(select * from produto where cod_prod=new.cod_prod_combo and e_combo='s') THEN
        raise exception 'ATENCAO:nao existe um combo cadrastrado em produto com o valor de % ',new.cod_prod_combo;
    end if;

    valor_item_combo:=0.80*(select valor_venda from produto where cod_prod=new.COD_PROD_COMPOE)* new.QUANT;

    select coalesce((valor_venda),0) into valor_combo from produto where cod_prod=NEW.cod_prod_combo;

    update produto set valor_venda=valida_combo+valor_item_combo where cod_prod=new.cod_prod_combo;
    -- update produto set valor_venda 

    return new;
end;
$$ language plpgsql;

create or replace trigger trigger_valida_combo after insert 
on combo for each row execute function valida_combo();


-- ######  2 QUESTAO

create or replace function realiza_pedido(
    _cod_pedido int,
    _nome_produto varchar,
    _quant_produto int,
    _nome_fornecedor varchar

) returns void as $$
declare
menor_preco float;
valor_prod_no_fornecedor_escolhido float;
cod_forncecedor int;
cod_produto int;
valor_total_item int;
begin
     select min(valor_compra) into menor_preco from tab_precos where cod_prod in(select cod_prod from produto where NOME_PROD ILIKE _nome_produto);
     select valor_compra into valor_prod_no_fornecedor_escolhido from tab_precos where COD_FORN in(select COD_FORN from fornecedor where NOME_FORN ILIKE _nome_fornecedor) and cod_prod in(select cod_prod from produto where NOME_PROD ILIKE _nome_produto);

     select cod_forncecedor into cod_forncecedor from fornecedor where nome_forn ilike _nome_fornecedor;
     select cod_prod into cod_produto from produto where NOME_PROD ilike _nome_fornecedor;
     valor_total_item:=(select valor_venda from produto where cod_prod=cod_produto) * _quant_produto;

     if valor_prod_no_fornecedor_escolhido>menor_preco THEN
        raise exception 'O pedido não pode ser feito pois o produto nesse fornecedor não é o mais barato!';
     end if;

    if not exists( select 1 from pedido where cod_pedido=_cod_pedido) THEN    
        insert into pedido values (_cod_pedido,cod_forncecedor,CURRENT_DATE);
        insert into item_pedido values (DEFAULT,_cod_pedido,cod_produto,_quant_produto,valor_total_item);
    end if;

    if exists( select 1 from pedido where cod_pedido=_cod_pedido) THEN      
        insert into item_pedido(DEFAULT,_cod_pedido,cod_produto,_quant_produto,valor_total_item);
    end if;


     
end;
$$ language plpgsql;