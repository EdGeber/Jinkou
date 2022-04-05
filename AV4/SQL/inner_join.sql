-- Mostrar informações sobre os auditores e as transações que eles auditam
SELECT p.PRIMEIRO_NOME,p.SOBRENOMES_CENTRAIS,p.ULTIMO_NOME, p.CPF, a.tempo_serv,
t.data,  t.horario, t.valor, t.status, t.motivo,
t.numero_agencia_orig, t.numero_conta_orig,
t.numero_agencia_dest, t.numero_conta_dest
FROM auditor a
INNER JOIN transfere t
ON t.cpf_auditor = a.cpf
INNER JOIN pessoa p
ON a.cpf = p.cpf