/* 1. ALTER TABLE 
Descrição: removendo a coluna que indica se um número é positivo ou não, já que um trigger de linha foi criado para isso.*/
select * from Conta_Corrente;
ALTER TABLE CONTA_CORRENTE DROP (POSITIVO);
select * from Conta_Corrente;

/*2. CREATE INDEX
Descricao: colocar um índice nos atributos cpf e nome_ativo da tabela Investe_em para agilizar a busca. */
CREATE INDEX cpf_nome_ativo_investe ON INVESTE_EM(cpf, nome_ativo);


/*3. INSERT INTO */
-- Descrição: A pessoa quer adicionar um celular.
select * from telefone;
insert into Telefone(cpf_origem, telefone) values ('594', '(77) 7777 7777'); 
select * from telefone;

/*4. UPDATE  */
-- Descrição: A pessoa mudou de ocupação e temos que atualizar-la.
select * from ocupacao;
UPDATE OCUPACAO SET OCUPACAO = 'Desenvolvedora' WHERE CPF_ORIGEM = '001';
select * from ocupacao;

/*5. DELETE 
Descrição: dado um telefone e um cpf, deleta o telefone correspondente da base de dados. */
CREATE OR REPLACE PROCEDURE deleta_telefone 
    (telefone_to_delete IN TELEFONE.telefone%TYPE,
    cpf_pessoa IN TELEFONE.cpf_origem%TYPE) IS
    
    telefone_not_found EXCEPTION;
    BEGIN 
        DELETE FROM TELEFONE WHERE cpf_origem = cpf_pessoa AND telefone = telefone_to_delete;
        IF SQL%NOTFOUND THEN
            RAISE telefone_not_found;
        END IF;
        EXCEPTION
            WHEN telefone_not_found THEN
            dbms_output.put_line('Telefone não existe na base de dados');
    END;
/
-- Teste deleta_telefone
select * from telefone;
EXECUTE deleta_telefone('(77) 7777 7777', '594');
select * from telefone;

/*6. SELECT-FROM-WHERE */
-- Descrição: Quais são os bairros e suas ruas, em Recife
SELECT BAIRRO, RUA FROM CEP WHERE (CIDADE = 'Recife');

/*7 E 21. BETWEEN E ORDER BY */
-- Descrição: oferecimentos de auxilios entre 100 e 900 reais, em ordem crescente de valor
SELECT * FROM OFERECE_AUXILIO WHERE VALOR_MENSAL BETWEEN 100 AND 900 ORDER BY VALOR_MENSAL;

/*8. IN */
--Descrição: Quis são os ceps de pernambuco e do rio grande do norte
SELECT CEP FROM CEP WHERE ESTADO IN ('PE', 'RN');

/*9. LIKE  */
-- Descrição: Quais são as Ruas em homenagem a Damorim
SELECT * FROM CEP WHERE RUA LIKE '%Damorim%';

/*10. IS NULL OR IS NOT NULL 
Descrição: situacao de transferencias auditadas ou em audicao.*/
SELECT VALOR, MOTIVO, STATUS FROM TRANSFERE WHERE CPF_AUDITOR IS NOT NULL;

/*11. INNER JOIN  
Descrição: Mostrar informações sobre os auditores e as transações que eles auditam.*/
SELECT p.PRIMEIRO_NOME,p.SOBRENOMES_CENTRAIS,p.ULTIMO_NOME, p.CPF, a.tempo_serv,
t.data,  cast(t.horario as time)horario, t.valor, t.status, t.motivo,
t.numero_agencia_orig, t.numero_conta_orig,
t.numero_agencia_dest, t.numero_conta_dest
FROM auditor a
INNER JOIN transfere t
ON t.cpf_auditor = a.cpf
INNER JOIN pessoa p
ON a.cpf = p.cpf;

/*12, 15, 18, 22, 23, 25. MAX, COUNT, SUBCONSULTA COM IN, GROUP BY, HAVING, CREATE VIEW 
Descrição: Descobrir, dentre as pessoas com 3 ou mais dependentes, qual conta tem o maior saldo.*/
CREATE VIEW DADOS_PESSOA_TEM_DEPENDENTES AS 
(SELECT NUMERO_AGENCIA, NUMERO_CONTA FROM MOVIMENTA 
WHERE CPF IN (SELECT CPF_PARENTE FROM DEPENDENTE 
GROUP BY CPF_PARENTE HAVING COUNT(*) >= 3));

SELECT NUMERO_AGENCIA, NUMERO_CONTA 
FROM (SELECT * 
FROM CONTA 
WHERE NUMERO_AGENCIA IN (SELECT NUMERO_AGENCIA FROM DADOS_PESSOA_TEM_DEPENDENTES) 
AND NUMERO_CONTA IN (SELECT NUMERO_CONTA FROM DADOS_PESSOA_TEM_DEPENDENTES)) 
WHERE SALDO_ATUAL IN (SELECT MAX (SALDO_ATUAL) FROM (SELECT * FROM CONTA 
WHERE NUMERO_AGENCIA IN (SELECT NUMERO_AGENCIA FROM DADOS_PESSOA_TEM_DEPENDENTES) 
AND NUMERO_CONTA IN (SELECT NUMERO_CONTA FROM DADOS_PESSOA_TEM_DEPENDENTES)));

/*13. MIN  */
--Descrição: motivo das transferências de menor valor registrado
SELECT t_outer.motivo FROM Transfere t_outer WHERE t_outer.valor IN (
    SELECT MIN(t_inner.valor) FROM Transfere t_inner);

/*14. AVG  
Descrição: Qual é o valor médio oferecido no auxílio "Moradia Estudantil"? */
SELECT AVG(VALOR_MENSAL) FROM oferece_auxilio of_aux
INNER JOIN auxilio aux
ON of_aux.cod_aux = aux.cod_auxilio
WHERE aux.nome_auxilio = 'Moradia Estudantil';

/*16. LEFT OU RIGHT OU FULL OUTER JOIN 
Descrição: Mostrar o valor mensal que contas com número de agência igual a 001 investem em cada ativo. */
SELECT nome,valor_mensal_investido FROM 
(SELECT nome_ativo, valor_mensal_investido 
FROM Conta_investe_em
WHERE numero_agencia = 001)
RIGHT OUTER JOIN ativo_financeiro af
ON af.nome = nome_ativo;

/*17. SUBCONSULTA COM OPERADOR RELACIONAL  
Descrição: nome e data de abertura das instituições que oferecem bolsa família. */
SELECT Ins.nome, Ins.data_abertura from Instituicao Ins WHERE Ins.cnpj IN (
    SELECT OA.cnpj FROM Oferece_auxilio OA WHERE OA.cod_aux = (
        SELECT Au.cod_auxilio FROM Auxilio Au WHERE Au.nome_auxilio = 'Bolsa Família'
        )
    );

/*19. SUBCONSULTA COM ANY 
Descrição: Relatório sobre as transferências cujo valor transferido é maior do que o transferido por alguma outra transferência. */
SELECT data, cast(horario as time)horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor FROM TRANSFERE
WHERE VALOR > ANY 
(SELECT VALOR FROM TRANSFERE);

/*20. SUBCONSULTA COM ALL 
Descrição: 5.1 Qual a pessoa que mais fez transações considerando as contas das quais é titular? */

-- view do número de transações feitas por cada cliente
CREATE VIEW transacoes_por_cliente (cpf_cliente, numero_transacoes) AS
    SELECT Cli.cpf AS cpf_cliente, COUNT(*) AS numero_transacoes
    FROM Transfere T, Conta Con, Movimenta M, Cliente Cli
    WHERE T.numero_agencia_orig = Con.numero_agencia
    AND   T.numero_conta_orig   = Con.numero_conta
    AND   Con.numero_agencia = M.numero_agencia
    AND   Con.numero_conta   = M.numero_conta
    AND   M.cpf = Cli.cpf
    GROUP BY Cli.cpf;

-- nome do cliente que fez mais transações
SELECT primeiro_nome, ultimo_nome
FROM Pessoa
WHERE cpf = (
    SELECT cpf_cliente
    FROM transacoes_por_cliente
    WHERE numero_transacoes >= ALL (
        SELECT numero_transacoes
        FROM transacoes_por_cliente
        )
    );

/*24. UNION OU INTERSECT OU MINUS 
Descrição: Nome de clientes que movimentam tanto uma conta corrente quanto uma poupança */
SELECT primeiro_nome, sobrenomes_centrais, ultimo_nome FROM PESSOA p
INNER JOIN 
((SELECT cpf FROM movimenta
WHERE numero_agencia IN (SELECT numero_agencia FROM conta_corrente)
AND numero_conta IN (SELECT numero_conta FROM conta_corrente))
INTERSECT
(SELECT cpf FROM movimenta
WHERE numero_agencia IN (SELECT numero_agencia FROM conta_poupanca)
AND numero_conta IN (SELECT numero_conta FROM conta_poupanca))) inter
ON p.cpf = inter.cpf;

/*26. GRANT/REVOKE  */
-- O livesql não permite utiliza-los :/
grant insert, select on Dependente to public;
revoke insert on Dependente from public;
