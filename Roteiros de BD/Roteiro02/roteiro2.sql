
-- Questão 1

CREATE TABLE tarefas (
    id_tarefas INTEGER,
    funcao TEXT,
    cpf_funcionario CHAR(11),
    prioridade Integer,
    status_tarefa CHAR(1)
);


-- As iserções abaixo devem ser executadas

INSERT INTO tarefas VALUES (2147483646, 'limpar chão do corredor central',
'98765432111', 0, 'F');

INSERT INTO tarefas VALUES (2147483647, 'limpar janelas da sala 203',
'98765432122', 1, 'F');

INSERT INTO tarefas VALUES (null, null, null, null, null);

-- As inserçẽs abaixo não devem ser executadas.

INSERT INTO tarefas VALUES (2147483644, 'limpar chão do corredor superior',
'987654323211', 0, 'F');

INSERT INTO tarefas VALUES (2147483643, 'limpar chão do corredor superior',
'98765432321', 0, 'FF');

