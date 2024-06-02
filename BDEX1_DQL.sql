#Usando a base de dados BDEX1_HOSPITAL, responda:
USE BDEX1_HOSPITAL;

# 1 - Exibir todas as informações da tabela PACIENTES.

select * from pacientes;

# 2 - Mostrar os nomes e e-mails dos pacientes que nasceram depois do ano 2000.

select nome, email
from pacientes
where year(data_nasc) > 2000;

# 3 - Listar os nomes dos médicos e as especialidades em que trabalham.

select m.nome,
IF(d.nome_especialidade IS NULL, 'Clinico Geral',d.nome_especialidade) as especialidade
-- IF(CONDICAO), ACAO, SENAO ACAO
from medicos as m
left join departamentos as d
on d.cod_especialidade = m.depto_cod_espec;

# 4 - Exibir os detalhes das consultas: ID da consulta, data, hora, nome do médico e nome do paciente.

select c.id_consulta, concat_ws('-',c.data_cons,c.hora_cons) as horario, m.nome as medico, p.nome as paciente
from consultas as c
inner join medicos as m
on m.crm = c.crm and m.uf = c.uf
inner join pacientes as p
on p.cpf_paciente = c.cpf_paciente;

# 5 - Listar o nome dos pacientes e quantas consultas cada um fez.

select p.nome, count(c.id_consulta)
from pacientes as p
left join consultas as c
on p.cpf_paciente = c.cpf_paciente
group by p.nome;

# 6 - Mostrar as especialidades de médicos que fizeram consultas em 2024.

select distinct d.nome_especialidade
from departamentos as d
inner join medicos as m
on m.depto_cod_espec = d.cod_especialidade
inner join consultas as c
on m.crm = c.crm and m.uf = c.uf
where year(data_cons) = 2024;

# 7 - Listar todos os departamentos, ordenados pelo nome da especialidade de A a Z.

select nome_especialidade
from departamentos
order by nome_especialidade;

# 8 - Mostrar os nomes e e-mails dos médicos que não têm telefone cadastrado.

select nome, email
from medicos
where isnull(telefone);

# 9 - Exibir os nomes dos pacientes que têm consultas com médicos do departamento de Cardiologia.

select p.nome
from pacientes as p
inner join consultas as c
on p.cpf_paciente = c.cpf_paciente
inner join medicos as m
on m.crm = c.crm and m.uf = c.uf
inner join departamentos as d
on d.cod_especialidade = m.depto_cod_espec
where d.nome_especialidade = 'Cardiologia';

# 10 - Para cada especialidade, mostrar o nome da especialidade e a média de consultas realizadas pelos médicos dessa especialidade.

select base.especialidade, round(avg(base.num_con), 1) as media
from
    (select d.nome_especialidade as especialidade, 
    count(c.id_consulta) as num_con
    from departamentos as d
    inner join medicos as m
    on m.depto_cod_espec = d.cod_especialidade
    inner join consultas as c
    on m.crm = c.crm and m.uf = c.uf
    group by d.nome_especialidade) as base
group by base.especialidade
order by base.especialidade;

# 11 - Contar quantos pacientes têm um telefone cadastrado.

select count(*)
from pacientes
where isnull(telefone);

# 13 - Mostrar o nome dos pacientes e a data da última consulta que eles fizeram.
desc pacientes;
desc consultas;

select p.nome, max(c.data_cons)
from pacientes as p
left join consultas as c
on c.cpf_paciente = p.cpf_paciente
group by p.nome;


# 14 - Contar quantas consultas cada médico realizou.
desc medicos;
desc consultas;

select m.nome, count(c.id_consulta)
from medicos as m
left join consultas as c
on m.crm = c.crm and m.uf = c.uf
group by m.nome;

# 15 - Para cada paciente que fez uma consulta, mostrar o CPF, o nome e a porcentagem de consultas
# em relação ao total de consultas feitas por todos os pacientes.

select base.nome_pac, base.cpf, concat(round((base.individual/tudo.total)*100,1),'%') as porcentagem
from 
	(select p.nome as nome_pac, p.cpf_paciente as cpf, count(c.id_consulta) as individual
    from pacientes as p
    inner join consultas as c
    on p.cpf_paciente = c.cpf_paciente
    group by p.nome, p.cpf_paciente)as base,
        (select count(id_consulta) as total
        from consultas) as tudo
order by base.nome_pac;




