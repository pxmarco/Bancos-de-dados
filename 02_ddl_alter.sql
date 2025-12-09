USE car;

-- Criação de coluna extra sobre informações do cliente, neste caso, sobre estado civil.
ALTER TABLE car.categoria 
ADD COLUMN estadoCivil CHAR(100);

-- Coluna alterada para limpeza de dados, para otimizar a velocidade do processamento.
ALTER TABLE car.categoria 
MODIFY COLUMN estadoCivil INT;

-- Entretanto, não é útil, logo a coluna será deletada. 
ALTER TABLE car.categoria 
DROP COLUMN estadoCivil;