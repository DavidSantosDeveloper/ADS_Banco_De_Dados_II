-- 1) Implemente o banco de dados que controla as compras de livros de uma livraria em seus 
-- respectivos fornecedores, de acordo com o esquema abaixo. Os domínios dos atributos ficarão 
-- a seu critério. Não se esqueça de povoar as tabelas.
-- Obs: Durante a criação das tabelas, não implemente restrições de chaves primárias e 
-- estrangeiras e nem restrições de valores não nulos nas tabelas Pedido e Item_pedido.


-- >>>>>>>>tabelas
create table fornecedor (
    cod_fornecedor serial primary key, 
    nome_fornenecdor text, 
    endereco_fornecedor text)

create table titulo (
    cod_titulo serial primary key,
    descr_titulo text);

create table livro (
    cod_livro serial , 
    quant_estoque bigint, 
    valor_unitario numeric(10,2),
    cod_titulo bigint references titulo(cod_titulo)
    );

create  table pedido (
    cod_pedido int 
   ,data_pedido date,
   hora_pedido text, 
  valor_total_pedido numeric(10,2), 
  quant_itens_pedidos bigint
  ,cod_fornecedor bigint 
  );

create table item_pedido(
    cod_livro int,
    quantidade_item bigint, 
    valor_total_item numeric(10,2),
    cod_pedido bigint
    );


-- 3) Usando trigger, responda as questões a seguir.

-- a) Crie triggers que implementem todas essas restrições de chave primária, chave estrangeira 
-- e valores não nulos nas tabelas Pedido e Item_pedido.

create or replace function valida_pedido() returns trigger as $valida_pedido$
begin
   if NEW.cod_pedido is null then
     raise exception 'chave primaria invalida (cod_pedido)!';
    end if;

    if new.cod_fornecedor is null then 
         raise exception 'chave estrrangeira invalida (cod_fornrcedor)!';
    end if;

    if new.data_pedido is null or new.hora_pedido is null or new.valor_total_pedido is null then
        raise exception 'campo(s) invalido(s)!';
    end if;

    return new;
end;

$valida_pedido$ language plpgsql;


create or replace trigger  trigger_pedido after insert OR update OR delete 
on pedido  for each row execute procedure valida_pedido();



create or replace function valida_item_pedido() returns trigger as $valida_item_pedido$
begin
    if new.cod_livro is null then
        raise exception 'Chave primaria invalida! (cod_item_livro)';
    end if;

    if new.quantidade_item is null or new.valor_total_item is null then
        raise exception 'Campo(s) invalido(s),verifique novamente os valores inseridos!';
    end if;

    if new.cod_pedido is null then
        raise exception 'Chave estrangeira invalida!! (cod_pedido)';
    end if;

    return new;
end;
$valida_item_pedido$ language plpgsql;



 create or replace trigger trigger_item_pedido after insert OR update OR delete
 on item_pedido for each row execute procedure valida_item_pedido();
 
 
 
 insert into item_pedido values(1,25,15.78,5);
 insert into item_pedido values(NULL,25,15.78,5);
 insert into item_pedido values(1,25,15.78,NULL);
 insert into item_pedido values(1,NULL,15.78,5);



-- b) Crie um trigger na tabela Livro que não permita quantidade em estoque negativa e sempre 
-- que a quantidade em estoque atingir 10 ou menos unidades, um aviso de quantidade mínima 
-- deve ser emitido ao usuário (para emitir alertas sem interromper a execução da transação, 
-- você pode usar "raise notice" ou "raise info").


create or replace function verifica_estoque_livro(quant_estoque int) returns void as $verifica_estoque_livro$
begin
    if quant_estoque<10 then
        raise notice 'Atencao estoque baixo!';
    end if;
end;
$verifica_estoque_livro$ language plpgsql;


create or replace function CRUD_livro() returns trigger as $CRUD_livro$
begin 
    if TG_OP='INSERT' then
        if new.quant_estoque<0 then
            raise exception 'Quantidade de livros não pode ser negativa!!!';
        end if;
        
    end if;

    if TG_OP='UPDATE'  then
        if new.quant_estoque<old.quant_estoque then
           call  verifica_estoque_livro(new.quant_estoque);
        end if;
    end if;

    return new;
end;
$CRUD_livro$ language plpgsql;



create or replace trigger trigger_livro after insert OR update OR delete
on livro for each row execute procedure CRUD_livro();




-- c) Crie um trigger que sempre que houver inserções, remoções ou alterações na tabela 
-- "Item_pedido", haja a atualização da "quant_itens_pedidos" e do "valor_total_pedido" da 
-- tabela "pedido", bem como a atualização da quantidade em estoque da tabela Livro.


-- d) Crie uma tabela chamada "controla_alteracao". Nesta tabela, deverão ser armazenadas as 
-- alterações (update, delete) feitas na tabela "livro". Deverão ser registrados as seguintes 
-- informações: operação que foi realizada, a data e hora, além do usuário que realizou a 
-- modificação. No caso de acontecer uma atualização, deverão ser registrados os valores novos 
-- e os valores antigos da coluna "cod_titulo" do livro e quantidade em estoque. No caso de 
-- acontecer uma deleção, basta armazenar o "cod_titulo" do livro e a respectiva quantidade em 
-- estoque que foi deletada.