CREATE DATABASE Gestao_Vendas;

use Gestao_Vendas;

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


-- 1 TODOS OS CLIENTES CADASTRADOS
SELECT * FROM cliente;

-- 2 NOMES DOS PRODUTOS EXISTENTES
SELECT nome FROM produto;

-- 3 TODOS OS PRODUTOS COM PREÇO SUPERIOR A 100
SELECT nome FROM produto WHERE preco > 100.00;

-- 4 NOME DOS CLIENTES CADASTRADOS
SELECT nome FROM cliente;

-- 5 TODOS CLIENTES E PRODUTOS CADASTRADOS
SELECT nome FROM cliente UNION SELECT nome FROM produto;

-- 6 QUANTIDADE DE CLIENTES 
SELECT COUNT(*) AS total_cliente FROM cliente;

-- 7 QUANTIDADE DE PRODUTOS
SELECT COUNT(*) AS total_produto FROM produto;

-- 8 QUANTIDADE DE PEDIDOS EM 2024
SELECT COUNT(data_venda) FROM venda WHERE YEAR(data_venda) = 2024;

-- 9 VALOR TOTAL DE VENDAS
SELECT SUM(total) FROM venda;

-- 10 VALOR TOTAL DE VENDAS DO VENDEDOR ID=5
SELECT SUM(total) FROM venda WHERE vendedor_id = 5;

-- 11 PEDIDOS DE UM CLIENTE 
SELECT COUNT(*) FROM venda WHERE cliente_id = (SELECT cliente_id FROM cliente WHERE nome = 'Bianca Caroline');

-- 12 SOMA DAS VENDAS
SELECT SUM(total) FROM venda;

-- 13 SALÁRIOS MAIORES QUE TRÊS MIL
SELECT COUNT(*) FROM vendedor WHERE salario > 3000; 

-- 14 QUANTIDADE DE PRODUTOS COM PREÇO MAIOR QUE 100 
SELECT COUNT(*) FROM itemvenda WHERE preco_unitario > 100;

-- 15 VALOR TOTAL DAS VENDAS DO CLIENTE ID = 2
SELECT SUM(total) FROM venda WHERE cliente_id = 2;

