--Reset
DROP TABLE IF EXISTS focos_calor;

--Criar tabela
CREATE TABLE IF NOT EXISTS focos_calor (
    id_foco SERIAL PRIMARY KEY,
    estado VARCHAR(100) NOT NULL,
    bioma VARCHAR(100) NOT NULL,
    data_ocorrencia DATE NOT NULL
);

--Inserir registros
INSERT INTO focos_calor (estado, bioma, data_ocorrencia) VALUES
('Amazonas', 'Amazônia', '2025-02-01'),
('Mato Grosso', 'Cerrado', '2025-02-03'),
('Pará', 'Amazônia', '2025-02-05');

-- Consultar os dados inseridos
SELECT * FROM focos_calor;