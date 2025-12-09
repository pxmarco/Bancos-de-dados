USE car;

-- TRUNCATE: Útil, por exemplo, quando os dados de registro são transferidos para uma tabela "histórico" periodicamente, liberando espaço para novos registros sem pesar o banco de dados
TRUNCATE TABLE car.registros;

-- Tabela usada para exemplo de DROP
CREATE TABLE car.transport (
  idTransportadora INT NOT NULL,
  nomeTransportadora VARCHAR(80) NOT NULL
);
-- DROP: Não há uma empresa transportadora terceirizada nesse esquema, logo, a criação desta tabela seria inútil
DROP TABLE car.transport;