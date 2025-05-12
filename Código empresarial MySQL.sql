-- Passo 1
create database bd1;
use bd1;
create schema Empresa;

-- Passo 2
create table Funcionario (
	cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    salario FLOAT DEFAULT 2000,
    data_nascimento date
);

-- Passo 3
ALTER TABLE Funcionario ADD COLUMN email VARCHAR(100);

-- Passo 4
CREATE TABLE Departamento (
    id INT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE,
    gerente CHAR(11),
    FOREIGN KEY (gerente) REFERENCES Funcionario(cpf)
);

-- Passo 5
ALTER TABLE Funcionario ADD CONSTRAINT chk_salario check (salario > 1000);

-- Passo 6
INSERT INTO Funcionario (cpf, nome, salario, data_nascimento, email)
VALUES
	('12332145665', 'Juliana', 1800, '2000-07-15', 'jujubs@gmail.com'),
    ('98778965445', 'Kelen', 2000, '1988-02-20', 'kelenphp@gmail.com'),
    ('59912882371', 'Israel', 2500, '1999-10-10', 'israel.cs@gmail.com');

-- Passo 7
SET SQL_SAFE_UPDATES = 0;
UPDATE Funcionario SET salario = 2500 WHERE salario = 2000;

-- Passo 8
DELETE FROM Funcionario WHERE cpf = '12332145665';

-- Passo 9
INSERT INTO Departamento (id, nome, gerente)
VALUES 
	(7049, 'Financeiro', '59912882371'),
    (7040, 'Administrativo', '98778965445');

-- Passo 10
SELECT * FROM Funcionario WHERE Salario > 2200;

-- Passo 11
CREATE TABLE Projeto (
	id_projeto INT PRIMARY KEY,
    nome VARCHAR(100),
	local VARCHAR(50),
	id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id)
);

-- Passo 12
INSERT INTO Projeto (id_projeto, nome, local, id_departamento)
VALUES 
	(505, 'Cobranca', 'SHVP, Ch 101, lote 2', 7049),
    (502, 'Emprestimo', 'SHVP, Ch 101, lote 1', 7040);

-- Passo 13
SELECT 
    p.nome AS projeto,
    d.nome AS departamento,
    f.nome AS gerente
FROM Projeto p
JOIN Departamento d ON p.id_departamento = d.id
JOIN Funcionario f ON d.gerente = f.cpf;