USE BDEX3_REDESOCIAL;

#1. Exibir todas as informações da tabela `USUARIOS`.

select *
from usuarios;

#2. Mostrar os nomes, sobrenomes e e-mails dos usuários.

select nome_usuario, sobrenome, email
from usuarios;

#3. Listar os nomes e descrições dos grupos.

select nome_grupo, descricao
from grupos;

#4. Exibir os detalhes das postagens: ID da postagem, texto, data e hora, e o nome do usuário que postou.

select p.id_post, p.texto, p.data_hora, u.nome_usuario
from postagens as p
join usuarios as u
on p.usuario = u.id_usuario;

#5. Listar o nome dos usuários e a quantidade de postagens que cada um fez.


select u.nome_usuario, count(p.id_post)
from usuarios as u
left join postagens as p
on p.usuario = u.id_usuario
group by u.nome_usuario;

#6. Mostrar os nomes dos usuários que fizeram comentários em 2024.

select distinct(u.nome_usuario)
from usuarios as u
inner join postagens as p
on p.usuario = u.id_usuario
where YEAR(p.data_hora) = 2024;

#7. Listar todos os grupos, ordenados pelo nome do grupo de A a Z.

select nome_grupo
from grupos
order by nome_grupo asc;

#8. Mostrar os nomes dos grupos que têm a palavra "Tecnologia" na descrição.

select nome_grupo
from grupos
where descricao LIKE '%TECNOLOGIA%';

#9. Exibir os detalhes dos comentários: ID do comentário, texto, data e hora, nome do usuário que comentou e ID da postagem comentada.

select c.id_comentario, c.texto, c.datahora, c.post, u.nome_usuario
from comentarios as c
inner join usuarios as u
on u.id_usuario = usuario;

#10. Para cada postagem, mostrar o ID da postagem e a quantidade de comentários.

select p.id_post, count(c.id_comentario)
from postagens as p
left join comentarios as c
on p.id_post = post
group by id_post;

#11. Contar quantos seguidores cada usuário possui.

select u.nome_usuario, count(s.seguidor)
from usuarios as u
left join seguidores_usuarios as s
on u.id_usuario = s.usuario
group by u.nome_usuario;

#12. Listar os nomes dos usuários que pertencem ao grupo "Desenvolvimento".
# não existe nenhum grupo chamando Desenvolvimento!

select u.nome_usuario
from usuarios as u
join usuarios_grupos as ug
on u.id_usuario = ug.usuario
join grupos as g
on ug.grupo = g.id_grupo
where nome_grupo = 'Desenvolvimento';

#13. Mostrar o nome dos usuários e a data e hora da última postagem que eles fizeram.

select u.nome_usuario, max(p.data_hora)
from usuarios as u
left join postagens as p
on u.id_usuario = p.usuario
group by u.nome_usuario;

#14. Contar quantas postagens cada usuário fez.

select u.nome_usuario, count(p.id_post)
from usuarios as u
left join postagens as p
on u.id_usuario = p.usuario
group by u.nome_usuario; 

#15. Para cada grupo, exibir o nome do grupo e a quantidade de usuários que pertencem a ele.

select g.nome_grupo, count(ug.usuario)
from grupos as g
left join usuarios_grupos as ug
on g.id_grupo = ug.grupo
group by g.nome_grupo;