-- nome e data de abertura das instituições que oferecem bolsa família
SELECT Ins.nome, Ins.data_abertura from Instituicao Ins WHERE Ins.cnpj IN (
    SELECT OA.cnpj FROM Oferece_auxilio OA WHERE OA.cod_aux = (
        SELECT Au.cod_auxilio FROM Auxilio Au WHERE Au.nome_auxilio = 'Bolsa Família'
        )
    )
