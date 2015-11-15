CREATE DATABASE CONCESSIONARIA;
CREATE USER gerente with PASSWORD 'senha';
GRANT ALL PRIVILEGES ON CONCESSIONARIA TO gerente;


CREATE TABLE IF NOT EXISTS Loja
(
  cd_loja char(2) NOT NULL UNIQUE,
  lj_nome VARCHAR(12) NOT NULL,
  lj_cnpj CHAR(14) NOT NULL,
  lj_fone INT check (lj_fone <11),
  lj_cep INT check (lj_cep <8) not null,
  lj_nr integer,
  CONSTRAINT Loja_pkey PRIMARY KEY (cd_loja)
);
CREATE TABLE IF NOT EXISTS Carro
(
  cd_carro SERIAL,
  marca VARCHAR(20) NOT NULL,
  modelo VARCHAR(20) NOT NULL,
  valor REAL NOT NULL,
  cor VARCHAR(10),
  ano CHAR(4) NOT NULL,
  estado VARCHAR (9) NOT NULL,
  chassi VARCHAR (17) NOT NULL UNIQUE,
  Loja_fk serial REFERENCES Loja (cd_loja) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT Carro_pkey PRIMARY KEY (cd_carro,valor)
);
CREATE TABLE IF NOT EXISTS Cliente
(
  cd_cliente SERIAL,
  nome VARCHAR(12) NOT NULL,
  sobrenome VARCHAR(20),
  nasc DATE,
  sexo CHAR(1) NOT NULL,
  cpf CHAR(11) NOT NULL,
  fone VARCHAR(13),
  lj_cep INT check (lj_cep <8) not null,
  lj_nr integer,
  CONSTRAINT cd_cliente_pkey PRIMARY KEY (cd_cliente)
);
CREATE TABLE IF NOT EXISTS  Vendedor
(
  cd_vendedor SERIAL,
  vend_nome VARCHAR(12) NOT NULL,
  vend_sobrenome VARCHAR (20),
  vend_sexo CHAR(1) NOT NULL,
  vend_salario REAL NOT NULL,
  vend_comissao REAL NOT NULL,
  vend_vendidos integer default 0,
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
  valor_fk DECIMAL(5,2) not null REFERENCES Carro (valor) ON UPDATE CASCADE on DELETE CASCADE,
  cliente_fk CHAR(6) NOT NULL REFERENCES Cliente(cd_cliente)ON UPDATE CASCADE on DELETE CASCADE,
  vendedor_fk CHAR(6) NOT NULL REFERENCES Vendedor(cd_vendedor)ON UPDATE CASCADE on DELETE CASCADE,
  CONSTRAINT Venda_pkey PRIMARY KEY (cd_venda)
);


INSERT INTO Loja (cd_loja,jl_nome,lj_cnpj,jl_fone,lj_cep,lj_nr)
VALUES (13,'Pedro Cunha','43391124000158',1932569875,13054879,13);
VALUES (55,'Derivada','43684524000158',1933659874,13068749,68);
VALUES (01,'Francisco Mata','98543224000158',1530259846,23604987,10025);
VALUES (07,'Associassoes','98562424000158',1831659832,10259870,25);
VALUES (99,'Fatamota','98563214000158',1132658745,13000548,444);

INSERT INTO Carro (marca,modelo,valor,cor,ano,estado,chassi,Loja_fk)
VALUES ('CHEVROLET','CORSA',32.000,'PRETO',2012,'SEMI-NOVO','9Bc485038271696669',13);
VALUES ('CHEVROLET','ONIX',38.000,'PRATA',2014,'NOVO','9Bc48503821694867',55,);
VALUES ('FIAT','PALIO',22.000,'PRETO',2010,'USADO','9BF48503821694567',99);
VALUES ('FIAT','STRADA',42.000,'PRATA',2014,'SEMI-NOVO','9BF48503821694567',13);
VALUES ('FORD','FOCUS',46.000,'VERMELHO',2005,'USADO','9BF48503821694567',13);
VALUES ('FORD','FUSION',97.000,'PRETO',2015,'NOVO','9BF48503821694567',01);
VALUES ('VOLKSWAGEN','FUSCA',4.000,'BRANCO',1976,'USADO','9BV48503821694567',07);
VALUES ('VOLKSVAGEN','KOMBI',26.000,'AZUL-BEBE',2001,'USADO','9BV48503821694567',01);
VALUES ('BMW','118i',87.000,'PRETO',2011,'SEMI-NOVO','9BB48503821659751',444);
VALUES ('MITSUBISHI','ECLIPSE',150.00,'PRETO',2015,'NOVO','9BM48503826482467'444);

INSERT INTO Vendedor (vend_nome,vend_sobrenome,vend_sexo,vend_salario,vend_vendidos,vend_admissao,vend_fone,Loja_fk)
VALUES ('Juca','Neves Monteiro',"M",2300,5,'04-05-2010',13);
VALUES ('Lucas','Silva e Silva',"M",2000,1,'18-07-2013'07);
VALUES ('Mario','Carneiro Pedregulho',"M",2200,2,'28-01-2011',55);
VALUES ('Marina','Chaves Bim',"F",3400,16,'24-12-2012',444);
VALUES ('Cacilda','Flavia Moreno',"F",1400,2,'28-10-2015',99);

INSERT INTO Cliente(nome,sobrenome,nasc,sexo,cpf,fone)
VALUES ('Claudio','Gilberto Santos','17-09-1990',"m",35498769846,19564688);
VALUES ('Maria','Hortela Carla Milda','21-04-1981',"f",36597452146,1923356548);
VALUES ('Amelia','Gilba Junk','17-09-1970',"f",32698564875,1999995745);
VALUES ('Claudia','Harrison Ford','17-09-1984',"f",64573820956,1132699658);
VALUES ('Francisca','Helena Marques','17-09-1994',"f",84569530548,1398854682);
VALUES ('Joaquim,','Junior Filho Neto','17-09-19',"m",956832609886,14659896);
VALUES ('Augusto','Garoto Fru','17-09-1990',"m",41387456993,19986593);
VALUES ('Victor','Silva Peres','17-09-1990',"m",21695303669,1132659974);


CREATE TRIGGER $VENDAS$ AFTER INSERT ON Venda
FOR EACH ROW EXECUTE PROCEDURE VENDEU();

CREATE FUNCTION VENDEU() RETURNS trigger VENDAS
BEGIN
	DELETE FROM CARRO
	WHERE cd_carro = (
	SELECT carro_fk
	FROM Venda
	ORDER BY cd_venda DESC
	limit 0,1;
	);
END;


$VENDAS$ LANGUAGE plpgsql;
