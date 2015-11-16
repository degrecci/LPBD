/*CREATE DATABASE CONCESSIONARIA;
CREATE USER gerente with PASSWORD 'senha';
GRANT ALL PRIVILEGES ON CONCESSIONARIA TO gerente;
*/

CREATE TABLE IF NOT EXISTS Loja
(
  cd_loja INT NOT NULL UNIQUE,
  lj_nome VARCHAR(20) NOT NULL,
  lj_cnpj CHAR(14) NOT NULL,
  lj_fone INT,
  lj_cep INT,
  lj_nr INT,
  CONSTRAINT Loja_pkey PRIMARY KEY (cd_loja)
);
CREATE TABLE IF NOT EXISTS Carro
(
  cd_carro SERIAL unique NOT NULL,
  marca VARCHAR(20) NOT NULL,
  modelo VARCHAR(20) NOT NULL,
  valor REAL NOT NULL,
  cor VARCHAR(10),
  ano CHAR(4) NOT NULL,
  estado VARCHAR (9) NOT NULL,
  chassi VARCHAR (18) NOT NULL,
  Loja_fk serial REFERENCES Loja (cd_loja) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT Carro_pkey PRIMARY KEY (cd_carro)
);
CREATE TABLE IF NOT EXISTS Cliente
(
  cd_cliente SERIAL,
  nome VARCHAR(12) NOT NULL,
  sobrenome VARCHAR(20),
  nasc DATE,
  sexo CHAR(1) NOT NULL,
  cpf CHAR(12) NOT NULL,
  fone VARCHAR(13),
  cep INT not null,
  nr INT,
  CONSTRAINT cd_cliente_pkey PRIMARY KEY (cd_cliente)
);
CREATE TABLE IF NOT EXISTS  Vendedor
(
  cd_vendedor SERIAL,
  vend_nome VARCHAR(12) NOT NULL,
  vend_sobrenome VARCHAR (20),
  vend_sexo CHAR(1) NOT NULL,
  vend_salario REAL NOT NULL,
  vend_vendidos INT default 0,
  vend_admissao DATE,
  Loja_fk serial REFERENCES Loja (cd_loja) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT Vendedor_pkey PRIMARY KEY (cd_vendedor)
);

CREATE TABLE IF NOT EXISTS Venda
(
  cd_venda serial NOT NULL ,
  venda_data DATE NOT NULL,
  Loja_fk serial REFERENCES Loja (cd_loja)ON UPDATE CASCADE,
  carro_fk serial REFERENCES Carro (cd_carro) ON UPDATE CASCADE on DELETE CASCADE,
  cliente_fk INT NOT NULL REFERENCES Cliente(cd_cliente)ON UPDATE CASCADE on DELETE CASCADE,
  vendedor_fk INT NOT NULL REFERENCES Vendedor(cd_vendedor)ON UPDATE CASCADE on DELETE CASCADE,
  CONSTRAINT Venda_pkey PRIMARY KEY (cd_venda)
);

CREATE VIEW MELHOR_VENDEDOR AS (
select
	vend_nome || vend_sobrenome as NOME,
	vend_salario as SALARIO,
	vend_vendidos as Quantidade
FROM Vendedor
ORDER BY vend_vendidos DESC limit 1
);



CREATE OR REPLACE FUNCTION VENDEU() RETURNS TRIGGER AS $VENDAS$
BEGIN
	DELETE FROM CARRO
	WHERE cd_carro = (
		SELECT carro_fk
		FROM Venda
		ORDER BY cd_venda DESC
		limit (1)
	); return new;
	END;
$VENDAS$ LANGUAGE plpgsql;


CREATE TRIGGER VENDAS AFTER INSERT ON Venda
FOR EACH ROW EXECUTE PROCEDURE VENDEU();


CREATE OR REPLACE FUNCTION VENDEU2() RETURNS TRIGGER AS $VENDAS2$
BEGIN
	UPDATE Vendedor
	SET vend_vendidos = vend_vendidos + 1
	WHERE cd_vendedor = (
		SELECT vendedor_fk
		FROM Venda
		ORDER BY cd_venda DESC
		LIMIT (1)
	);return new2;
END;
$VENDAS2$ LANGUAGE plpgsql;


CREATE TRIGGER VENDAS2 AFTER INSERT ON Venda
FOR EACH ROW EXECUTE PROCEDURE VENDEU2();




INSERT INTO Loja (cd_loja,lj_nome,lj_cnpj,lj_fone,lj_cep,lj_nr)
VALUES (13,'Pedro Cunha','43391124000158',1932569875,13054879,13);
INSERT INTO Loja (cd_loja,lj_nome,lj_cnpj,lj_fone,lj_cep,lj_nr)
VALUES (55,'Derivada','43684524000158',1933659874,13068749,68);
INSERT INTO Loja (cd_loja,lj_nome,lj_cnpj,lj_fone,lj_cep,lj_nr)
VALUES (01,'Francisco Mata','98543224000158',1530259846,23604987,10025);
INSERT INTO Loja (cd_loja,lj_nome,lj_cnpj,lj_fone,lj_cep,lj_nr)
VALUES (07,'Associassoes','98562424000158',1831659832,10259870,25);
INSERT INTO Loja (cd_loja,lj_nome,lj_cnpj,lj_fone,lj_cep,lj_nr)
VALUES (99,'Fatamota','98563214000158',1132658745,13000548,444);

INSERT INTO Carro (marca,modelo,valor,cor,ano,estado,chassi,Loja_fk)
VALUES ('CHEVROLET','CORSA',32.000,'PRETO',2012,'SEMI-NOVO','9Bc485038271696669',13);
INSERT INTO Carro (marca,modelo,valor,cor,ano,estado,chassi,Loja_fk)
VALUES ('CHEVROLET','ONIX',38.000,'PRATA',2014,'NOVO','9Bc48503821694867',55);
INSERT INTO Carro (marca,modelo,valor,cor,ano,estado,chassi,Loja_fk)
VALUES ('FIAT','PALIO',22.000,'PRETO',2010,'USADO','9BF48503821694567',99);
INSERT INTO Carro (marca,modelo,valor,cor,ano,estado,chassi,Loja_fk)
VALUES ('FIAT','STRADA',42.000,'PRATA',2014,'SEMI-NOVO','9BF48503821694555',13);
INSERT INTO Carro (marca,modelo,valor,cor,ano,estado,chassi,Loja_fk)
VALUES ('FORD','FOCUS',46.000,'VERMELHO',2005,'USADO','9BF48503821694557',13);
INSERT INTO Carro (marca,modelo,valor,cor,ano,estado,chassi,Loja_fk)
VALUES ('FORD','FUSION',97.000,'PRETO',2015,'NOVO','9BF48503821694568',01);
INSERT INTO Carro (marca,modelo,valor,cor,ano,estado,chassi,Loja_fk)
VALUES ('VOLKSWAGEN','FUSCA',4.000,'BRANCO',1976,'USADO','9BV48503821694562',55);
INSERT INTO Carro (marca,modelo,valor,cor,ano,estado,chassi,Loja_fk)
VALUES ('VOLKSVAGEN','KOMBI',26.000,'AZUL-BEBE',2001,'USADO','9BV48503821694561',01);
INSERT INTO Carro (marca,modelo,valor,cor,ano,estado,chassi,Loja_fk)
VALUES ('BMW','118i',87.000,'PRETO',2011,'SEMI-NOVO','9BB48503821659751',07);
INSERT INTO Carro (marca,modelo,valor,cor,ano,estado,chassi,Loja_fk)
VALUES ('MITSUBISHI','ECLIPSE',150.00,'PRETO',2015,'NOVO','9BM48503826482467',07);

INSERT INTO Vendedor (vend_nome,vend_sobrenome,vend_sexo,vend_salario,vend_vendidos,vend_admissao,Loja_fk)
VALUES ('Juca','Neves Monteiro','M',2300,5,'04-05-2010',13);
INSERT INTO Vendedor (vend_nome,vend_sobrenome,vend_sexo,vend_salario,vend_vendidos,vend_admissao,Loja_fk)
VALUES ('Lucas','Silva e Silva','M',2000,1,'18-07-2013',07);
INSERT INTO Vendedor (vend_nome,vend_sobrenome,vend_sexo,vend_salario,vend_vendidos,vend_admissao,Loja_fk)
VALUES ('Mario','Carneiro Pedregulho','M',2200,2,'28-01-2011',55);
INSERT INTO Vendedor (vend_nome,vend_sobrenome,vend_sexo,vend_salario,vend_vendidos,vend_admissao,Loja_fk)
VALUES ('Marina','Chaves Bim','F',3400,16,'24-12-2012',07);
INSERT INTO Vendedor (vend_nome,vend_sobrenome,vend_sexo,vend_salario,vend_vendidos,vend_admissao,Loja_fk)
VALUES ('Cacilda','Flavia Moreno','F',1400,0,'28-10-2015',99);

INSERT INTO Cliente(nome,sobrenome,nasc,sexo,cpf,fone,cep,nr)
VALUES ('Claudio','Gilberto Santos','17-09-1990','m',35498769846,19564688,357098504,78);
INSERT INTO Cliente(nome,sobrenome,nasc,sexo,cpf,fone,cep,nr)
VALUES ('Maria','Hortela Carla Milda','21-04-1981','f',36597452146,1923356548,13055698,55);
INSERT INTO Cliente(nome,sobrenome,nasc,sexo,cpf,fone,cep,nr)
VALUES ('Amelia','Gilba Junk','17-09-1970','f',32698564875,1999995745,65325698,258);
INSERT INTO Cliente(nome,sobrenome,nasc,sexo,cpf,fone,cep,nr)
VALUES ('Claudia','Harrison Ford','17-09-1984','f',64573820956,1132699658,65874512,666);
INSERT INTO Cliente(nome,sobrenome,nasc,sexo,cpf,fone,cep,nr)
VALUES ('Francisca','Helena Marques','17-09-1994','f',84569530548,1398854682,245987524,01);
INSERT INTO Cliente(nome,sobrenome,nasc,sexo,cpf,fone,cep,nr)
VALUES ('Joaquim,','Junior Filho Neto','17-09-19','m',956832609886,14659896,34678465,678);
INSERT INTO Cliente(nome,sobrenome,nasc,sexo,cpf,fone,cep,nr)
VALUES ('Augusto','Garoto Fru','17-09-1990','m',41387456993,19986593,16798740,77789);
INSERT INTO Cliente(nome,sobrenome,nasc,sexo,cpf,fone,cep,nr)
VALUES ('Victor','Silva Peres','17-09-1990','m',21695303669,1132659974,14659896,6458);


SELECT marca, modelo, ano, cor, estado, valor
FROM carro
WHERE cd_carro = 7;

SELECT vend_nome, vend_salario
FROM Vendedor
ORDER BY vend_salario DESC;

SELECT v.vend_nome, v.vend_sobrenome, v.vend_vendidos, l.lj_nome
FROM Vendedor as v INNER JOIN Loja as l on l.cd_loja = v.cd_vendedor;

/*
INSERT INTO Venda(carro_fk,loja_fk,venda_data,cliente_fk,vendedor_fk)
VALUES (7,13,'22-05-2010',5,5)
INSERT INTO Venda(carro_fk,loja_fk,venda_data,cliente_fk,vendedor_fk)
VALUES (1,55,'06-05-2013',1,2)
INSERT INTO Venda(carro_fk,loja_fk,venda_data,cliente_fk,vendedor_fk)
VALUES (3,01,'05-04-2012',2,1)
INSERT INTO Venda(carro_fk,loja_fk,venda_data,cliente_fk,vendedor_fk)
VALUES (5,07,'25-07-2011',4,3)
INSERT INTO Venda(carro_fk,loja_fk,venda_data,cliente_fk,vendedor_fk)
VALUES (8,99,'30-12-2014',3,4)

*/
