-- Questão 1 e 2

--Criando tabelas com cada atributo defenidos sem o uso de constrains

CREATE TABLE Automovel (
    renavam VARCHAR(11),
    placa VARCHAR(7),
    modelo TEXT,
    ano_automovel CHAR(4),
    cor_automovel TEXT,
    cpf_dono VARCHAR(11)
);

CREATE TABLE Segurado(
    cpf_segurado VARCHAR(11),
    nome_segurado TEXT,
    telefone_segurado TEXT,
    email_segurado TEXT,
    cep_segurado VARCHAR(8)
);

CREATE TABLE Perito (
    cpf_perito VARCHAR(11),
    nome_perito TEXT,
    telefone_perito TEXT,
    email_perito TEXT
);

CREATE TABLE Oficina(
    cnpj_oficina VARCHAR(14),
    nome_oficina TEXT,
    endereco TEXT,
    telefone_oficina TEXT
);

CREATE TABLE Seguro (
    id_seguro INTEGER,
    renavam_automovel VARCHAR(11),
    cpf_segurado VARCHAR(11),
    data_inicio DATE,
    data_fim DATE,
    apolice TEXT
);

CREATE TABLE Sinistro (
    id_sinistro INTEGER,
    id_seguro INTEGER,
    renavam_automovel VARCHAR(11),
    data_ocorrencia DATE,
    local_ocorrencia TEXT,
    descricao TEXT,
    tipo_sinistro TEXT
);

CREATE TABLE Pericia (
    id_pericia INTEGER,
    id_seguro INTEGER,
    cpf_perito VARCHAR(11),
    cnpj_oficina VARCHAR(14),
    data_hora_inicio TIMESTAMP,
    data_hora_fim TIMESTAMP,
    conclusao TEXT
);

CREATE TABLE Reparo (
    id_reparo INTEGER,
    id_seguro INTEGER,
    cnpj_oficina VARCHAR(14),
    inicio_reparo DATE,
    fim_reparo DATE,
    valor NUMERIC
);

-- Questão 3

--Definindo as chaves primárias das tabelas

ALTER TABLE Automovel ADD PRIMARY KEY (renavam);
ALTER TABLE Segurado ADD PRIMARY KEY (cpf_segurado);
ALTER TABLE Perito ADD PRIMARY KEY (cpf_perito);
ALTER TABLE Oficina ADD PRIMARY KEY (cnpj_oficina);
ALTER TABLE Seguro ADD PRIMARY KEY (id_seguro);
ALTER TABLE Sinistro ADD PRIMARY KEY (id_sinistro);
ALTER TABLE Pericia ADD PRIMARY KEY (id_pericia);
ALTER TABLE Reparo ADD PRIMARY KEY (id_reparo);

-- Questão 4

--Definindo chaves estrangeiras das tabelas

ALTER TABLE Automovel ADD FOREIGN KEY (cpf_dono) REFERENCES Segurado (cpf_segurado);

ALTER TABLE Seguro ADD FOREIGN KEY (renavam_automovel) REFERENCES Automovel (renavam);
ALTER TABLE Seguro ADD FOREIGN KEY (cpf_segurado) REFERENCES Segurado (cpf_segurado);

ALTER TABLE Sinistro ADD FOREIGN KEY (id_seguro) REFERENCES Seguro (id_seguro);

ALTER TABLE Pericia ADD FOREIGN KEY (cpf_perito) REFERENCES Perito (cpf_perito);
ALTER TABLE Pericia ADD FOREIGN KEY (id_seguro) REFERENCES Seguro (id_seguro);
ALTER TABLE Pericia ADD FOREIGN KEY (cnpj_oficina) REFERENCES Oficina (cnpj_oficina);

ALTER TABLE Reparo ADD FOREIGN KEY (id_seguro) REFERENCES Seguro (id_seguro);
ALTER TABLE Reparo ADD FOREIGN KEY (cnpj_oficina) REFERENCES oficina (cnpj_oficina);

--Questão 5

-- Definindo quais atributos não podem ser null na tabela

ALTER TABLE Automovel ALTER COLUMN placa SET NOT NULL;
ALTER TABLE Automovel ALTER COLUMN modelo SET NOT NULL;
ALTER TABLE Automovel ALTER COLUMN cpf_dono SET NOT NULL;

ALTER TABLE Segurado ALTER COLUMN nome_segurado SET NOT NULL;
ALTER TABLE Segurado ALTER COLUMN email_segurado SET NOT NULL;
ALTER TABLE Segurado ALTER COLUMN telefone_segurado SET NOT NULL;
ALTER TABLE Segurado ALTER COLUMN cep_segurado SET NOT NULL;

ALTER TABLE Perito ALTER COLUMN nome_perito SET NOT NULL;
ALTER TABLE Perito ALTER COLUMN telefone_perito SET NOT NULL;
ALTER TABLE Perito ALTER COLUMN email_perito SET NOT NULL;

ALTER TABLE Oficina ALTER COLUMN nome_oficina SET NOT NULL;
ALTER TABLE Oficina ALTER COLUMN endereco SET NOT NULL;
ALTER TABLE Oficina ALTER COLUMN telefone_oficina SET NOT NULL;

ALTER TABLE Seguro ALTER COLUMN renavam_automovel SET NOT NULL;
ALTER TABLE Seguro ALTER COLUMN cpf_segurado SET NOT NULL;
ALTER TABLE Seguro ALTER COLUMN data_inicio SET NOT NULL;
ALTER TABLE Seguro ALTER COLUMN data_fim SET NOT NULL;
ALTER TABLE Seguro ALTER COLUMN apolice SET NOT NULL;

ALTER TABLE Sinistro ALTER COLUMN id_seguro SET NOT NULL;
ALTER TABLE Sinistro ALTER COLUMN renavam_automovel SET NOT NULL;
ALTER TABLE Sinistro ALTER COLUMN tipo_sinistro SET NOT NULL;
ALTER TABLE Sinistro ALTER COLUMN data_ocorrencia SET NOT NULL;
ALTER TABLE Sinistro ALTER COLUMN local_ocorrencia SET NOT NULL;

ALTER TABLE Pericia ALTER COLUMN id_seguro SET NOT NULL;
ALTER TABLE Pericia ALTER COLUMN cpf_perito SET NOT NULL;
ALTER TABLE Pericia ALTER COLUMN cnpj_oficina SET NOT NULL;
ALTER TABLE Pericia ALTER COLUMN data_hora_inicio SET NOT NULL;
ALTER TABLE Pericia ALTER COLUMN data_hora_fim SET NOT NULL;
ALTER TABLE Pericia ALTER COLUMN conclusao SET NOT NULL;

ALTER TABLE Reparo ALTER COLUMN id_seguro SET NOT NULL;
ALTER TABLE Reparo ALTER COLUMN cnpj_oficina SET NOT NULL;
ALTER TABLE Reparo ALTER COLUMN inicio_reparo SET NOT NULL;
ALTER TABLE Reparo ALTER COLUMN fim_reparo SET NOT NULL;
ALTER TABLE Reparo ALTER COLUMN valor SET NOT NULL;

-- Questão 6 e 9
DROP TABLE Pericia;
DROP TABLE PERITO;
DROP TABLE REPARO;
DROP TABLE Sinistro;
DROP TABLE Oficina;
DROP TABLE SEGURO;
DROP TABLE Automovel;
DROP TABLE Segurado;

--Questão 7 E 8

/*
CREATE TABLE Automovel (
    renavam_automovel PRIMARY KEY,
    placa NOT NULL,
    modelo NOT NULL,
    ano_automovel,
    cor_automovel,
    cpf_dono NOT NULL,
    FOREIGN KEY (cpf_dono) REFERENCES Segurado (cpf_segurado)
); 

CREATE TABLE Segurado(
    cpf_segurado PRIMARY KEY,
    nome_segurado NOT NULL,
    telefone_segurado NOT NULL,
    email_segurado NOT NULL,
    cep_segurado NOT NULL
);

CREATE TABLE Perito (
    cpf_perito PRIMARY KEY,
    nome_perito NOT NULL,
    telefone_perito NOT NULL,
    email_perito NOT NULL
);

CREATE TABLE Oficina(
    cnpj_oficina PRIMARY KEY,
    nome_oficina NOT NULL,
    endereco NOT NULL,
    telefone_oficina NOT NULL
);

CREATE TABLE Seguro (
    id_seguro PRIMARY KEY,
    renavam_automovel NOT NULL,
    cpf_segurado NOT NULL,
    data_inicio NOT NULL,
    data_fim NOT NULL,
    apolice NOT NULL,
    FOREIGN KEY (cpf_segurado) REFERENCES SEGURADO (cpf_segurado),
    FOREIGN KEY (renavam_automovel) REFERENCES Automovel (renavam_automovel)
);

CREATE TABLE Sinistro (
    id_sinistro PRIMARY KEY,
    id_seguro NOT NULL,
    renavam_automovel NOT NULL,
    data_ocorrencia NOT NULL,
    local_ocorrencia NOT NULL,
    descricao,
    tipo_sinistro NOT NULL,
    FOREIGN KEY (id_seguro) REFERENCES Seguro (id_seguro),
    FOREIGN KEY (renavam_automovel) REFERENCES Automovel (renavam_automovel)
);

CREATE TABLE Pericia (
    id_pericia PRIMARY KEY,
    id_seguro NOT NULL,
    cpf_perito NOT NULL,
    cnpj_oficina NOT NULL,
    data_hora_inicio NOT NULL,
    data_hora_fim NOT NULL,
    conclusao NOT NULL,
    FOREIGN KEY (id_seguro) REFERENCES Seguro (id_seguro),
    FOREIGN KEY (cpf_perito) REFERENCES Perito (cpf_perito),
    FOREIGN KEY (cnpj_oficina) REFERENCES Oficina (cnpj_oficina)
);

CREATE TABLE Reparo (
    id_reparo PRIMARY KEY,
    id_seguro NOT NULL,
    cnpj_oficina NOT NULL,
    renavam_automovel NOT NULL,
    data_inicio_reparo NOT NULL,
    data_fim_reparo NOT NULL, 
    valor NOT NULL
    FOREIGN KEY (id_seguro) REFERENCES Seguro (id_seguro),
    FOREIGN KEY (cnpj_oficina) REFERENCES Oficina (cnpj_oficina),
    FOREIGN KEY (renavam_automovel) REFERENCES Automovel (renavam_automovel)
);
*/

-- Questão 10
