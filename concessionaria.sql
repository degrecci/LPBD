CREATE SCHEMA IF NOT EXISTS CONCESSIONARIA;

CREATE TABLE IF NOT EXISTS Carro
(
  cd_carro CHAR(6) NOT NULL,
  valor REAL NOT NULL,
  modelo VARCHAR(20) NOT NULL,
  marca VARCHAR(20) NOT NULL,
  cor VARCHAR(10),
  ano CHAR(4) NOT NULL,
  estado VARCHAR (9) NOT NULL,
  num_chassi VARCHAR (17) NOT NULL,
  CONSTRAINT Carro_pkey PRIMARY KEY (cd_carro,valor)
);
CREATE TABLE IF NOT EXISTS Cliente
(
  cd_cliente CHAR(6) NOT NULL,
  nome VARCHAR(12) NOT NULL,
  sobrenome VARCHAR(20),
  data_nasc DATE,
  sexo CHAR(1) NOT NULL,
  cpf CHAR(11) NOT NULL,
  fone VARCHAR(13),
  CONSTRAINT cd_cliente_pkey PRIMARY KEY (cd_cliente)
);
CREATE TABLE IF NOT EXISTS  Vendedor
(
  cd_vendedor CHAR(6) NOT NULL,
  vend_nome VARCHAR(12) NOT NULL,
  vend_sobrenome VARCHAR (20),
  vend_sexo CHAR(1) NOT NULL,
  salario REAL NOT NULL,
  porc_comissao REAL NOT NULL,
  vend_data_nasc DATE,
  dt_admissao DATE,
  vend_fone VARCHAR(13),
  CONSTRAINT Vendedor_pkey PRIMARY KEY (cd_vendedor)
);
CREATE TABLE IF NOT EXISTS Venda
(
  cd_venda CHAR(6) NOT NULL,
  valor_fk REAL NOT NULL,
  carro_fk char(6) not null,
  data_venda DATE NOT NULL,
  FOREIGN KEY (cd_carro,valor) REFERENCES Carro(cd_carro,valor),
  cliente_fk char(6) NOT NULL REFERENCES Cliente(cd_cliente),
  vendedor_fk char(6) NOT NULL REFERENCES Vendedor(cd_vendedor),
  CONSTRAINT Venda_pkey PRIMARY KEY (cd_venda)
);
