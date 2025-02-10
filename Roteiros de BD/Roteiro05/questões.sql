/*
Questão 1: Retornar quantas funcioárias estão cadastradas.
*/

SELECT COUNT(*)
FROM EMPLOYEE
WHERE sex = 'F';

/*
Questão 2: Retornar a média de salário dos funcionáios homens que moram no estado do TEXAS
(TX);
*/

SELECT AVG(salary)
FROM EMPLOYEE
WHERE address LIKE '%, TX' AND sex = 'M';

/*
Questão 3: Retornar os ssn dos supervisores e a quantidade de funcionários que cada um deles
supervisiona (contar também os que não são supervisionadospor ninguém). Ordenar o resultado pela quantidade.
*/
