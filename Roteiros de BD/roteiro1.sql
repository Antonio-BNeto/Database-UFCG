
-- Questão 1:

-- Adicionando atributos que julgo ser essencial para cada tabela

/*
Automovel (
    renavam,
    placa,
    modelo,
    cor,
    dono_automovel 
)

Segurado (
    cpf,
    nome,
    telefone,
    email,
    cep
)

Perito (
    cpf_perito,
    nome_perito,
    telefone_perito,
    email_perito
)

Oficina (
    cnpj_oficina,
    nome_oficina,
    endereco,
    telefone_oficina
)

Seguro (
    id_seguro,
    tipo_seguro,
    renavam_automovel,
    cpf_segurado,
    data_inicio,
    data_fim,
    apolice
)

Sinistro (
    id_sinistro,
    id_seguro,
    renavam_automovel,
    data_ocorrencia,
    local_ocorrencia,
    descricao,
    tipo_sinistro
)

Pericia (
    id_pericia,
    perito,
    oficina,
    seguro,
    data_hora_inicio,
    data_hora_fim,
    conclusão
)

Reparo (
    id_reparo,
    id_seguro
    oficina,
    inicio_reparo,
    fim_reparo,
    valor
)
*/

-- Questão 2

--Criando tabelas com cada atributo previamente defenidos sem o uso de constrains

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
    telefone_oficina text
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
    seguro INTEGER,
    perito VARCHAR(11),
    oficina VARCHAR(14),
    data_hora_inicio TIMESTAMP,
    data_hora_fim TIMESTAMP,
    conclusão TEXT
);

CREATE TABLE Reparo (
    id_reparo INTEGER,
    id_seguro INTEGER,
    oficina VARCHAR(14),
    inicio_reparo DATE,
    fim_reparo DATE,
    valor NUMERIC
);

-- Questão 3

--Definindo as chaves primárias das tabelas e adicionando as 
--constrains através do ALTER TABLE 

ALTER TABLE Automovel ADD PRIMARY KEY (renavam);
ALTER TABLE Segurado ADD PRIMARY KEY (cpf_segurado);
ALTER TABLE Perito ADD PRIMARY KEY (cpf_perito);
ALTER TABLE Oficina ADD PRIMARY KEY (cnpj_oficina);
ALTER TABLE Seguro ADD PRIMARY KEY (id_seguro);
ALTER TABLE Sinistro ADD PRIMARY KEY (id_sinistro);
ALTER TABLE Pericia ADD PRIMARY KEY (id_pericia);
ALTER TABLE Reparo ADD PRIMARY KEY (id_reparo);

-- Questão 4

--Definindo chaves estrangeiras

ALTER TABLE Automovel ADD FOREIGN KEY (cpf_dono) REFERENCES Segurado (cpf_segurado);

ALTER TABLE Seguro ADD FOREIGN KEY (renavam_automovel) REFERENCES Automovel (renavam);
ALTER TABLE Seguro ADD FOREIGN KEY (cpf_segurado) REFERENCES Segurado (cpf_segurado);

ALTER TABLE Sinistro ADD FOREIGN KEY (id_seguro) REFERENCES Seguro (id_seguro);

ALTER TABLE Pericia ADD FOREIGN KEY (perito) REFERENCES Perito (cpf_perito);
--->ALTER TABLE Pericia ADD FOREIGN KEY (seguro) REFERENCES Seguro (id_seguro);
ALTER TABLE Pericia ADD FOREIGN KEY (oficina) REFERENCES Oficina (cnpj_oficina);

ALTER TABLE Reparo ADD FOREIGN KEY (id_seguro) REFERENCES Seguro (id_seguro);
ALTER TABLE Reparo ADD FOREIGN KEY (oficina) REFERENCES oficina (cnpj_oficina);

--Questão 5

ALTER TABLE Automovel ALTER COLUMN placa SET NOT NULL;
ALTER TABLE Automovel ALTER COLUMN modelo SET NOT NULL;
ALTER TABLE Automovel ALTER COLUMN cpf_dono SET NOT NULL;

ALTER TABLE Segurado ALTER COLUMN nome_segurado SET NOT NULL;
ALTER TABLE Segurado ALTER COLUMN email_segurado SET NOT NULL;
-- talvez coloque o telefone do segurado
ALTER TABLE Segurado ALTER COLUMN cep_segurado SET NOT NULL;

ALTER TABLE Perito ALTER COLUMN nome_perito SET NOT NULL;
ALTER TABLE Perito ALTER COLUMN telefone_perito SET NOT NULL;
ALTER TABLE Perito ALTER COLUMN email_perito SET NOT NULL;

ALTER TABLE Oficina ALTER COLUMN nome_oficina SET NOT NULL;
ALTER TABLE Oficina ALTER COLUMN endereco SET NOT NULL;
ALTER TABLE Oficina ALTER COLUMN telefone_oficina SET NOT NULL;

ALTER TABLE Seguro ALTER COLUMN renavam_automovel SET NOT NULL;
ALTER TABLE Seguro ALTER COLUMN cpf_segurado SET NOT NULL;
ALTER TABLE Seguro ALTER COLUMN apolice SET NOT NULL;


-- Questão 6
DROP TABLE Pericia;
DROP TABLE PERITO;
DROP TABLE REPARO;
DROP TABLE Sinistro;
DROP TABLE Oficina;
DROP TABLE SEGURO;
DROP TABLE Automovel;
DROP TABLE Segurado;

--Questão 7

--Questão 8

-- Questão 9
DROP TABLE Pericia;
DROP TABLE PERITO;
DROP TABLE REPARO;
DROP TABLE Sinistro;
DROP TABLE Oficina;
DROP TABLE SEGURO;
DROP TABLE Automovel;
DROP TABLE Segurado;

--Questão 10