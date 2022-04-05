-- Mostrar o valor mensal que contas da agência 001 investem em cada ativo
SELECT nome,valor_mensal_investido FROM 
(SELECT nome_ativo, valor_mensal_investido 
FROM Conta_investe_em
WHERE numero_agencia = 001)
RIGHT OUTER JOIN ativo_financeiro af
ON af.nome = nome_ativo;