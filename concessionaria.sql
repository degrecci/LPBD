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
  PRIMARY KEY (cd_carro,valor)
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
  PRIMARY KEY (cd_cliente)
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
  PRIMARY KEY (cd_vendedor)
);
CREATE TABLE IF NOT EXISTS Venda
(
  cd_venda CHAR(6) NOT NULL,
  valor REAL NOT NULL,
  data_venda DATE NOT NULL,
  cd_carro CHAR(6) NOT NULL,
  cd_cliente CHAR(6) NOT NULL,
  cd_empregado CHAR(6) NOT NULL,
  PRIMARY KEY(cd_venda),
  FOREIGN KEY(cd_carro) REFERENCES Carro(cd_carro),
  FOREIGN KEY(cd_cliente) REFERENCES Cliente(cd_cliente),
  FOREIGN KEY(cd_empregado) REFERENCES Vendedor(cd_vendedor)
);
