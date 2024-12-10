
-- Questão 1

CREATE TABLE tarefas (
    id_tarefas INTEGER,
    funcao TEXT,
    codigo CHAR(11),
    numero INTEGER,
    categoria CHAR(1)
);


-- As iserções abaixo devem ser executadas

INSERT INTO tarefas VALUES (2147483646, 'limpar chão do corredor central',
'98765432111', 0, 'F');

INSERT INTO tarefas VALUES (2147483647, 'limpar janelas da sala 203',
'98765432122', 1, 'F');

INSERT INTO tarefas VALUES (null, null, null, null, null);

-- As inserçẽs abaixo não devem ser executadas.

INSERT INTO tarefas VALUES (2147483644, 'limpar chão do corredor superior', -- inserção não realizada
'987654323211', 0, 'F');

INSERT INTO tarefas VALUES (2147483643, 'limpar chão do corredor superior', --  inserção não realizada
'98765432321', 0, 'FF');


-- Questão 2

-- Função funcionou após a execução da solução
INSERT INTO tarefas VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4,
'A');

-- Erro mostrado:
/*
ERROR:  integer out of range
*/

-- Significado do erro

/*
Como o atributo id_tarefa foi atribuido do tipo INTEGER então está restrito
a valores de -2147483648 to +2147483647 e como o INSERT utilizado está no escopo
maior que o permitido se torna preciso alterar o tipo de atributo de INTEGER para 
BIGINT que tem o intervalo fechado entre -9223372036854775808 e +9223372036854775807
fazendo com que o se torne muito mais dificil de da erro.
*/

-- Solução do erro:
--Solução está correta
ALTER TABLE tarefas ALTER COLUMN id_tarefas TYPE BIGINT;

-- Questão 3

/*
Como o intervalo que o atributo "numero" aceita é de no máximo 32767, então 
o tipo que se encaixa melhor com o atributo é o SMALLINT que tem o
intervalo fechado de -32768 até +32767.
*/

ALTER TABLE tarefas ALTER COLUMN numero TYPE SMALLINT;

-- Inserções que não devem ser executadas.
INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal','32322525199', 32768, 'A');
INSERT INTO tarefas VALUES (2147483650, 'limpar janelas da entrada principal', '32333233288', 32769, 'A');

-- Inserções que devem ser executadas.
INSERT INTO tarefas VALUES (2147483651, 'limpar portas do 1o andar','32323232911', 32767, 'A');
INSERT INTO tarefas VALUES (2147483652, 'limpar portas do 2o andar', '32323232911', 32766, 'A');

-- Questão 4

-- Utilizando o RENAME para alterar o nome dos atributos

ALTER TABLE tarefas RENAME COLUMN id_tarefas TO id;
ALTER TABLE tarefas RENAME COLUMN funcao TO descricao;
ALTER TABLE tarefas RENAME COLUMN codigo TO func_resp_cpf;
ALTER TABLE tarefas RENAME COLUMN numero TO prioridade;
ALTER TABLE tarefas RENAME COLUMN categoria TO status;

-- Criando a constrain para que o atributo não seja null

ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;

-- Erro mostrado:

/*
ERRO: column "atributos" of relation "tarefas" contains null values
*/

-- Significado do erro:

/*
Não é possivel fazer com que uma coluna seja  NOT NULL enquanto existir tuplas
com valores NULL nesta coluna.
*/

-- Solução:

/*
Remove as tuplas com base em alguma condição definida pelo WHERE,
assim eu o utilizei para remover as tuplas que possuiam valores NULL.
*/
DELETE FROM tarefas
WHERE
    id IS NULL OR
    descricao IS NULL OR
    func_resp_cpf IS NULL OR
    prioridade IS NULL OR
    status IS NULL;

-- Questão 5

-- Adicionando restrição de integridade no atributo "id"

ALTER TABLE tarefas ADD PRIMARY KEY (id);

-- inserção deve funcionar normalmente
INSERT INTO tarefas VALUES (2147483653, 'limpar portas do 1o andar','32323232911', 2, 'A');

-- inserção não deve funcionar após o insert anterior ter sido executado
INSERT INTO tarefas VALUES (2147483653, 'aparar a grama da área frontal', '32323232911', 3, 'A');


--Questão 6

-- Letra (A)

-- Utilizando CHECK para realizar a constraint.
ALTER TABLE tarefas ADD CHECK (LENGTH(func_resp_cpf) = 11);

-- Testando a constrain

-- func_resp_cpf com tamanho 10
INSERT INTO tarefas VALUES (2147483653, 'aparar a grama da área frontal', '3232323291', 3, 'A');

-- func_resp_cpf com tamanho 11
INSERT INTO tarefas VALUES (2300000000, 'aparar a grama da área frontal', '32323232911', 3, 'A');

-- func_resp_cpf com tamanho 12
INSERT INTO tarefas VALUES (2147483653, 'aparar a grama da área frontal', '323232329112', 3, 'A');

-- Retirando as tuplas de testes inseridas na tabela

-- Letra (B)

-- Alterando os valores da coluna de status

UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'E' WHERE status = 'R';
UPDATE tarefas SET status = 'C' WHERE status = 'F';

-- Adicionando CHECK para evitar erros durante inserções

ALTER TABLE tarefas ADD CHECK (status IN ('P','E','C'));

-- Questão 7

-- Arrumando as tuplas com prioridade maior que 5
UPDATE tarefas SET prioridade = 5 where prioridade > 5;

-- Adicionando a constrain para que só seja inserido uma tupla com prioridade entre 0 e 5
ALTER TABLE tarefas ADD CHECK (prioridade >= 0 AND prioridade <= 5);

-- Questão 8

CREATE TABLE funcionario (
    cpf CHAR(11) PRIMARY KEY,
    data_nasc DATE NOT NULL,
    nome VARCHAR(120) NOT NULL,
    funcao char(11) NOT NULL,
    nivel char(1) NOT NULL,
    superior_cpf CHAR(11) REFERENCES funcionario (cpf),

    CHECK(funcao = 'SUP_LIMPEZA' or (funcao = 'LIMPEZA' AND superior_cpf IS NOT NULL)),
    CHECK(nivel IN ('J', 'P', 'S'))
);

-- devem funcionar:
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');

-- não deve funcionar
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', null);


-- Questão 9

-- Realizando a inserção de 10 tuplas válidas
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) 
VALUES
  ('12345678913', '1985-02-04', 'Rafael', 'SUP_LIMPEZA', 'S', null),
  ('12345678914', '1992-11-12', 'Igor', 'SUP_LIMPEZA', 'S', '12345678913'),
  ('12345678915', '1989-04-06', 'Ewerton', 'SUP_LIMPEZA', 'P', null),
  ('12345678916', '2001-08-17', 'Pedro', 'LIMPEZA', 'J', '12345678914'),
  ('12345678917', '1999-12-01', 'Rafaella', 'SUP_LIMPEZA', 'J', null),
  ('12345678918', '1992-08-24', 'Mariana', 'LIMPEZA', 'P', '12345678913'),
  ('12345678919', '1980-06-18', 'Victor', 'SUP_LIMPEZA', 'S', null),
  ('12345678920', '1983-02-09', 'Roberto', 'LIMPEZA', 'P', '12345678919'),
  ('12345678921', '1996-07-26', 'Leon', 'SUP_LIMPEZA', 'P', null),
  ('12345678922', '1988-03-08', 'Bruce Wayne', 'SUP_LIMPEZA', 'J', '12345678919'); -- inserção realizada
  
-- 10 exemplos de inserções que não funcionam

-- nivel = 'A' não é permitido, só são permitidos os valores 'J', 'P' ou 'S'
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678923', '1985-02-19', 'Ronaldo', 'SUP_LIMPEZA', 'A', null); -- inserção não realizada 

-- funcao = 'LIMPEZA', mas superior_cpf = null, o que não é permitido
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678924', '1982-11-11', 'Elisa', 'LIMPEZA', 'S', null); -- inserção não realizada

-- a chave estrangeira, superio_cpf, aponta para um funcionário que não existe, o que não é permitido
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678925', '1986-05-08', 'Raissa', 'LIMPEZA', 'J', '12345675820'); -- inserção não realizada

-- a chave primária, cpf, é igual a chave primária de outro funcionário, o que não é permitido
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678913', '1986-04-13', 'Afonso Pereira', 'SUP_LIMPEZA', 'P', null); -- inserção não realizada

-- funcao = 'GERENTE' não é permitido, só são permitidos os valores 'SUP_LIMPEZA' ou 'LIMPEZA'
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678932', '1987-01-02', 'Bianca', 'GERENTE', 'J', null); -- inserção não realizada

-- a chave primária, cpf, não pode ser null
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
(null, '1992-03-11', 'Jorge', 'SUP_LIMPEZA', 'S', null); -- inserção não realizada

-- a coluna data_nasc não pode ser null
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678928', null, 'Fernanda', 'SUP_LIMPEZA', 'P', null); -- inserção não realizada

-- a coluna nome não pode ser null
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678929', '1999-10-03', null, 'SUP_LIMPEZA', 'P', null); -- inserção não realizada

-- a coluna funcao não pode ser null
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678930', '1986-06-16', 'Douglas', null, 'J', null); -- inserção não realizada

-- a coluna nivel não pode ser null
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES
('12345678931', '1987-07-18', 'Arthur', 'SUP_LIMPEZA', null, null); -- inserção não realizada

-- Questão 10

-- ()