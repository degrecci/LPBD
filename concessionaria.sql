CREATE SCHEMA IF NOT EXISTS CONCESSIONARIA;

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
  CONSTRAINT Carro_pkey PRIMARY KEY (cd_carro,valor)
);
CREATE TABLE IF NOT EXISTS Cliente
(
  cd_cliente SERIAL,
  nome VARCHAR(12) NOT NULL,
  sobrenome VARCHAR(20),
  dt_nasc DATE,
  sexo CHAR(1) NOT NULL,
  cpf CHAR(11) NOT NULL,
  fone VARCHAR(13),
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
  vend_dt_nasc DATE,
  vend_dt_admissao DATE,
  vend_fone VARCHAR(13),
  CONSTRAINT Vendedor_pkey PRIMARY KEY (cd_vendedor)
);
CREATE TABLE IF NOT EXISTS Loja
(

  cd_loja serial,
  lj_nome VARCHAR(12) NOT NULL,
  lj_cnpj CHAR(14) NOT NULL,
  lj_cep CHAR(8),
  lj_fone VARCHAR(13),
  CONSTRAINT Loja_pkey PRIMARY KEY (cd_loja)

);
CREATE TABLE IF NOT EXISTS  Endereco
(
  cd_endereco SERIAL,
  rua VARCHAR(20) NOT NULL,
  numero VARCHAR(5) NOT NULL, /* Coloquei em varchar porque tem nºs como 17-A e 17-B */
  complemento VARCHAR(20) NOT NULL,
  bairro VARCHAR(12) NOT NULL,
  cidade VARCHAR(12) NOT NULL,
  estado VARCHAR(10) NOT NULL,
  naturalidade VARCHAR(12) NOT NULL,
  vendedor_fk CHAR(6) NOT NULL REFERENCES Vendedor(cd_vendedor)ON UPDATE CASCADE,
  cliente_fk CHAR(6) NOT NULL REFERENCES Cliente(cd_cliente)ON UPDATE CASCADE,
  CONSTRAINT Endereco_pkey PRIMARY KEY (cd_endereco)
);
CREATE TABLE IF NOT EXISTS Venda
(
  cd_venda CHAR(6) NOT NULL UNIQUE,
  valor_fk REAL NOT NULL,
  carro_fk SERIAL,
  venda_data DATE NOT NULL,
  Loja_fk serial REFERENCES Loja (cd_loja)ON UPDATE CASCADE
  FOREIGN KEY (carro_fk,valor_fk) REFERENCES Carro(cd_carro,valor)ON UPDATE CASCADE,
  cliente_fk CHAR(6) NOT NULL REFERENCES Cliente(cd_cliente)ON UPDATE CASCADE,
  vendedor_fk CHAR(6) NOT NULL REFERENCES Vendedor(cd_vendedor)ON UPDATE CASCADE,
  CONSTRAINT Venda_pkey PRIMARY KEY (cd_venda)
);
