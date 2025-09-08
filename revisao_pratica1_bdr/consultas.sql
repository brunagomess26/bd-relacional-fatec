--Consultas

--Consulta simples: listar clientes
SELECT id_cliente, nome, cidade
FROM cliente;

--Consulta com filtro: jogos após 2020
SELECT titulo, ano_lancamento
FROM jogo
WHERE ano_lancamento > 2020;

--Função de agregação: soma das quantidades de jogos comprados
SELECT SUM(quantidade) AS total_jogos_comprados
FROM compra_jogo;

