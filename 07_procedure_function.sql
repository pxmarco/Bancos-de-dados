USE car;

-- Configurações para permitir criação de procedures e functions
SET GLOBAL log_bin_trust_function_creators = 1;


-- FUNCTION: calcular o valor da multa por atraso na devolução.
DELIMITER //
CREATE FUNCTION calcular_multa_atraso (
    p_diasAtraso INT,
    p_valorDiaria DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_multa DECIMAL(10, 2);
    IF p_diasAtraso > 0 THEN
        SET v_multa = p_diasAtraso * (p_valorDiaria * 0.50);
    ELSE
        SET v_multa = 0.00;
    END IF;
    RETURN v_multa;
END //
DELIMITER ;


-- PROCEDURE: processar a devolução de um veículo (calculando multa, atualizando a locação, reserva e o status do veículo.
DELIMITER //
CREATE PROCEDURE registrar_devolucao (
    IN p_idLocacao INT,
    IN p_dtDevolucao DATETIME,
    IN p_kmDevolucao INT
)
BEGIN
    DECLARE v_dtFimPrev DATETIME;
    DECLARE v_valorDiaria DECIMAL(10, 2);
    DECLARE v_multaBase DECIMAL(10, 2);
    DECLARE v_diasAtraso INT;
    DECLARE v_idVeiculo INT;
    DECLARE v_taxasExistentes DECIMAL(10, 2);

    -- 1. Coleta dados necessários da Locação e Reserva
    SELECT
        B.dtFimPrev,
        A.valorDiaria,
        A.idVeiculo,
        A.taxas
    INTO
        v_dtFimPrev,
        v_valorDiaria,
        v_idVeiculo,
        v_taxasExistentes
    FROM car.locacao A
    INNER JOIN car.reserva B ON A.idReserva = B.idReserva
    WHERE A.idLocacao = p_idLocacao;

    -- 2. Calcula dias de atraso
    SET v_diasAtraso = DATEDIFF(p_dtDevolucao, v_dtFimPrev);

    -- 3. Garante que dias de atraso não seja negativo
    IF v_diasAtraso < 0 THEN
        SET v_diasAtraso = 0;
    END IF;

    -- 4. Calcula a multa (usa a FUNCTION)
    SET v_multaBase = calcular_multa_atraso(v_diasAtraso, v_valorDiaria);

    -- 5. Calcula o valor final simples
    UPDATE locacao
    SET dtDevolucao = p_dtDevolucao,
        kmDevolucao = p_kmDevolucao,
        multa = v_multaBase,
        valorFinal = valorFinal + v_multaBase
    WHERE idLocacao = p_idLocacao;

    -- 6. Atualiza o status do VEICULO para "Disponível"
    UPDATE veiculo
    SET statusVeiculo = 1
    WHERE idVeiculo = v_idVeiculo;
END //
DELIMITER ;