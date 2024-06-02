use BDEX5_EVENTOS;
#1. Exibir todas as informações da tabela PARTICIPANTES.
select * from participantes;
#2. Mostrar os nomes e empresas dos participantes que nasceram depois do ano 1990.
select nome, empresa
from participantes
where year(data_nasc) > 1990;
#3. Listar os nomes dos eventos e as entidades organizadoras.
select nome_evento, entidade_evento
from eventos;
#4. Exibir os detalhes das atividades: ID da atividade, nome da atividade, data, hora, nome do evento.
select e.nome_evento, a.id_atividade, a.nome_atv, concat_ws('às',data_atv,hora_atv)
from atividades as a
inner join eventos as e
on a.evento_atv = id_evento
order by e.nome_evento;
#5. Listar o nome dos participantes e quantas atividades cada um participou.
select p.nome, count(pe.evento)
from participantes as p
left join participante_evento as pe
on p.cpf = pe.cpf and p.num_inscricao = pe.inscricao
group by p.nome;
#6. Mostrar os nomes dos eventos realizados em 2023.
select nome_evento
from eventos
where year(data_evento) = 2023;
#7. Listar todos os locais, ordenados pelo nome da cidade de A a Z.
select nome
from locais
order by nome;
#8. Mostrar os nomes e CPFs dos participantes que não têm empresa cadastrada.
select nome, cpf
from participantes
where isnull(empresa);
#9. Exibir os nomes dos participantes que estão inscritos em eventos realizados no local com nome 'Centro de Convenções'.
select p.nome
from participantes as p
inner join participante_evento as pe
on p.cpf = pe.cpf and p.num_inscricao = pe.inscricao
inner join eventos as e
on pe.evento = e.id_evento
inner join locais as l
on e.local_evento = l.id_local
where l.nome like 'Centro de Convenções';
#10. Para cada entidade organizadora, mostrar o nome da entidade e a média de eventos realizados.
select base.entidade, round(avg(base.num_evento),1)
from 
    (select entidade_evento as entidade, count(id_evento) as num_evento
    from eventos
    group by entidade_evento) as base
    group by base.entidade;
#11. Contar quantos participantes têm uma empresa cadastrada.
select empresa, count(cpf and num_inscricao) as funcionarios
from participantes
group by empresa;
#12. Listar os nomes dos participantes que participaram de mais de 5 atividades.
select base.participantes, base.atividades
from
    (select p.nome as participantes, count(pa.atividade) as atividades
    from participantes as p
    inner join participante_atividade as pa 
    on p.num_inscricao = pa.inscricao and p.cpf = pa.cpf
    group by p.nome) as base
    where atividades > 5;
#13. Mostrar o nome dos participantes e a data da última atividade que eles participaram.
select p.nome, max(a.data_atv)
from participantes as p
left join participante_atividade as pa
on p.num_inscricao = pa.inscricao and p.cpf = pa.cpf
inner join atividades as a
on pa.atividade = a.id_atividade
group by p.nome;
#14. Contar quantas atividades cada evento possui.

select e.nome_evento, count(a.id_atividade) as eventos
from eventos as e
left join atividades as a
on e.id_evento = a.evento_atv
group by e.nome_evento;

#15. Para cada participante que participou de um evento, mostrar o CPF, 
#o nome e a porcentagem de eventos em relação ao total de eventos realizados.

select base.participante, base.cpf, base.nome_evento, concat(round((base.evento/tudo.total)*100),'%') as porcentagem
from
    (select p.nome as participante, p.cpf as cpf, e.nome_evento as nome_evento, count(e.id_evento) as evento
    from participantes as p
    inner join participante_evento as pe
    on p.cpf = pe.cpf and p.num_inscricao = pe.inscricao
    inner join eventos as e
    on pe.evento = e.id_evento
    group by p.nome, p.cpf, e.nome_evento) as base
    join
          (select count(id_evento) as total
          from eventos) as tudo
order by base.participante;