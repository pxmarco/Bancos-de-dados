USE car;

-- INNER JOIN: Consulta para mostrar a lista de todas as locações realizadas, filtrando apenas as associações essenciais.
SELECT
    A.idLocacao,
    B.nome,
    C.placa,
    C.modelo,
    D.nome
FROM car.locacao A
INNER JOIN car.cliente B ON A.idCliente = B.idCliente
INNER JOIN car.veiculo C ON A.idVeiculo = C.idVeiculo
INNER JOIN car.filial D ON A.idFilialRetirada = D.idFilial;


-- LEFT JOIN: Consulta para listar todos os veículos e seu último histórico de locação (mesmo que não tenha).
SELECT
    A.placa,
    A.marca,
    A.modelo,
    B.dtRetirada,
    B.dtDevolucao
FROM car.veiculo A
LEFT JOIN car.locacao B ON A.idVeiculo = B.idVeiculo;


-- RIGHT JOIN: Consulta para listar todos as filiais e os veículos associadas a elas (mesmo que não tenha).
SELECT
    B.nome,
    A.idVeiculo
FROM car.veiculo A
RIGHT JOIN car.filial B ON A.idFilial = B.idFilial;


-- SUM E GROUP BY: Calcular o valor final gerado pelas locações, agrupada por mês/ano e pela filial de retirada.
SELECT
    B.nome AS Filial,
    DATE_FORMAT(A.dtRetirada, '%Y/%m') AS AnoMes,
    SUM(A.valorFinal) AS ValorFinal
FROM car.locacao A
INNER JOIN car.filial B ON A.idFilialRetirada = B.idFilial
GROUP BY nome, dtRetirada;


-- MAX/MIN E GROUP BY: Consultar o maior valor de diária e a menor quilometragem, por categoria.
SELECT
    A.nome AS Categoria,
    MAX(A.valorDiariaPadrao) AS MaiorDiaria,
    MIN(C.kmRetirada) AS MenorKM
FROM car.categoria A
LEFT JOIN car.veiculo B ON A.idCategoria = B.idCategoria
LEFT JOIN car.locacao C ON B.idVeiculo = C.idVeiculo
GROUP BY A.nome;


-- COUNT E GROUP BY: Consultar quantas locações foram feitas por categoria.
SELECT
    C.nome AS Categoria,
    COUNT(A.idLocacao) AS TotalLocacoes
FROM car.locacao A
INNER JOIN car.veiculo B ON A.idVeiculo = B.idVeiculo
INNER JOIN car.categoria C ON B.idCategoria = C.idCategoria
GROUP BY C.nome;


-- CASE: Classificar cada o status da devolução da locação, criando uma coluna nova para mostrar esse resultado.
SELECT
    A.idLocacao,
    B.dtFimPrev,
    A.dtDevolucao,
    CASE
        -- Se a data de devolução ainda é NULL, a locação está em andamento.
        WHEN A.dtDevolucao IS NULL THEN 'Pendente'
        -- Se a data de devolução é posterior à data prevista na reserva, houve atraso.
        WHEN A.dtDevolucao > B.dtFimPrev THEN 'Com Atraso'
        -- Caso contrário, foi no prazo ou antes.
        ELSE 'No Prazo'
    END AS StatusAtraso
FROM car.locacao A
INNER JOIN car.reserva B ON A.idReserva = B.idReserva;


-- Subconsulta: Identificar os 3 clientes que mais gastaram em locações.
SELECT 
    A.nome,
    TotalGasto
FROM car.cliente A
INNER JOIN
    (SELECT idCliente,
    SUM(valorFinal) AS TotalGasto
        FROM car.locacao
        GROUP BY idCliente
        LIMIT 3
    ) AS TopClientes ON A.idCliente = TopClientes.idCliente
ORDER BY TotalGasto DESC;


-- -------------- CONSULTAS DE VALIDAÇÃO DE PROCEDURES, FUNCTIONS E VIEWS --------------

-- Cálculo da FUNCTION isolada (calcular_multa_atraso).
SELECT calcular_multa_atraso(2, 100.00) AS MultaCalculada;

-- Locação ANTES da devolução (Locação ID 10).
SELECT A.idLocacao, B.dtFimPrev AS PrevisaoDevolucao, A.dtDevolucao, A.kmDevolucao, A.multa, A.valorDiaria, A.taxas, A.valorFinal
FROM car.locacao A INNER JOIN car.reserva B ON A.idReserva = B.idReserva
WHERE A.idLocacao = 10;

-- PROCEDURE: Registra devolução da Locação ID 10 com ATRASO.
CALL registrar_devolucao(10, '2026-03-15 14:00:00', 19000);

-- Locação DEPOIS da devolução (Locação ID 10).
SELECT A.idLocacao, 
B.dtFimPrev AS PrevisaoDevolucao, 
A.dtDevolucao, 
A.kmDevolucao, 
A.multa, 
A.valorDiaria, 
A.taxas, 
A.valorFinal
FROM car.locacao A 
INNER JOIN car.reserva B ON A.idReserva = B.idReserva
WHERE A.idLocacao = 10;

-- VIEW vw_faturamento_mensal
SELECT * FROM vw_faturamento_mensal
WHERE Mes = '2025-12' AND Filial = 'Locacion Campinas';

-- VIEW vw_utilizacao_frota
SELECT * FROM vw_utilizacao_frota;