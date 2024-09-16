CREATE TABLE loja(
    cod_loja serial not null,
    nome text not null,
    telefone varchar(255) not null,
    cep varchar(255) not null,
    pais varchar(255) not null,
    estado varchar(255) not null,
    cidade varchar(255) not null,
    bairro varchar(255) not null,
    logradouro varchar(255)not null,
    numero int not null,
    constraint pk_loja primary key (cod_loja)
);

CREATE TABLE fornecedor(
    cod_fornecedor serial not null,
    nome text not null,
    telefone varchar(255),
    constraint pk_fornecedor primary key(cod_fornecedor) 
);

CREATE TABLE produto(
    cod_produto serial not null,
    nome text not null,
    valor numeric(10,2) not null,
    categoria varchar(255) not null,
    constraint pk_produto primary key(cod_produto)
);

CREATE TABLE cliente(
    cod_cliente serial not null,
    nome text not null,
    telefone varchar(20),
    constraint pk_cliente primary key(cod_cliente)
);

CREATE TABLE cargo(
    cod_cargo serial  not null,
    nome varchar(255) not null,
    descricao text,
    constraint pk_cargo primary key(cod_cargo)
);

CREATE TABLE funcionario(
    cod_funcionario serial not null,
    nome text not null,
    telefone varchar(20) not null,
    salario decimal(30,2) not null,
    dt_nasc Date not null,
    cpf varchar(20) not null,
    cep varchar(40) not null,
    pais varchar(255) not null,
    estado varchar(255) not null,
    cidade varchar(255) not null,
    bairro varchar(255) not null,
    logradouro varchar(255) not null,
    numero varchar(255) not null,
    cod_cargo bigint not null ,
    constraint pk_funcionario primary key(cod_funcionario)
);


-- Tabelas dependentes



CREATE TABLE pedido(
    cod_pedido serial not null,
    cod_fornecedor bigint not null references fornecedor (cod_fornecedor),
    cod_funcionario bigint not null references funcionario (cod_funcionario),
    constraint pk_pedido primary key(cod_pedido)
);

CREATE TABLE estoque(
    cod_estoque serial not null,
    quantidade bigint not null,
    cod_loja bigint not null ,
    cod_produto bigint not null ,
    constraint pk_estoque primary key(cod_estoque)
);

CREATE TABLE item_pedido(
    cod_item_pedido serial not null,
    quantidade bigint not null,
    valor_unitario numeric(50,2) not null,
    valor_total numeric(50,2) not null,
    cod_estoque bigint not null ,
    cod_pedido bigint not null ,
    constraint pk_item_pedido primary key(cod_item_pedido)
);


CREATE TABLE venda(
    cod_venda serial not null,
    dt_venda date not null,
    valor_total numeric(50,2) not null,
    cod_cliente bigint not null ,
    cod_funcionario bigint not null ,
    constraint pk_venda primary key(cod_venda)
);

CREATE TABLE item_venda(
    cod_item_venda serial not null,
    quantidade bigint not null,
    valor_unitario numeric(50,2) not null,
    valor_total numeric(50,2) not null,
    cod_estoque bigint not null ,
    cod_venda bigint not null ,
    constraint pk_item_venda primary key(cod_item_venda)
);




