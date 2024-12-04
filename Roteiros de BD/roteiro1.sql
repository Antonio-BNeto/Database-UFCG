CREATE TABLE Automovel (
    modelo_automovel text,
    cpf_dono varchar(11) not null,
    placa_automovel text,
    ano_automovel char(4),
    cor_automovel text,
    PRIMARY KEY(placa_automovel);
);

CREATE TABLE Segurado(
    cpf_segurado varchar(11),
    data_nascimento date,
    telefone_segurado text,
    email text,
    PRIMARY KEY (cpf_segurado);
);

CREATE TABLE Perito (
    cpf_perito varchar(11),
    PRIMARY KEY (cpf_perito)
);

CREATE TABLE Oficina(
    id_Oficina text;

);

CREATE TABLE Seguro (
    vencimento_Seguro date
);

CREATE TABLE Sinistro (
    Descricao text,
    Data_Sinistro date
);

CREATE TABLE Pericia (
    analise_Pericia text,
    cpf_perito varchar(11),
    FOREIGN KEY (cpf_perito) REFERENCES Perito(cpf_perito)
);

CREATE TABLE Reparo (

);