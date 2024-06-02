USE BDEX2_PASSAGENS_AEREAS;
#Usando a base de dados BDEX2_PASSAGENS_AEREAS, responda:

# 1 - Exibir todas as informações da tabela PASSAGEIROS.
select * 
from passageiros;
# 2 - Mostrar os nomes e sobrenomes dos passageiros que nasceram depois do ano 1990.

select concat_ws(' ',nome,sobrenome) as passageiro, data_nasc as nascimento
from passageiros
where year(data_nasc) > 1990;
# 3 - Listar os nomes dos aeroportos e as cidades onde estão localizados.

select nome, cidade
from aeroportos
order by nome;
# 4 - Exibir os detalhes das reservas: ID da reserva, data da reserva, forma de pagamento e valor da reserva.

select id_reserva, data_reserva, forma_pgto, valor_reserva
from reservas;
# 5 - Listar o nome das companhias aéreas e quantas aeronaves cada uma possui.

select ca.nome_fantasia as cia, count(a.pfx_aero)
from cia_aereas as ca
left join aeronaves as a
on ca.id_cia = a.cia_aerea
group by cia;

# 6 - Mostrar os nomes dos passageiros que fizeram reservas em 2023.

select p.nome
from passageiros as p
inner join passageiros_reservas as pr
on pr.passageiro = p.cod_passageiro
inner join reservas as r
on r.id_reserva = pr.id_reserva
where year(data_reserva) = 2023;

# 7 - Listar todas as companhias aéreas, ordenadas pelo nome fantasia de A a Z.

select nome_fantasia
from cia_aereas
order by nome_fantasia;

# 8 - Mostrar os nomes dos aeroportos que têm pista com tamanho maior que 3000 metros.

select nome 
from aeroportos
where tamanho_pista > 3000;

# 9 - Exibir os detalhes dos voos: ID do voo, assento, aeroporto de partida, data e hora de partida, 
# aeroporto de chegada, data e hora de chegada, modelo da aeronave e nome da companhia aérea.

select v.id_voo,
v.assento,
aeropart.nome,
concat_ws('',v.HORA_PART,v.DATA_PART),
aerocheg.nome,
concat_ws('',v.HORA_CHEG,v.DATA_CHEG),
nave.modelo,
ca.nome_fantasia
from voos as v
inner join aeroportos as aeropart
on aeropart.id_aeroporto = v.aero_part
inner join aeroportos as aerocheg
on aerocheg.id_aeroporto = v.aero_cheg
inner join aeronaves as nave
on nave.pfx_aero = v.aeronave
inner join cia_aereas as ca
on ca.id_cia = v.cia_aerea
order by id_voo;

# 10 - Para cada voo, mostrar o ID do voo e a quantidade de assentos reservados.

select id_voo, count(assento)
from voos
group by id_voo;

# 11 - Contar quantos passageiros têm nacionalidade brasileira.

select concat_ws(' ', nome, sobrenome)
from passageiros
where nacionalidade like ('brasileir%');

# 12 - Listar os nomes das aeronaves e o ano de fabricação que possuem mais de 150 poltronas.

select pfx_aero, ano_fabr
from aeronaves
where poltronas > 150;

# 13 - Mostrar o nome dos passageiros e a data da última reserva que eles fizeram.

select concat_ws(' ',p.nome,p.sobrenome) as nome_completo, max(r.data_reserva) as ultima_reserva
from passageiros as p
inner join passageiros_reservas as pr
on p.cod_passageiro = pr.passageiro
inner join reservas as r
on pr.id_reserva = r.id_reserva
group by nome_completo;

# 14 - Contar quantas reservas foram feitas por cada passageiro.

select concat_ws(' ',p.nome,p.sobrenome) as nome_completo, count(r.id_reserva)
from passageiros as p
inner join passageiros_reservas as pr
on p.cod_passageiro = pr.passageiro
inner join reservas as r
on pr.id_reserva = r.id_reserva
group by nome_completo;

# 15 - Para cada reserva feita em 2023, mostrar o ID da reserva,
# o valor da reserva e a porcentagem desse valor em relação ao 
# valor total de reservas feitas em 2023.

select base.reserva, base.valor, concat(round((base.valor/tudo.total)*100,1), '%') as porcentagem
from
    (select r.id_reserva as reserva, r.valor_reserva as valor
    from reservas as r) as base,
		(select SUM(r.valor_reserva) as total
        from reservas as r) as tudo;


