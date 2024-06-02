#Usando a base de dados BDEX4_ESTOQUE, responda:
USE BDEX4_ESTOQUE;

#1. Exibir todas as informações da tabela `PRODUTOS`.
select * from produtos;
#2. Mostrar os nomes e preços dos produtos que custam mais de 50,00.
select nome_pro, preco
from produtos
where preco > 50;
#3. Listar os nomes e cidades dos fornecedores.
select nome_for, cidade 
from fornecedores;
#4. Exibir os detalhes dos pedidos de compra: ID do pedido, data, hora e nome do fornecedor.
select pc.id_pedido, concat_ws(' às ',pc.data_pedido,pc.hora_pedido) as datahora, f.nome_for
from pedidos_compra as pc
inner join fornecedores as f
on pc.fornecedor = f.id_fornecedor;
#5. Listar o nome dos produtos e a quantidade disponível em cada armazém.

select p.nome_pro, pa.quantidade
from produtos as p
left join produtos_armazens as pa
on pa.produto = p.id_produto;

#6. Mostrar os nomes dos fornecedores que têm produtos no armazém de "São Paulo".

select distinct f.nome_for
from fornecedores as f
inner join produtos_fornecedores as pf
on pf.fornecedor = f.id_fornecedor
inner join produtos as p
on p.id_produto = pf.produto
inner join produtos_armazens as pa
on pa.produto = p.id_produto
inner join armazens as a
on a.id_armazem = pa.armazem
where cidade like 'São Paulo';

#7. Listar todos os armazéns, ordenados pelo nome do armazém de A a Z.

select nome_armazem
from armazens
order by nome_armazem;

#8. Mostrar os nomes dos produtos que têm a palavra "Premium" na descrição.

select nome_pro
from produtos
where descricao like '%Premium%';

#9. Exibir os detalhes dos produtos: ID do produto, nome, descrição, preço e nome dos fornecedores.

select p.*, f.nome_for
from produtos as p
inner join produtos_fornecedores as pf
on p.id_produto = pf.produto
inner join fornecedores as f
on pf.fornecedor = f.id_fornecedor;

#10. Para cada pedido de compra, mostrar o ID do pedido e a quantidade total de produtos solicitados.

select id_pedido, sum(quantidade)
from pedidos_compra
group by id_pedido;

#11. Contar quantos produtos cada fornecedor oferece.

select f.nome_for as nome, count(p.id_produto) as produtos
from fornecedores as f
inner join produtos_fornecedores as pf
on pf.fornecedor = f.id_fornecedor
inner join produtos as p
on p.id_produto = pf.produto
group by f.nome_for;

#12. Listar os nomes dos produtos e a quantidade disponível no armazém "Rio de Janeiro".

select p.nome_pro, pa.quantidade
from produtos as p
left join produtos_armazens as pa
on pa.produto = p.id_produto
left join armazens as a
on pa.armazem = a.id_armazem
where cidade_armazem like 'Rio de Janeiro';

#13. Mostrar o nome dos fornecedores e a data e hora do último pedido de compra que eles receberam.

select f.nome_for, concat_ws(' às ',max(pc.data_pedido),max(pc.hora_pedido)) as datahora
from fornecedores as f
left join pedidos_compra as pc
on f.id_fornecedor = pc.fornecedor
group by f.nome_for;

#14. Contar quantos pedidos de compra cada fornecedor recebeu.

select f.nome_for as fornecedores, count(pc.id_pedido) as pedidos
from fornecedores as f
left join pedidos_compra as pc
on f.id_fornecedor = pc.fornecedor
group by f.nome_for;

#15. Para cada armazém, exibir o nome do armazém e a quantidade total de produtos armazenados nele.

select a.nome_armazem, sum(pa.quantidade)
from armazens as a
left join produtos_armazens as pa
on a.id_armazem = pa.armazem
group by a.nome_armazem;
