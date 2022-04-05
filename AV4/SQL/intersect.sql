-- Nome de clientes que movimentam tanto uma conta corrente quanto uma poupança
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