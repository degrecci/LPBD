DROP SCHEMA CONCESSIONARIA;

CREATE SCHEMA IF NOT EXISTS CONCESSIONARIA;

CREATE TABLE IF NOT EXISTS Carro
(
  cd_carro CHAR(6) NOT NULL,
  valor REAL NOT NULL,
  modelo VARCHAR(20) NOT NULL,
  marca VARCHAR(20) NOT NULL,
  cor VARCHAR(10),
  ano INTEGER (4) NOT NULL,
  estado ENUM ('Novo', 'Semi-Novo', 'Usado') NOT NULL,
  num_chassi VARCHAR (17) NOT NULL,
  PRIMARY KEY (cd_carro),
  PRIMARY KEY (valor)
);
CREATE TABLE IF NOT EXISTS Cliente
(
  cd_cliente CHAR(6) NOT NULL,
  nome VARCHAR(12) NOT NULL,
  sobrenome VARCHAR(20),
  data_nasc DATE,
  sexo ENUM ('Masculino', 'Feminino'),
  cpf CHAR(11) NOT NULL,
  fone VARCHAR(13),
  PRIMARY KEY (cd_cliente)
);
CREATE TABLE IF NOT EXISTS  Vendedor
(
  cd_vendedor CHAR(6) NOT NULL,
  vend_nome VARCHAR(12) NOT NULL,
  vend_sobrenome VARCHAR (20),
  vend_sexo ENUM ('Masculino', 'Feminino'),
  salario REAL NOT NULL,
  porc_comissao REAL NOT NULL,
  vend_data_nasc DATE,
  dt_admissao DATE,
  vend_fone VARCHAR(13),
  PRIMARY KEY (cd_empregado)
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
