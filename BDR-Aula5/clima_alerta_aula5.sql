-- Exclusão das tabelas (reset)
DROP TABLE IF EXISTS historico_status_evento;
DROP TABLE IF EXISTS alerta;
DROP TABLE IF EXISTS relato;
DROP TABLE IF EXISTS evento;
DROP TABLE IF EXISTS telefone;
DROP TABLE IF EXISTS localizacao;
DROP TABLE IF EXISTS tipo_evento;
DROP TABLE IF EXISTS estado;
DROP TABLE IF EXISTS usuario;


-- Criação das Tabelas
-- Tipos de Evento
CREATE TABLE tipo_evento (
    id_tipo_evento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

-- Estados
CREATE TABLE estado (
    sigla_estado CHAR(2) PRIMARY KEY,
    nome_estado VARCHAR(100) NOT NULL
);

-- Localizações
CREATE TABLE localizacao (
    id_localizacao SERIAL PRIMARY KEY,
    latitude NUMERIC(9,6) NOT NULL,
    longitude NUMERIC(9,6) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    sigla_estado CHAR(2) NOT NULL REFERENCES estado(sigla_estado)
);

-- Usuários
CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL
);

-- Telefones dos Usuários
CREATE TABLE telefone (
    id_telefone SERIAL PRIMARY KEY,
    numero VARCHAR(20) NOT NULL,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario)
);

-- Eventos
CREATE TABLE evento (
    id_evento SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    data_hora TIMESTAMP NOT NULL,
    status VARCHAR(30) CHECK (status IN ('Ativo','Em Monitoramento','Resolvido')),
    id_tipo_evento INT NOT NULL REFERENCES tipo_evento(id_tipo_evento),
    id_localizacao INT NOT NULL REFERENCES localizacao(id_localizacao)
);

-- Relatos de Usuários sobre Eventos
CREATE TABLE relato (
    id_relato SERIAL PRIMARY KEY,
    texto TEXT NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    id_evento INT NOT NULL REFERENCES evento(id_evento),
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario)
);

-- Alertas associados a Eventos
CREATE TABLE alerta (
    id_alerta SERIAL PRIMARY KEY,
    mensagem TEXT NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    nivel VARCHAR(20) CHECK (nivel IN ('Baixo','Médio','Alto','Crítico')),
    id_evento INT NOT NULL REFERENCES evento(id_evento)
);

-- Histórico de Status dos Eventos
CREATE TABLE historico_status_evento (
    id_historico SERIAL PRIMARY KEY,
    id_evento INT NOT NULL REFERENCES evento(id_evento),
    status_anterior VARCHAR(30),
    status_novo VARCHAR(30) CHECK (status_novo IN ('Ativo','Em Monitoramento','Resolvido')),
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Inserção de Dados
-- Tipos de Evento
INSERT INTO tipo_evento (nome, descricao) VALUES
('Queimada', 'Incêndio florestal em área de vegetação'),
('Deslizamento', 'Deslizamento de terra em área de risco'),
('Alagamento', 'Inundação causada por chuvas intensas'),
('Tempestade', 'Tempestade severa com raios e ventos fortes'),
('Incêndio Urbano', 'Fogo em área urbana');

-- Estados
INSERT INTO estado (sigla_estado, nome_estado) VALUES
('SP', 'São Paulo'),
('RJ', 'Rio de Janeiro'),
('MG', 'Minas Gerais'),
('BA', 'Bahia'),
('PR', 'Paraná');

-- Localizações
INSERT INTO localizacao (latitude, longitude, cidade, sigla_estado) VALUES
(-23.550520, -46.633308, 'São Paulo', 'SP'),
(-22.906847, -43.172896, 'Rio de Janeiro', 'RJ'),
(-19.916681, -43.934493, 'Belo Horizonte', 'MG'),
(-12.971399, -38.501305, 'Salvador', 'BA'),
(-25.428954, -49.267137, 'Curitiba', 'PR');

-- Usuários
INSERT INTO usuario (nome, email, senha_hash) VALUES
('Ana Souza', 'ana@example.com', 'hash_senha_1'),
('Bruno Lima', 'bruno@example.com', 'hash_senha_2'),
('Carla Mendes', 'carla@example.com', 'hash_senha_3'),
('Diego Alves', 'diego@example.com', 'hash_senha_4'),
('Eduarda Rocha', 'eduarda@example.com', 'hash_senha_5');

-- Telefones
INSERT INTO telefone (numero, id_usuario) VALUES
('(11)91234-5678', 1),
('(21)99876-5432', 2),
('(31)98765-4321', 3),
('(71)91234-0000', 4),
('(41)92345-1111', 5);

-- Eventos
INSERT INTO evento (titulo, descricao, data_hora, status, id_tipo_evento, id_localizacao) VALUES
('Foco de Queimada na Zona Sul', 'Incêndio detectado por satélite.', '2025-08-20 14:30:00', 'Ativo', 1, 1),
('Deslizamento em comunidade', 'Moradores relatam queda de barreira.', '2025-08-19 10:00:00', 'Em Monitoramento', 2, 2),
('Rua alagada após chuva', 'Acúmulo de água impossibilita tráfego.', '2025-08-21 07:15:00', 'Resolvido', 3, 3),
('Tempestade com quedas de árvore', 'Ruas bloqueadas por galhos.', '2025-08-20 18:00:00', 'Ativo', 4, 4),
('Incêndio em prédio comercial', 'Fogo controlado pelos bombeiros.', '2025-08-18 09:45:00', 'Resolvido', 5, 5);

-- Relatos
INSERT INTO relato (texto, data_hora, id_evento, id_usuario) VALUES
('Vi fumaça densa se aproximando da minha casa.', '2025-08-20 14:45:00', 1, 1),
('Barulho alto e queda de terra próximos.', '2025-08-19 10:30:00', 2, 2),
('Carros atolados na rua principal.', '2025-08-21 07:45:00', 3, 3),
('Árvores caíram bloqueando a entrada da rua.', '2025-08-20 18:30:00', 4, 4),
('Fumaça no prédio ao lado.', '2025-08-18 10:00:00', 5, 5);

-- Alertas
INSERT INTO alerta (mensagem, data_hora, nivel, id_evento) VALUES
('Alerta de queimada em área urbana.', '2025-08-20 15:00:00', 'Alto', 1),
('Risco de novos deslizamentos.', '2025-08-19 11:00:00', 'Crítico', 2),
('Evite trafegar pela região afetada.', '2025-08-21 08:00:00', 'Médio', 3),
('Previsão de nova tempestade à noite.', '2025-08-20 19:00:00', 'Alto', 4),
('Incêndio controlado, região segura.', '2025-08-18 11:00:00', 'Baixo', 5);

-- Histórico de Status
INSERT INTO historico_status_evento (id_evento, status_anterior, status_novo, data_alteracao) VALUES
(1, NULL, 'Ativo', '2025-08-20 14:30:00'),
(2, NULL, 'Em Monitoramento', '2025-08-19 10:00:00'),
(3, 'Em Monitoramento', 'Resolvido', '2025-08-21 07:30:00'),
(4, NULL, 'Ativo', '2025-08-20 18:00:00'),
(5, 'Ativo', 'Resolvido', '2025-08-18 10:30:00');


-- Consultas
-- Listar os relatos
SELECT id_relato, texto, data_hora
FROM relato;

-- Listar apenas os alertas
SELECT id_alerta, mensagem, nivel
FROM alerta;

-- Buscar tipo de evento específico
SELECT * FROM tipo_evento
WHERE nome = 'Queimada';

-- Listar eventos ativos
SELECT * FROM evento
WHERE status = 'Ativo';