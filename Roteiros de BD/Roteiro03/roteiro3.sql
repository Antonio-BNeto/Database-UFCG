CREATE TABLE farmacias (
    endereco_farmacia TEXT PRIMARY KEY,
    filial BOOLEAN NOT NULL,
    estado_loc_farmacia TEXT NOT NULL,
    CREATE TYPE estado_loc_farmacia AS ENUM ('Maranhão', 'Piauí', 'Ceará', 'Rio Grande do Norte', 'Paraíba', 'Pernambuco', 'Alagoas', 'Sergipe',  'Bahia')
);

CREATE TABLE funcionarios (
    cpf_funcionario CHAR(11) PRIMARY KEY,
    id_farmacia_tarabalha INTEGER NOT NULL,
    funcao_funcinario TEXT,
    salario INTEGER,
    FOREIGN KEY (id_farmacia_tarabalha) REFERENCES farmacia (id_farmacia),
    CREATE TYPE funcao_funcionario AS ENUM ('farmacêutico', 'vendedor', 'entregador', 'caixa', 'administrador')
);

CREATE TABLE medicamentos (
    id_medicamento INTEGER,
    nome_medicamento TEXT,
    venda_exclusiva BOOLEAN
);

CREATE TABLE vendas (
    id_venda INTEGER,
    cpf_funcionario CHAR(11),
    endereco_cliente TEXT NOT NULL
);

CREATE TABLE entregas (

    endereco_cliente TEXT FOREIGN KEY clientes (endereco_cliente)
);

CREATE TABLE clientes (
    cpf_cliente CHAR(11) PRIMARY KEY,
    idade_cliente INTEGER NOT NULL,
    cadastro_farmacia INTEGER NOT NULL, -- FAZER UMA LIGAÇÃO DE CADASTRO ENTRE OS CLIENTES E AS FARMACIAS
    tipo_endereco_cliente TEXT,
    endereco_cliente TEXT NOT NULL, -- PODE TER MAIS DE UM ENDERECO
    CREATE TYPE tipo_endereco_cliente AS ENUM ('residência', 'trabalho', 'outro')
);

ALTER TABLE clintes ADD CHECK (idade_cliente >= 18);