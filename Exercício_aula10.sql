CREATE DATABASE Gestao_Vendas_2;

USE Gestao_Vendas_2;

CREATE TABLE Cliente (
cliente_id INT PRIMARY KEY,
nome VARCHAR(100),
cpf CHAR(11),
email VARCHAR(100),
telefone VARCHAR(15)
);

CREATE TABLE Produto (
produto_id INT PRIMARY KEY,
nome VARCHAR(100),
preco DECIMAL(10,2),
estoque INT
);

CREATE TABLE Vendedor (
vendedor_id INT PRIMARY KEY,
nome VARCHAR(100),
email VARCHAR(100),
salario DECIMAL(10,2)
);

CREATE TABLE Venda (
venda_id INT PRIMARY KEY,
cliente_id INT,
vendedor_id INT,
data_venda DATE,
total DECIMAL(10,2),
FOREIGN KEY (cliente_id) REFERENCES
Cliente(cliente_id),
FOREIGN KEY (vendedor_id) REFERENCES
Vendedor(vendedor_id)
);

CREATE TABLE ItemVenda (
item_id INT PRIMARY KEY,
venda_id INT,
produto_id INT,
quantidade INT,
preco_unitario DECIMAL(10,2),
FOREIGN KEY (venda_id) REFERENCES
Venda(venda_id),
FOREIGN KEY (produto_id) REFERENCES
Produto(produto_id)
);


INSERT INTO Cliente VALUES
(1, 'Bianca Caroline', '11122233344', 'bianca@email.com', '11988880001'),
(2, 'Bruno Milani', '55566677788', 'bruno@email.com', '11988880002'),
(3, 'Helena Pondian', '99900011122', 'helena@email.com', '11988880003');

INSERT INTO Produto VALUES
(1, 'Luminária de Mesa LED', 89.90, 10),
(2, 'Tomada Inteligente Wi-Fi', 79.99, 15),
(3, 'Organizador de Cabos', 29.90, 50),
(4, 'Mesa de Jantar 6 Cadeiras', 1490.50, 2),
(5, 'Micro-ondas 30L', 499.90, 8),
(6, 'Cama Box Casal', 1290.00, 6);

INSERT INTO Vendedor VALUES
(1, 'Guilherme da Rocha', 'guilherme@email.com', 3200.00),
(3, 'João Brazuna', 'joao@email.com', 3000.00),
(5, 'Maria Luiza', 'maria@email.com', 3500.00);

INSERT INTO Venda VALUES
(1, 1, 3, '2024-04-10', 169.89),     
(2, 2, 1, '2025-04-11', 119.80),      
(3, 3, 5, '2024-04-12', 1490.50);     

INSERT INTO ItemVenda VALUES
(1, 1, 1, 1, 89.90),    
(2, 1, 2, 1, 79.99),    
(3, 2, 1, 1, 89.90),    
(4, 2, 3, 1, 29.90),    
(5, 3, 4, 1, 1490.50);  


-- 1 TODOS FUNCIONÁRIOS (procedure)
DELIMITER $$
CREATE PROCEDURE funcionarios()
BEGIN
	SELECT * FROM vendedor;
END $$
DELIMITER ;

CALL funcionarios();


-- 2 SALÁRIO ANUAL (function)
DELIMITER $$
CREATE FUNCTION calc_salarioanual(id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE salarioanual DECIMAL(10,2);
	SET salarioanual =(SELECT (salario * 12) FROM vendedor WHERE id = vendedor_id);
	RETURN salarioanual;
END $$
DELIMITER ;

SELECT calc_salarioanual(1);
SELECT calc_salarioanual(3);
SELECT calc_salarioanual(5);


-- 3 INSERE DADOS (procedure)
DELIMITER $$
CREATE PROCEDURE inserir_prod(
	id INT,
	nome VARCHAR(100),
	preco DECIMAL(10,2),
	qtd INT
)
BEGIN
	INSERT INTO produto (produto_id, nome, preco, estoque)
    VALUES (id, nome, preco, qtd);
END $$
DELIMITER ;

CALL inserir_prod(7, 'Geladeira', 3200.00, 4);


-- 4 LISTA FUNCIONÁRIOS E SALÁRIOS (views)
CREATE VIEW VW_vendedor AS 
	SELECT 	nome, salario
    FROM vendedor
    