--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.8 (Ubuntu 15.8-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: antoniobdan_db; Type: DATABASE; Schema: -; Owner: antoniobdan
--

CREATE DATABASE antoniobdan_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE antoniobdan_db OWNER TO antoniobdan;

\connect antoniobdan_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: antoniobdan
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome character varying(120) NOT NULL,
    funcao character(11) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character(11),
    CONSTRAINT funcionario_check CHECK (((funcao = 'SUP_LIMPEZA'::bpchar) OR ((funcao = 'LIMPEZA'::bpchar) AND (superior_cpf IS NOT NULL)))),
    CONSTRAINT funcionario_nivel_check CHECK ((nivel = ANY (ARRAY['J'::bpchar, 'P'::bpchar, 'S'::bpchar])))
);


ALTER TABLE public.funcionario OWNER TO antoniobdan;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: antoniobdan
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao text NOT NULL,
    func_resp_cpf character(11),
    prioridade smallint NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT tarefas_check CHECK ((((status = ANY (ARRAY['E'::bpchar, 'C'::bpchar])) AND (func_resp_cpf IS NOT NULL)) OR (status = 'P'::bpchar))),
    CONSTRAINT tarefas_check1 CHECK ((((status = ANY (ARRAY['E'::bpchar, 'C'::bpchar])) AND (func_resp_cpf IS NOT NULL)) OR (status = 'P'::bpchar))),
    CONSTRAINT tarefas_func_resp_cpf_check CHECK ((length(func_resp_cpf) = 11)),
    CONSTRAINT tarefas_prioridade_check CHECK (((prioridade >= 0) AND (prioridade <= 5)))
);


ALTER TABLE public.tarefas OWNER TO antoniobdan;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: antoniobdan
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA    ', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1997-03-05', 'Rafael', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678914', '1998-04-10', 'Igor', 'SUP_LIMPEZA', 'S', '12345678913');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678915', '1999-05-23', 'Ewerton', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678916', '2000-06-01', 'Pedro', 'LIMPEZA    ', 'J', '12345678914');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678917', '2001-07-28', 'Rafaella', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678918', '2002-08-22', 'Mariana', 'LIMPEZA    ', 'P', '12345678913');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678919', '2003-09-21', 'Victor', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678920', '2004-10-19', 'Roberto', 'LIMPEZA    ', 'P', '12345678919');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678921', '2005-11-18', 'Leon', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '2006-12-17', 'Bruce Wayne', 'SUP_LIMPEZA', 'J', '12345678919');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1999-05-23', 'Ewerton', 'LIMPEZA    ', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '2000-06-01', 'Pedro', 'SUP_LIMPEZA', 'P', NULL);


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: antoniobdan
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chão do corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C');


--
-- Name: funcionario funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: antoniobdan
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas tarefas_pkey; Type: CONSTRAINT; Schema: public; Owner: antoniobdan
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id);


--
-- Name: funcionario funcionario_superior_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: antoniobdan
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_superior_cpf_fkey FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- Name: tarefas tarefa_fkey_func_resp_cpf; Type: FK CONSTRAINT; Schema: public; Owner: antoniobdan
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefa_fkey_func_resp_cpf FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE CASCADE;


--
-- Name: tarefas tarefas_func_resp_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: antoniobdan
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_func_resp_cpf_fkey FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- Name: tarefas tarefas_func_resp_cpf_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: antoniobdan
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_func_resp_cpf_fkey1 FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE RESTRICT;


--
-- Name: DATABASE antoniobdan_db; Type: ACL; Schema: -; Owner: antoniobdan
--

REVOKE CONNECT,TEMPORARY ON DATABASE antoniobdan_db FROM PUBLIC;
GRANT TEMPORARY ON DATABASE antoniobdan_db TO PUBLIC;


--
-- PostgreSQL database dump complete
--

