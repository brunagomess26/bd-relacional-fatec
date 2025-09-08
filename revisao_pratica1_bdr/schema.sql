-- Remover tabelas (reset)
DROP TABLE IF EXISTS compra_jogo;
DROP TABLE IF EXISTS compra;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS jogo;
DROP TABLE IF EXISTS loja;

-- Criar tabelas

-- Tabela de Lojas
CREATE TABLE IF NOT EXISTS loja (
    id_loja SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR (100) NOT NULL
);

-- Tabela de Jogos
CREATE TABLE IF NOT EXISTS jogo (
    id_jogo SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    ano_lancamento INT NOT NULL,
    genero VARCHAR (100) NOT NULL
);

-- Tabela de clientes
CREATE TABLE IF NOT EXISTS cliente (
    id_cliente SERIAL PRIMARY KEY, 
    nome VARCHAR (100) NOT NULL,
    email VARCHAR (100) UNIQUE NOT NULL,
    cidade VARCHAR (100) NOT NULL
);

-- Tabela de compras
CREATE TABLE IF NOT EXISTS compra (
    id_compra SERIAL PRIMARY KEY,
    data_compra TIMESTAMP NOT NULL, 
    id_cliente INT REFERENCES cliente (id_cliente),
    id_loja INT REFERENCES loja (id_loja)
);

-- Tabela Associativa: Compra x Jogo
CREATE TABLE IF NOT EXISTS compra_jogo (
    id_compra INT REFERENCES compra(id_compra),
    id_jogo INT REFERENCES jogo (id_jogo),
    quantidade INT NOT NULL CHECK (quantidade > 0),
    PRIMARY KEY (id_compra, id_jogo)
);
