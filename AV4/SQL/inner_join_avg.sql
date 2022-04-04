-- Qual é o valor médio oferecido no auxílio "Moradia Estudantil"?
SELECT AVG(VALOR_MENSAL) FROM oferece_auxilio of_aux
INNER JOIN auxilio aux
ON of_aux.cod_aux = aux.cod_auxilio
WHERE aux.nome_auxilio = 'Moradia Estudantil';