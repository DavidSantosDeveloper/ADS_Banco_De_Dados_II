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