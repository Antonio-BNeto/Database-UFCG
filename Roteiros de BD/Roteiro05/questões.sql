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

SELECT superssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados
FROM EMPLOYEE
GROUP BY ssn_supervisor
ORDER BY qtd_supervisionados;

/*
Questão 4: Para cada funcionário que supervisiona alguém, retornar seu nome e a quantidade de funcionarios que supervisiona.
O resultado deve ser ordenado pela quantidade de funcionários supervisionados. A consulta NÃO  deve conter uma cláusula WHERE.
*/

SELECT s.fname AS nome_supervisor, COUNT(e.ssn) AS qtd_supervisionados
FROM EMPLOYEE s
JOIN EMPLOYEE e ON s.ssn = e.superssn 
GROUP BY nome_supervisor
ORDER BY qtd_supervisionados;

/*
Questão 5: Faça uma consulta equivalente à anterior, poreḿ onsiderando os funcionários que não possuem
supervisor (note que o resultado possui uma linha a mais que o resultado da questão anterior). Esta consulta
também NÃO deve conter cláusula WHERE. Não é necessário ordenar o resultado.
*/

SELECT s.fname AS nome_supervisor, COUNT(e.ssn) AS qtd_supervisionados
FROM EMPLOYEE s
RIGHT JOIN EMPLOYEE e ON s.ssn = e.superssn 
GROUP BY nome_supervisor;

/*
Questão 6: Retornar a qantidade de funcionários que trabalham no(s) projetos que conté menos 
funcionários.
*/

SELECT MIN(qtd) 
FROM(SELECT COUNT(*) qtd FROM PROJECT p, WORKS_ON w WHERE p.pnumber= w.pno); 

/*
Questão 7: Faça uma consulta equivalente à anterior, porém, retorne também o número do projeto.
Há outras consultas mais fáceis abaixo, portanto, caso prefira, deixe esta para depois. Porém o
interessante em faze esta questão agora é que ela mistura conceitos explorados nas questões anteriores
(3 a 6), acrescida de um pequeno detalhe.
*/


