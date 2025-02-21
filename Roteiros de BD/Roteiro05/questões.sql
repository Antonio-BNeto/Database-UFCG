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

SELECT MIN(qtd_emp) AS qtd 
FROM(SELECT COUNT(*) AS qtd_emp FROM WORKS_ON GROUP BY pno) AS company; 

/*
Questão 7: Faça uma consulta equivalente à anterior, porém, retorne também o número do projeto.
Há outras consultas mais fáceis abaixo, portanto, caso prefira, deixe esta para depois. Porém o
interessante em fazer esta questão agora é que ela mistura conceitos explorados nas questões anteriores
(3 a 6), acrescida de um pequeno detalhe.
*/


/*
Questão 8: Retornar a média salarial por projeto.
*/
SELECT w.pno AS num_proj, AVG(e.salary) AS media_salary
FROM EMPLOYEE e
JOIN WORKS_ON w ON w.essn = e.ssn
GROUP BY w.pno;

/*
Questão 9: Altere a consulta anterior para retornar também os nomes dos projetos.
*/

/*
Questão 10: Observer que o projeto 92 tem a maior média salarial. Faça uma consulta
para retornar os funcionários que não trabalham neste projeto mas que possuam salário maior
do que todos os funcionários que trabalham neste projeto. Basta retornar o primeiro
nome e o salário destes funcionários. O número 92 pode aparecer na consulta.
*/


/*
Questão 11: Retornar a quantidade de projetos por funcionário, ordenando pela quantidade
*/

SELECT e.ssn AS ssn, COUNT(w.pno) AS qtd_proj
FROM EMPLOYEE e
LEFT JOIN WORKS_ON w ON e.ssn = w.essn
GROUP BY ssn
ORDER BY qtd_proj ASC;

/*
Questão 12: Retornar a quantidadae de funcionários por projeto (incluindo os funcionários "sem
projeto"). Retornar apenas os projetos que possuem menos de 5 funcionários. Ordernar pela quantidade.
*/

SELECT w.pno AS num_proj, COUNT(e.ssn) AS qtd_func
FROM EMPLOYEE e
LEFT JOIN WORKS_ON w ON e.ssn = w.essn
GROUP BY w.pno
HAVING COUNT(w.essn) < 5
ORDER BY qtd_func ASC;

/*
Questão 13: Usando consultas aninhadas e sem usar junções (nem mesmo as jujnções feitas com
produto cartesiano + filtragem usando cláusula WHERE), formule uma consulta para retornar os
primeiros nomes dos funcionários que trabalham no(s) projeto(s) localizado(s) em Sugarland e 
que possue dependentes.
*/

SELECT fname
FROM (SELECT )