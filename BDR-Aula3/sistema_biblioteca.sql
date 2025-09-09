-- Criar tabelas

-- Autores
CREATE TABLE autor (
    id_autor SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    nacionalidade VARCHAR(100)
);

-- Livros
CREATE TABLE livro (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    ano_publicacao INT NOT NULL,
    isbn VARCHAR(20) UNIQUE
);

-- Tabela associativa Livro/Autor (muitos para muitos)
CREATE TABLE livro_autor (
    id_livro INT NOT NULL REFERENCES livro(id_livro),
    id_autor INT NOT NULL REFERENCES autor(id_autor),
    PRIMARY KEY (id_livro, id_autor)
);

-- Clientes (Leitores)
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);

-- Empréstimos
CREATE TABLE emprestimo (
    id_emprestimo SERIAL PRIMARY KEY,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    id_cliente INT NOT NULL REFERENCES cliente(id_cliente)
);

-- Tabela associativa Empréstimo/Livro (muitos para muitos)
CREATE TABLE emprestimo_livro (
    id_emprestimo INT NOT NULL REFERENCES emprestimo(id_emprestimo),
    id_livro INT NOT NULL REFERENCES livro(id_livro),
    PRIMARY KEY (id_emprestimo, id_livro)
);

-- Inserção de dados

-- Autores
INSERT INTO autor (nome, nacionalidade) VALUES
('J.K. Rowling', 'Britânica'),
('George R.R. Martin', 'Americano'),
('J.R.R. Tolkien', 'Britânico');

-- Livros
INSERT INTO livro (titulo, ano_publicacao, isbn) VALUES
('Harry Potter e a Pedra Filosofal', 1997, '9780747532699'),
('A Guerra dos Tronos', 1996, '9780553103540'),
('O Senhor dos Anéis', 1954, '9780261102385');

-- Livro/Autor
INSERT INTO livro_autor (id_livro, id_autor) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Clientes
INSERT INTO cliente (nome, email, telefone) VALUES
('Ana Souza', 'ana@gmail.com', '(11)91234-5678'),
('Bruno Lima', 'bruno@gmail.com', '(21)99876-5432'),
('Carla Mendes', 'carla@gmail.com', '(31)98765-4321');

-- Empréstimos
INSERT INTO emprestimo (data_emprestimo, data_devolucao, id_cliente) VALUES
('2025-09-01', '2025-09-10', 1),
('2025-09-02', NULL, 2);

-- Empréstimo/Livro
INSERT INTO emprestimo_livro (id_emprestimo, id_livro) VALUES
(1, 1),
(1, 2),
(2, 3);

-- Consulta exemplo
SELECT * FROM emprestimo;
