USE car; 

INSERT INTO car.filial (nome, cidade, uf) VALUES
('Locacion Goiânia', 'Goiânia', 'GO'),
('Locacion Campinas', 'Campinas', 'SP'),
('Locacion Brasília', 'Brasília', 'DF'),
('Locacion Rio de Janeiro', 'Rio de Janeiro', 'RJ');

INSERT INTO car.categoria (nome, descricao, valorDiariaPadrao) VALUES
('Econômico', 'Carros de baixo consumo.', 50.00),
('Sedan', 'Carros compactos e médios.', 75.50),
('SUV Compacto', 'Carros compactos, altos e esportivos.', 95.00),
('Executivo', 'Carros de alto padrão.', 150.00),
('Van/Minivan', 'Carros para transporte de 7 a 9 pessoas.', 120.00);

INSERT INTO car.cliente (nome, cpf, email, telefone, dtCadastro) VALUES
('Ana Silva', '12345678901', 'ana.silva@email.com', '(21)98765-4321', '2024-01-15'),
('Bruno Costa', '23456789012', 'bruno.c@email.com', '(11)99876-5432', '2024-02-20'),
('Carla Oliveira', '34567890123', 'carla.o@email.com', '(61)97654-3210', '2024-03-10'),
('Daniel Santos', '45678901234', 'daniel.s@email.com', '(21)96543-2109', '2024-04-05'),
('Eliane Pereira', '56789012345', 'eliane.p@email.com', '(11)95432-1098', '2024-05-12'),
('Fábio Souza', '67890123456', 'fabio.s@email.com', '(61)94321-0987', '2024-06-01'),
('Gabriela Almeida', '78901234567', 'gabriela.a@email.com', '(21)93210-9876', '2024-07-25'),
('Hugo Rocha', '89012345678', 'hugo.r@email.com', '(11)92109-8765', '2024-08-08');

-- Em statusVeiculo: 1=disponível; 2=manutenção; 3=indisponível
INSERT INTO car.veiculo (idCategoria, idFilial, placa, renavam, marca, modelo, ano, statusVeiculo) VALUES
(1, 1, 'ABC1A23', '11111111111', 'Fiat', 'Mobi', 2023, 1),
(1, 1, 'DEF4B56', '22222222222', 'Renault', 'Kwid', 2024, 1),
(1, 2, 'GHI7C89', '33333333333', 'Chevrolet', 'Onix', 2023, 1),
(1, 3, 'JKL0D12', '44444444444', 'Hyundai', 'HB20', 2022, 1),
(2, 1, 'MNO3E45', '55555555555', 'VW', 'Virtus', 2024, 1),
(2, 2, 'PQR6F78', '66666666666', 'Nissan', 'Versa', 2023, 1),
(2, 3, 'STU9G01', '77777777777', 'Honda', 'City', 2022, 1),
(2, 1, 'VWX2H34', '88888888888', 'Fiat', 'Cronos', 2024, 2),
(3, 2, 'YZA5I67', '99999999999', 'Jeep', 'Renegade', 2023, 1),
(3, 3, 'BCD8J90', '10101010101', 'VW', 'T-Cross', 2024, 1),
(3, 1, 'EFG1K23', '12121212121', 'Hyundai', 'Creta', 2022, 1),
(3, 2, 'HIJ4L56', '13131313131', 'Nissan', 'Kicks', 2023, 3),
(4, 3, 'KLM7M89', '14141414141', 'BMW', '320i', 2024, 1),
(4, 1, 'NOP0N12', '15151515151', 'Mercedes', 'C180', 2023, 1),
(4, 2, 'QRS3O45', '16161616161', 'Audi', 'A4', 2022, 1),
(5, 3, 'TUV6P78', '17171717171', 'Chevrolet', 'Spin', 2024, 1),
(5, 1, 'WXY9Q01', '18181818181', 'Citroen', 'C4 Picasso', 2023, 1),
(1, 2, 'ZAB2R34', '19191919191', 'Ford', 'Ka', 2022, 1),
(2, 3, 'CDE5S67', '20202020202', 'GM', 'Cruze Sedan', 2024, 1), 
(3, 1, 'FGH8T90', '21212121212', 'Fiat', 'Pulse', 2023, 1);

-- Em statusReserva: 1=aberta; 2=cancelada; 3=efetuada
INSERT INTO car.reserva (idCliente, idVeiculo, idFilialRetirada, idFilialDevolucaoPrev, dtInicioPrev, dtFimPrev, statusReserva) VALUES
(1, 1, 1, 1, '2025-11-25 10:00:00', '2025-11-28 10:00:00', 3),
(2, 3, 2, 3, '2025-12-01 09:00:00', '2025-12-05 09:00:00', 3),
(3, 5, 1, 2, '2025-12-10 14:00:00', '2025-12-15 14:00:00', 3),
(4, 7, 3, 3, '2025-12-20 08:00:00', '2025-12-22 08:00:00', 3),
(5, 9, 2, 1, '2026-01-05 11:00:00', '2026-01-12 11:00:00', 3),
(6, 11, 1, 3, '2026-01-18 16:00:00', '2026-01-20 16:00:00', 3),
(7, 13, 3, 2, '2026-02-01 10:00:00', '2026-02-04 10:00:00', 3),
(8, 15, 2, 1, '2026-02-15 13:00:00', '2026-02-17 13:00:00', 3),
(1, 2, 1, 3, '2026-03-01 10:00:00', '2026-03-05 10:00:00', 3),
(2, 4, 3, 2, '2026-03-10 14:00:00', '2026-03-12 14:00:00', 3),
(3, 6, 2, 1, '2026-03-20 09:00:00', '2026-03-27 09:00:00', 2),
(4, 10, 3, 3, '2026-04-01 10:00:00', '2026-04-03 10:00:00', 1);

INSERT INTO car.locacao (idReserva, idCliente, idVeiculo, idFilialRetirada, dtRetirada, kmRetirada, idFilialDevolucao, dtDevolucao, kmDevolucao, valorDiaria, taxas) VALUES
(1, 1, 1, 1, '2025-11-25 10:00:00', 10000, 1, '2025-11-28 10:30:00', 10350, 50.00, 15.00),
(2, 2, 3, 2, '2025-12-01 09:00:00', 20500, 3, '2025-12-05 15:00:00', 21100, 50.00, 10.00), 
(3, 3, 5, 1, '2025-12-10 14:00:00', 5000, 2, '2025-12-15 14:00:00', 5700, 75.50, 20.00),
(4, 4, 7, 3, '2025-12-20 08:00:00', 15000, 3, '2025-12-22 08:00:00', 15150, 75.50, 0.00),
(5, 5, 9, 2, '2026-01-05 11:00:00', 8000, 1, '2026-01-12 11:00:00', 9200, 95.00, 30.00),
(6, 6, 11, 1, '2026-01-18 16:00:00', 3000, 3, '2026-01-20 15:00:00', 3300, 95.00, 15.00),
(7, 7, 13, 3, '2026-02-01 10:00:00', 1200, 2, '2026-02-04 10:00:00', 1500, 150.00, 50.00),
(8, 8, 15, 2, '2026-02-15 13:00:00', 7500, 1, '2026-02-17 13:00:00', 7800, 150.00, 25.00),
(9, 1, 2, 1, '2026-03-01 10:00:00', 6000, 3, '2026-03-05 10:00:00', 6800, 50.00, 10.00),
(10, 2, 4, 3, '2026-03-10 14:00:00', 18000, 2, '2026-03-12 14:00:00', 18400, 50.00, 0.00);

INSERT INTO car.funcionario (idFilial, nome, cpf, email) VALUES
(1, 'Pedro Lima', '90123456789', 'pedro.lima@car.com'),
(2, 'Mariana Gomes', '01234567890', 'mariana.gomes@car.com'),
(2, 'Ricardo Alves', '12345678901', 'ricardo.a@car.com'),
(3, 'Juliana Castro', '23456789012', 'juliana.c@car.com'); 