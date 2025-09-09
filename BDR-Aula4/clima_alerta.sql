--Excluir tabelas
DROP TABLE if exists historico_status_evento;
DROP TABLE if exists alerta;
DROP TABLE if exists relato;
DROP TABLE if exists evento;
DROP TABLE if exists telefone;
DROP TABLE if exists localizacao;
DROP TABLE if exists tipo_evento;
DROP TABLE if exists estado;
DROP TABLE if exists usuario;


--Criar tabelas
-- Tabela de Tipos de Evento
CREATE TABLE tipo_evento (
 id_tipo_evento SERIAL PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 descricao TEXT
);

-- Tabela de Estados
CREATE TABLE estado (
 sigla_estado CHAR(2) PRIMARY KEY,
 nome_estado VARCHAR(100) NOT NULL
);

-- Tabela de Localização
CREATE TABLE localizacao (
 id_localizacao SERIAL PRIMARY KEY,
 latitude NUMERIC(9,6) NOT NULL,
 longitude NUMERIC(9,6) NOT NULL,
 cidade VARCHAR(100) NOT NULL,
 sigla_estado CHAR(2) NOT NULL REFERENCES estado(sigla_estado)
);

-- Tabela de Usuários
CREATE TABLE usuario (
 id_usuario SERIAL PRIMARY KEY,
 nome VARCHAR(150) NOT NULL,
 email VARCHAR(150) UNIQUE NOT NULL,
 senha_hash VARCHAR(255) NOT NULL
);

-- Tabela de Telefones do Usuário
CREATE TABLE telefone (
 id_telefone SERIAL PRIMARY KEY,
 numero VARCHAR(20) NOT NULL,
 id_usuario INT NOT NULL REFERENCES usuario(id_usuario)
);

-- Tabela de Eventos
CREATE TABLE evento (
 id_evento SERIAL PRIMARY KEY,
 titulo VARCHAR(150) NOT NULL,
 descricao TEXT,
 data_hora TIMESTAMP NOT NULL,
 status VARCHAR(30) CHECK (status IN ('Ativo','Em Monitoramento','Resolvido')),
 id_tipo_evento INT NOT NULL REFERENCES tipo_evento(id_tipo_evento),
 id_localizacao INT NOT NULL REFERENCES localizacao(id_localizacao)
);

-- Tabela de Relatos
CREATE TABLE relato (
 id_relato SERIAL PRIMARY KEY,
 texto TEXT NOT NULL,
 data_hora TIMESTAMP NOT NULL,
 id_evento INT NOT NULL REFERENCES evento(id_evento),
 id_usuario INT NOT NULL REFERENCES usuario(id_usuario)
);

-- Tabela de Alertas
CREATE TABLE alerta (
 id_alerta SERIAL PRIMARY KEY,
 mensagem TEXT NOT NULL,
 data_hora TIMESTAMP NOT NULL,
 nivel VARCHAR(20) CHECK (nivel IN ('Baixo','Médio','Alto','Crítico')),
 id_evento INT NOT NULL REFERENCES evento(id_evento)
);


--Tabela histórico de status do evento
CREATE TABLE historico_status_evento (
  id_historico SERIAL PRIMARY KEY,
  id_evento INT NOT NULL REFERENCES evento(id_evento),
  status_anterior VARCHAR(30),
  status_novo VARCHAR(30) CHECK (status_novo IN ('Ativo','Em Monitoramento','Resolvido')),
  data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
