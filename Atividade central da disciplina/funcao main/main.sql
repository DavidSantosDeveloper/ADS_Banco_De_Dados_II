














select CADASTRAR_LOJA(
   'Meracearia Bom dia', '12345678901', '64290000', 'brasil', 'piaui', 
    'altos', 'centro', 'rua vicente pestanna', 264)
	

select CADASTRAR_FORNECEDOR('supermecado do joao', '86999882554')
select CADASTRAR_FORNECEDOR('supermecado da maria', '86999882554')
select CADASTRAR_FORNECEDOR('hortalicas H', '86999882554')
select * from fornecedor


select CADASTRAR_PRODUTO('limao', 5, 'frutas'
)


select CADASTRAR_CLIENTE('Antonia', '86999882554'
)

select CADASTRAR_CARGO(
    'atendente', 'atendimento publico'
)

select CADASTRAR_FUNCIONARIO(
    'maria', '86999882554',1400.0, '2001-10-23', '07234901345', 
    '64290000', 'brasil', 'piaui', 'altos', 'centro', 
    'rua vicente pestana', '264', NULL
)

select CADASTRAR_PEDIDO(NULL, NULL)


select CADASTRAR_ESTOQUE(15, NULL, NULL)


select CADASTRAR_ITEM_PEDIDO(
	15,5.2,1,1
)

select CADASTRAR_VENDA(
    '2024-09-21', 0, 4,1
)


  ccc
select * from item_venda




select EDITAR_FORNECEDOR(
    'hortalicas H',
    'nome',
    'novo nome da tabela apos edicao'
)



-- Chamada das funções para editar as tabelas
SELECT EDITAR_LOJA('Nome da Loja', 'telefone', '12345678901');
SELECT EDITAR_FORNECEDOR('Nome do Fornecedor', 'telefone', '98765432101');
SELECT EDITAR_PRODUTO('Nome do Produto', 'valor', '19.99');
SELECT EDITAR_CLIENTE('Nome do Cliente', 'telefone', '111222333');
SELECT EDITAR_CARGO('Nome do Cargo', 'descricao', 'Nova descrição do cargo');
SELECT EDITAR_FUNCIONARIO('Nome do Funcionário', 'salario', '3000');
SELECT EDITAR_PEDIDO_COD(1, 'cod_fornecedor', '2');
SELECT EDITAR_ESTOQUE_COD(1, 'quantidade', '50');
SELECT EDITAR_ITEM_PEDIDO_COD(1, 'valor_unitario', '9.99');
SELECT EDITAR_VENDA_COD(1, 'valor_total', '150.00');
SELECT EDITAR_ITEM_VENDA_COD(1, 'quantidade', '3');





-- Chamada da função DELETAR para diferentes tabelas
SELECT DELETAR('LOJA', 'Nome da Loja');
SELECT DELETAR('FORNECEDOR', 'Nome do Fornecedor');
SELECT DELETAR('PRODUTO', 'Nome do Produto');
SELECT DELETAR('CLIENTE', 'Nome do Cliente');
SELECT DELETAR('CARGO', 'Nome do Cargo');
SELECT DELETAR('FUNCIONARIO', 'Nome do Funcionário');
SELECT DELETAR('PEDIDO', NULL, 1);  -- Deletar pelo código do pedido
SELECT DELETAR('ESTOQUE', NULL, 1); -- Deletar pelo código do estoque
SELECT DELETAR('ITEM_PEDIDO', NULL, 1); -- Deletar pelo código do item do pedido
SELECT DELETAR('VENDA', NULL, 1); -- Deletar pelo código da venda
SELECT DELETAR('ITEM_VENDA', NULL, 1); -- Deletar pelo código do item da venda


