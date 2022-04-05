-- 5.1 Qual a pessoa que mais fez transações considerando as contas das quais é titular?

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
