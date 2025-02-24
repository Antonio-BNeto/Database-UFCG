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

SELECT EP.num_projeto, EP.qtd 
FROM Project AS P
JOIN (
    SELECT W.Pno AS num_projeto, COUNT(W.Essn) AS qtd
    FROM Works_On AS W
    GROUP BY W.Pno
    ) AS EP ON P.Pnumber = EP.num_projeto
WHERE EP.qtd = (
    SELECT MIN(EP2.qtd)
    FROM (SELECT COUNT(W2.Essn) AS qtd FROM Works_On AS W2 GROUP BY W2.Pno) AS EP2
);

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

SELECT W.Pno AS proj_num, P.Pname AS proj_nome, AVG(E.Salary) AS media_sal
FROM Project AS P, Employee AS E
JOIN Works_On W ON W.Essn = E.Ssn
WHERE P.Pnumber = W.Pno
GROUP BY W.Pno, P.Pname;

/*
Questão 10: Observer que o projeto 92 tem a maior média salarial. Faça uma consulta
para retornar os funcionários que não trabalham neste projeto mas que possuam salário maior
do que todos os funcionários que trabalham neste projeto. Basta retornar o primeiro
nome e o salário destes funcionários. O número 92 pode aparecer na consulta.
*/

SELECT DISTINCT e.fname, e.salary
FROM EMPLOYEE e 
WHERE e.ssn NOT IN (
    SELECT w.essn 
    FROM WORKS_ON w 
    WHERE w.pno = 92
)
AND e.salary > (
    SELECT MAX(e1.salary)
    FROM EMPLOYEE e1
    JOIN WORKS_ON w1 ON w1.essn = e1.ssn
    WHERE w1.pno = 92   
);


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
Questão 13: Usando consultas aninhadas e sem usar junções (nem mesmo as junções feitas com
produto cartesiano + filtragem usando cláusula WHERE), formule uma consulta para retornar os
primeiros nomes dos funcionários que trabalham no(s) projeto(s) localizado(s) em Sugarland e 
que possue dependentes.
*/

SELECT e.fname
FROM EMPLOYEE e
WHERE e.ssn IN (
    SELECT w.essn
    FROM WORKS_ON W
    WHERE w.pno IN(
        SELECT p.pnumber
        FROM PROJECT P
        WHERE p.plocation= 'Sugarland'
    )

)and e.ssn IN (
    SELECT d.essn
    FROM DEPENDENT d
);


/*
Questão 14: Sem usar IN esem usar nenhum tipo de junção (nem mesmo as junções feitas com 
produto cartesiano + filtragem usando cláusula WHERE) formule uma consulta para retornar
o(s) departamentos que não possuem projetos. É permitido especificar consultas aninhadas.
É permitido usar WHERE.
*/

SELECT d.dname
FROM DEPARTMENT D
WHERE NOT EXISTS (
    SELECT *
    FROM PROJECT p
    WHERE p.dnum = d.dnumber
);


/*
Questão 15: Retornar o primeiro e o ultimo nome do(s) funcionário(s) que trabalham em todos
os projetos em que trabalha o funcionário com ssn 123456789.
*/

SELECT e.fname, e.lname
FROM EMPLOYEE e
WHERE e.ssn IN (
    SELECT w1.essn
    FROM WORKS_ON w1
    WHERE NOT EXISTS (
        SELECT w2.pno
        FROM WORKS_ON w2
        WHERE w2.essn = '123456789'
        EXCEPT
        SELECT w3.pno
        FROM WORKS_ON w3
        WHERE w3.essn = w1.essn AND NOT w3.essn= '123456789'
    )
);

/*
Questão 16: Reescreva a questão 10 sem utilizar o código 92 explicitamente. Neste caso, a 
consulta fica genérica para identificar o código do projeto com maior média salarial. Porém,
observe que pode haver um empate (embora não haja neste estado atual do banco de dados).
*/

SELECT e.fname, e.salary
FROM EMPLOYEE e
WHERE e.ssn NOT IN (
    SELECT w.essn
    FROM WORKS_ON W
    WHERE w.pno IN (
        SELECT pno
        FROM WORKS_ON
        GROUP BY pno
        HAVING AVG (
            (SELECT salary FROM EMPLOYEE WHERE ssn= WORKS_ON.essn)
        )=(
            SELECT MAX(media)
            FROM (
                SELECT pno, AVG(
                    (SELECT salary FROM EMPLOYEE WHERE ssn = w.essn)
                )AS media
                FROM WORKS_ON w
                GROUP BY pno
            ) AS subquery
        )
    )
)
AND e.salary > ALL (
    SELECT e2.salary
    FROM EMPLOYEE e2
    WHERE e2.ssn IN (
        SELECT w2.essn
        FROM WORKS_ON w2
        WHERE w2.pno IN (
            SELECT pno
            FROM WORKS_ON
            GROUP BY pno
            HAVING AVG(
                (SELECT salary FROM EMPLOYEE WHERE ssn = WORKS_ON.essn)
            ) = (
                SELECT MAX(media)
                FROM (
                    SELECT pno, AVG(
                        (SELECT salary FROM EMPLOYEE WHERE ssn = w.essn)
                    ) AS media
                    FROM WORKS_ON w
                    GROUP BY pno
                ) AS subquery
            )
        )
    )
);