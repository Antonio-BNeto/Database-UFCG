/*
Questão 1:Retornar todos os elementos da tabela department.
*/

SELECT  * 
FROM DEPARTMENT;

/*
Questão 2: Retornar todos os elementos da tabela dependent.
*/

SELECT * 
FROM DEPENDENT;

/*
Questão 3: Retornar todos os elementos da tabela dept_locations.
*/

SELECT * 
FROM DEPT_LOCATIONS;

/*
Questão 4: Retornar todos os elementos da tabela employee.
*/

SELECT * 
FROM EMPLOYEE;

/*
Questão 5: Retorna todos os elementos da tabela project;
*/

SELECT * 
FROM PROJECT;

/*
Questão 6: Retorna todos os elementos da tabela works_on
*/

SELECT * 
FROM WORKS_ON;

/*
Questão 7: Retornar os nomes(primeiro e último) dos funcionários homens;
*/

SELECT fname,lname
FROM employee 
WHERE sex = 'M';

/*
Questão 8: Retornar os nomes (primeiro) dos funcionários homens que não possuem supervisor
*/

SELECT fname
FROM EMPLOYEE
WHERE sex = 'M' AND superssn IS NULL;

/*
Questão 9: Retornar os nomes dos funcionários (primeiro) e o nome (primeiro) do seu supervisor,
apenas para os funcionários que possuem supervisor
*/

SELECT e.fname AS funcionario, s.fname AS supervisor
FROM EMPLOYEE e,EMPLOYEE s 
WHERE e.superssn = s.ssn AND e.superssn IS NOT NULL;

/*
Questão 10: Retornar os nomes (primeiro) dos funcionários cujo supervisor se chama Franklin;
*/

SELECT e.fname
FROM EMPLOYEE e, EMPLOYEE s
WHERE s.fname = 'Franklin' AND e.superssn = s.ssn;


/*
Questão 11: Retornar os nomes dos departamentos e suas localizações;
*/

SELECT dep.dname AS departamento, deptl.dlocation AS local
From DEPARTMENT dep, DEPT_LOCATIONS deptl
WHERE dep.dnumber = deptl.dnumber;

/*
Questão 12: Retornar os nomes dos departamanetos localizados em cidades que começam com a letra 'S'
*/

SELECT dep.dname
FROM DEPARTMENT dep, DEPT_LOCATIONS deptl
WHERE deptl.dnumber= dep.dnumber AND deptl.dlocation LIKE 'S%';

/*
Questão 13: Retornar os nomes (primeiro e último) dos funcionários e seus dependentes 
(apenas para funcionários que possuem dependentes)
*/

SELECT e.fname, e.lname, d.dependent_name
FROM EMPLOYEE e, DEPENDENT d
WHERE e.ssn=d.essn AND d.essn IS NOT NULL;
