-- Criação de tabelas

CREATE TABLE Foco_queimada (
    id_foco INT PRIMARY KEY,
    latitude DECIMAL(9,6),   
    longitude DECIMAL(9,6), 
    frp INT                  
);

CREATE TABLE Pais (
    id_pais INT PRIMARY KEY,
    nome_pais VARCHAR(100) NOT NULL,
    area_atingida DECIMAL(12,2)
);

CREATE TABLE Estado (
    id_estado INT PRIMARY KEY,
    nome_estado VARCHAR(100) NOT NULL,
    area_atingida DECIMAL(12,2),
    sigla_estado CHAR(2) NOT NULL,
    id_pais INT,
    FOREIGN KEY (id_pais) REFERENCES Pais(id_pais)
);

CREATE TABLE Municipio (
    id_municipio INT PRIMARY KEY,
    nome_municipio VARCHAR(100) NOT NULL,
    area_atingida DECIMAL(12,2),
    id_estado INT,
    FOREIGN KEY (id_estado) REFERENCES Estado(id_estado)
);

CREATE TABLE Bioma (
    id_bioma INT PRIMARY KEY,
    nome_bioma VARCHAR(100) NOT NULL,
    area_atingida DECIMAL(12,2)
);

CREATE TABLE Satelite (
    id_satelite INT PRIMARY KEY,
    nome_satelite VARCHAR(100) NOT NULL
);

CREATE TABLE Alerta (
    id_alerta INT PRIMARY KEY,
    nivel_alerta INT NOT NULL
);

CREATE TABLE Usuario (
    id_user INT PRIMARY KEY,
    nome_user VARCHAR(100) NOT NULL,
    contato_user VARCHAR(100)
);

-- Criação de tabelas relacionamentos

-- Relaciona satélites e alertas
CREATE TABLE Dados_obtidos (
    id_satelite INT,
    id_alerta INT,
    PRIMARY KEY (id_satelite, id_alerta),
    FOREIGN KEY (id_satelite) REFERENCES Satelite(id_satelite),
    FOREIGN KEY (id_alerta) REFERENCES Alerta(id_alerta)
);

-- Relaciona usuários e alertas (mensagens)
CREATE TABLE Mensagem (
    id_mensagem INT PRIMARY KEY,
    id_user INT,
    id_alerta INT,
    mensagem VARCHAR(255),
    FOREIGN KEY (id_user) REFERENCES Usuario(id_user),
    FOREIGN KEY (id_alerta) REFERENCES Alerta(id_alerta)
);

-- Localização do foco
CREATE TABLE Onde (
    id_foco INT,
    id_pais INT,
    id_estado INT,
    id_municipio INT,
    id_bioma INT,
    PRIMARY KEY (id_foco, id_pais, id_estado, id_municipio, id_bioma),
    FOREIGN KEY (id_foco) REFERENCES Foco_queimada(id_foco),
    FOREIGN KEY (id_pais) REFERENCES Pais(id_pais),
    FOREIGN KEY (id_estado) REFERENCES Estado(id_estado),
    FOREIGN KEY (id_municipio) REFERENCES Municipio(id_municipio),
    FOREIGN KEY (id_bioma) REFERENCES Bioma(id_bioma)
);

-- Relação entre foco e satélite
CREATE TABLE Monitora (
    id_monitoramento INT PRIMARY KEY,
    id_foco INT,
    id_satelite INT,
    FOREIGN KEY (id_foco) REFERENCES Foco_queimada(id_foco),
    FOREIGN KEY (id_satelite) REFERENCES Satelite(id_satelite)
);
