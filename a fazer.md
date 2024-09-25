### triggers
>> validacoes(Inserts, integridade referencial) OK
>> atualizacoes (updates ,integridade referencial) OK
>>ajustes quantidades de produtos apos compra/pedido ou desfazer compra /pedido
>> delecoes (delete,integridade referencial) OK

obs: nao usar delete cascade
ao excluir um registro referenciado em outra tabela: deixar essa referencia da outra tabela como NULL ou adicionar um campo 'visibilidade' em todas as tabelas onde ao ser deletado um registro as referencias a esse registro ficam desativadas/invisiveis ao banco de dados
### relatorios (views)
perguntas frequentes
#### functions
>>cadrastro
>>validacoes
>>controle de estoque(decremento de QUANTIDADE APOS INSERCAO)
>>controle venda pedido e item pedido item venda (Realizar vendas  e pedidos)

### controle de acesso
>>pelo menos uns 3
