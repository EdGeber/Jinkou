CREATE OR REPLACE PROCEDURE pesquisa_telefone_DDD 
    (DDD IN TELEFONE.telefone%TYPE) IS
    CURSOR cursor_telefone IS
        SELECT *
        FROM TELEFONE
        WHERE telefone LIKE ('('||DDD||')%');
    registro_telefone TELEFONE%ROWTYPE;
    BEGIN
        OPEN cursor_telefone;
        LOOP
            FETCH cursor_telefone INTO registro_telefone;
            EXIT WHEN cursor_telefone%NOTFOUND;
                dbms_output.put_line(
            'CPF_origem: '||registro_telefone.cpf_origem||
            ' - Telefone: '||registro_telefone.telefone);
        END LOOP;
        CLOSE cursor_telefone;
    END;

EXECUTE pesquisa_telefone_DDD('82');