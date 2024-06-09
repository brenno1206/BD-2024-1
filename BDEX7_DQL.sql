use BDEX7_TRANSACOESBANCARIAS;
#1. Criar uma consulta para exibir todas as informações da tabela USUARIOS.
select
	* 
from 
	usuarios;
#2. Escrever uma consulta para mostrar os nomes e CPFs dos usuários que possuem telefone cadastrado.
select 
	nome_user, cpf_user
from 
	usuarios
where 
	telefone is not null;
#3. Listar os nomes dos bancos e suas respectivas agências.
select 
	nome_bnc, agencia
from 
	contas;
#4. Exibir os detalhes das transações: ID da transação, valor, natureza (crédito ou débito), nome do usuário.
select 
	t.id_trans, t.valor, t.natureza, u.nome_user
from 
	transacoes as t
inner join 
	usuarios as u
on 
	t.usuario = u.id_user;
#5. Listar os nomes dos usuários e seus e-mails, ordenados pelo nome do usuário de forma alfabética.
select 
	nome_user, email
from 
	usuarios
order by 
	nome_user;
#6. Mostrar as informações das contas bancárias que possuem saldo superior a 1000 reais.
select 
	c.* 
from 
	contas as c
inner join 
	saldos as s
on 
	c.agencia = s.agencia and c.conta = s.conta and c.cod_banco = s.cod_banco
where 
	s.valor_saldo > 1000;
#7. Listar os nomes dos usuários que realizaram transações com valor superior a 500 reais.
select 
	distinct u.nome_user
from 
	usuarios as u
inner join 
	transacoes as t
on 
	u.id_user = t.usuario
where 
	valor > 500;
#8. Exibir os detalhes das transações que foram realizadas em contas do banco "Banco Central".
select 
	t.*
from 
	transacoes as t
inner join 
	contas as c
on 
	t.agencia = c.agencia and t.conta = c.conta and t.cod_banco = c.cod_banco
where 
	nome_bnc like 'Banco Central';
#9. Mostrar os nomes dos usuários e seus respectivos telefones cadastrados, ordenados pelo nome do usuário de forma decrescente.
select 
	nome_user, telefone
from 
	usuarios
order by 
	nome_user desc;
#10. Listar os nomes dos bancos e o total de contas cadastradas em cada um deles.
select 
	nome_bnc, count(conta)
from 
	contas
group by 
	nome_bnc;
#11. Para cada usuário, mostrar o nome do usuário e o saldo atual de sua conta bancária.
select 
	u.nome_user, s.valor_saldo
from 
	usuarios as u
left join 
	transacoes as t
on 
	u.id_user = t.usuario
left join 
	contas as c
on 
	t.agencia = c.agencia and t.conta = c.conta and t.cod_banco = c.cod_banco
left join 
	saldos as s
on 
	c.agencia = s.agencia and c.conta = s.conta and c.cod_banco = s.cod_banco
group by 
	u.nome_user, s.valor_saldo
having 
	max(s.data_saldo) and max(s.hora_saldo);

#12. Contar quantas transações de crédito foram realizadas.
select 
	count(t.natureza) as credito
from 
	transacoes as t
where 
	t.natureza like 'CREDITO';
#13. Listar os nomes dos usuários que realizaram transações bancárias no último mês.
select 
	u.nome_user, count(t.id_trans)
from 
	usuarios as u
left join 
	transacoes as t
on 
	u.id_user = t.usuario
left join 
	contas as c
on 
	t.agencia = c.agencia and t.conta = c.conta and t.cod_banco = c.cod_banco
left join 
	saldos as s
on
	c.agencia = s.agencia and c.conta = s.conta and c.cod_banco = s.cod_banco
where 
	s.data_saldo = LAST_DAY(CURDATE())
group by 
	u.nome_user;
#14. Exibir os detalhes das transações que foram realizadas em contas com saldo negativo.
select
	t.*
from 
	transacoes as t
inner join 
	contas as c
on
	t.agencia = c.agencia and t.conta = c.conta and t.cod_banco = c.cod_banco
inner join
	saldos as s
on
	c.agencia = s.agencia and c.conta = s.conta and c.cod_banco = s.cod_banco
where
	valor_saldo < 0;
#15. Mostrar o valor total de transações de débito realizadas no último dia útil.
	
DESC SALDOS;
SELECT T.*
FROM TRANSACOES T
JOIN
SALDOS S ON T.AGENCIA = S.AGENCIA
AND T.CONTA = S.CONTA
AND T.COD_BANCO = S.COD_BANCO
WHERE T.NATUREZA = 'DEBITO' AND DATA_SALDO = CURDATE()-1;
