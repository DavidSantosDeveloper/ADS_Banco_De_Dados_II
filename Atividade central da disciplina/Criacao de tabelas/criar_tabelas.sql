CREATE TABLE loja(
    cod_loja bigint not null,
    nome text not null,
    telefone varchar(255) not null,
    cep varchar(255),
    pais varchar(255),
    estado varchar(255),
    cidade varchar(255),
    bairro varchar(255),
    logradouro varchar(255),
    numero int,
    constraint pk_loja primary key (cod_loja)
);

CREATE TABLE fornecedor(
    cod_fornecedor bigint not null,
    nome text not null,
    telefone varchar(255),
    constraint pk_fornecedor primary key(cod_fornecedor) 
);

CREATE TABLE produto(
    cod_produto bigint not null,
    nome text not null,
    categoria varchar(255),
    constraint pk_produto primary key(cod_produto)
);

CREATE TABLE fornecedor(
    cod_fornecedor bigint not null,
    nome text not null,
    telefone varchar(20),
    constraint pk_fornecedor primary key(cod_fornecedor)
);
CREATE TABLE cliente(
    cod_cliente bigint not null,
    nome text not null,
    telefone varchar(20),
    constraint pk_cliente primary key(cod_cliente)
);

CREATE TABLE cargo(
    cod_cargo bigint not null,
    nome varchar(255) not null,
    descricao text,
    constraint pk_cargo primary key(cod_cargo)
);

CREATE TABLE funcionario(
    cod_funcionario bigint not null,
    nome text not null,
    telefone varchar(20),
    salario decimal(30,2),
    dt_nasc Date,
    cpf varchar(20),
    cep varchar(40),
    pais varchar(255),
    estado varchar(255),
    cidade varchar(255),
    bairro varchar(255),
    logradouro varchar(255),
    numero varchar(255),
    constraint pk_funcionario primary key(cod_funcionario)
);


-- Tabelas dependentes



CREATE TABLE pedido(
    cod_pedido serial not null,
    cod_fornecedor bigint not null references fornecedor (cod_fornecedor),
    cod_funcionario bigint not null references funcionario (cod_funcionario),
    constraint pk_pedido primary key(cod_pedido)
);
