-- Inserir dados

-- Lojas
INSERT INTO loja (nome, cidade) VALUES
('Game Store', 'Jacareí'),
('Bazinga Games', 'São Paulo'),
('Level Up Games', 'São José dos Campos');

-- Jogos
INSERT INTO jogo (titulo, ano_lancamento, genero) VALUES
('The Legend of Zelda: Breath of the Wild', 2017, 'Aventura'),
('Elden Ring', 2022, 'RPG'),
('Cyberpunk 2077', 2020, 'RPG de Ação');

-- Clientes
INSERT INTO cliente (nome, email, cidade) VALUES 
('Renan Pereira Sanches', 'renansss@gmail.com', 'Jacareí'),
('Ana Alencar Silva', 'anaalencar@gmail.com', 'São José dos Campos'),
('Cauã Santos Barbosa', 'cauabarbosa@gmail.com', 'São Paulo');

-- Compras
INSERT INTO compra (data_compra, id_cliente, id_loja) VALUES
('2025-09-05 14:30:00', 1, 1),
('2025-09-03 16:45:00', 3, 2);

-- Jogos comprados
INSERT INTO compra_jogo (id_compra, id_jogo, quantidade) VALUES
(1, 1, 1),  
(1, 2, 2),  
(2, 3, 1), 
(2, 2, 1);  