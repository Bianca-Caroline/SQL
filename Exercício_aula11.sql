CREATE DATABASE controle_estoque;

use controle_estoque;

-- TABELAS
CREATE TABLE produtos (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100),
quantidade INT ); 

CREATE TABLE log_estoque (
id_log INT AUTO_INCREMENT PRIMARY KEY,
id_produto INT,
quantidade_antiga INT,
quantidade_nova INT,
data_alteracao DATETIME
);


-- DADOS 
INSERT INTO produtos (id, nome, quantidade) VALUES
(1, 'Luminária de Mesa LED', 10),
(2, 'Tomada Inteligente Wi-Fi', 15),
(3, 'Organizador de Cabos', 50),
(4, 'Mesa de Jantar 6 Cadeiras', 2),
(5, 'Micro-ondas 30L', 8),
(6, 'Cama Box Casal', 6);

INSERT INTO log_estoque (id_produto, quantidade_antiga, data_alteracao) VALUES
(1, 10, '2025-04-01 14:30:00'), 
(2, 15, '2025-04-02 11:20:00'),   
(3, 50, '2025-04-03 16:45:00'),   
(5, 8,  '2025-04-07 12:00:00'), 
(6, 6,  '2025-04-08 13:50:00'); 
 


-- EXERCÍCIOS
-- 1 AFTER UPDATE (trigger)
DELIMITER // 
CREATE TRIGGER alteracao_qtd
AFTER UPDATE 
ON produtos
FOR EACH ROW 
BEGIN 
INSERT INTO log_estoque (id_produto, quantidade_antigo, quantidade_novo, data_alteracao)
VALUES (OLD.id, OLD.quantidade, NEW.quantidade, NOW());
END // 
DELIMITER ;

-- REGISTRO DE ALTERAÇÃO NA TABELA ESTOQUE
INSERT INTO log_estoque (id_produto, quantidade_antiga, quantidade_nova, data_alteracao) VALUES
(1, 10, 7,  NOW()),       -- venda
(3, 50, 55, NOW());       -- reposição


-- 2 QUANTIDADE ATUAL EM ESTOQUE (function)
DELIMITER //
CREATE FUNCTION get_quantidade_produto(id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE qtd_estq INT;
	SELECT quantidade_nova INTO qtd_estq FROM log_estoque WHERE id = id_produto ORDER BY data_alteracao DESC LIMIT 1;
	RETURN qtd_estq;
END //
DELIMITER ;

SELECT get_quantidade_produto(1);
SELECT get_quantidade_produto(3);


-- 3 ATUALIZAR A QUANTIDADE (procedure)
DELIMITER //
CREATE PROCEDURE atualiza_quantidade(
	IN p_id INT,
	IN p_nova_quantidade INT
)
BEGIN
	UPDATE produtos
    SET quantidade = p_nova_quantidade WHERE id = p_id;
    SELECT 'Produto atualizados com sucesso' AS mensagem;
END //
DELIMITER ;

CALL atualiza_quantidade(1, 12);