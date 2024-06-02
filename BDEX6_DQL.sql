use BDEX6_CINEMA;
#1. Criar uma consulta para exibir todas as informações da tabela ESPECTADORES.
select * from espectadores;
#2. Escrever uma consulta para mostrar os nomes e e-mails dos espectadores que nasceram antes de 1995.
select nome_espec, email_espec
from espectadores
where year(data_nasc) < 1995;
#3. Listar os nomes das salas de cinema e suas capacidades.
select nome, capacidade
from salas;
#4. Exibir os detalhes das sessões de cinema: ID da sessão, nome do filme, nome da sala.
select se.id_sessao, se.filme, sa.nome
from sessoes as se
inner join salas as sa
on se.sala = sa.id_sala;
#5. Listar o nome e o distribuidor dos filmes com tempo de exibição superior a 120 minutos.
select nome_filme, distribuidor_filme
from filmes
where tempo_filme > 120;
#6. Mostrar as informações das sessões que exibiram filmes do diretor "Christopher Nolan".
select se.*
from sessoes as se
inner join filmes as f
on se.filme = f.id_filme
where f.diretor like 'Christopher Nolan';
#7. Listar os nomes e as capacidades das salas de cinema ordenadas pela capacidade de forma decrescente.
select nome, capacidade
from salas
order by capacidade desc;
#8. Exibir os detalhes dos ingressos: ID do ingresso, data, hora, nome do filme e nome do espectador.
select i.id_ingresso, concat_ws(' -> ',i.data_ing,i.hora_ing), f.nome_filme, e.nome_espec
from ingressos as i
inner join espectadores as e
on i.espectador = e.id_espec
inner join sessoes as se
on i.sessao = se.id_sessao
inner join filmes as f
on se.filme = f.id_filme;
#9. Mostrar os nomes e as idades dos espectadores que têm telefone cadastrado.
select nome_espec, 2024 - year(data_nasc)
from espectadores
where tel_espec is not null;
#10. Listar os nomes dos filmes que foram exibidos em mais de uma sessão.
-- Usando where
select base.Filme
from
    (select f.nome_filme as filme, count(se.id_sessao) as vixe
    from filmes as f
    inner join sessoes as se
    on f.id_filme = se.filme
    group by f.id_filme
    ) as base
where base.vixe > 1;
-- Usando having
select f.nome_filme as filme
from filmes as f
inner join sessoes as se
on f.id_filme = se.filme
group by f.id_filme
having count(se.id_sessao) > 1;
#11. Para cada sala de cinema, mostrar o nome da sala e a quantidade total de ingressos vendidos.
select sa.nome, count(i.id_ingresso) as qtd
from salas as sa
left join sessoes as se
on sa.id_sala = se.sala
inner join ingressos as i
on se.id_sessao = i.sessao
group by sa.nome;
#12. Contar quantos espectadores têm um e-mail cadastrado.
select nome_espec
from espectadores
where email_espec is not null;
#13. Listar os nomes dos filmes que foram exibidos em sessões agendadas para o dia de hoje.
select f.nome_filme
from filmes as f
inner join sessoes as se
on f.id_filme = se.filme
inner join ingressos as i
on se.id_sessao = i.sessao
where i.data_ing = curdate();
#14. Exibir os detalhes das sessões que exibiram filmes com tempo de exibição inferior a 90 minutos.
select se.*
from sessoes as se
inner join filmes as f
on se.filme = f.id_filme
where tempo_filme < 90;
#15. Mostrar o nome do filme e a data da sessão para todas as sessões agendadas para o próximo sábado.
select f.nome_filme, i.data_ing
from filmes as f
inner join sessoes as se
on f.id_filme = se.filme
inner join ingressos as i
on se.id_sessao = i.sessao
where DAYOFWEEK(i.data_ing) = 7;
-- Não é o próximo sábado, talvez substituir pela data do próximo sabádo