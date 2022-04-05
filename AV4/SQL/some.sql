-- Relatório sobre as transferências cujo valor transferido é maior do que o
-- transferido por alguma outra transferência
SELECT * FROM TRANSFERE
WHERE VALOR > SOME 
(SELECT VALOR FROM TRANSFERE);