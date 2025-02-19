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

/*
Questão 14: Retorna o nome compĺeto e o salário dos funcio9nários que possuem salário
maior do que 50 mil. A relação de retorno deve ter apenas duas colunas: "full_name" e
"salary". O nome completo deve ser formado pela concatenação dos valores das 3 colunas
com dados sobrenomes. Use o operador (||) para concaternar strings. 
*/

SELECT (e.fname ||''|| e.minit ||''|| e.lname) AS full_name, e.salary  
FROM EMPLOYEE e
WHERE e.salary > 50000;

/*
Questão 15: Retornar os projetos (nome) e os departamentos responsáveis (nome);
*/

SELECT p.pname AS project_name, d.dname AS department_name
FROM PROJECT p, DEPARTMENT d
WHERE p.dnum = d.dnumber;

/*
Questão 16: Retornar os projetys (nome)e osgerentes dos departamentos responsáveis
(primeiro nome). Retorne resultados apenas para projetos com código maior do que 30.
*/

SELECT p.pname AS project_name, e.fname AS manager_name
FROM PROJECT p, DEPARTMENT d, EMPLOYEE e
WHERE p.pnumber>30 AND d.dnumber = p.dnum AND d.mgrssn = e.ssn;

/*
Questão 17: Retornar os projetos (nome) e os funcionários que trabalham neles (primeiro nome).
*/

SELECT p.pname AS project_name, e.fname AS employee_name
FROM PROJECT p, WORKS_ON w, EMPLOYEE e
WHERE w.pno = p.pnumber AND w.essn = e.ssn;

/*
Questão 18: Retornar os nomes dos dependentes dos funcionários quetrabalham no projeto 91.
Retornar também o nome (primeiro) do funcionário e o relacionamento entre eles.
Retornar os atributos na mesma ordem que aparecem abaixo.
*/

SELECT e.fname, d.dependent_name, d.relationship
FROM EMPLOYEE e, DEPENDENT d, WORKS_ON w
WHERE w.pno = 91 AND e.ssn= w.essn AND e.ssn = d.essn;
--ORDER BY e.fname ASC;  