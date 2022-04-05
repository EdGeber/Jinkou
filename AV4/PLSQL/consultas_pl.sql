/*1, 2, 5, 11, 12, 13. USO DE RECORD, USO DE ESTRUTURA DE DADOS DO TIPO TABLE, CREATE FUNCTION, WHILE LOOP, FOR IN LOOP, SELECT INTO  
Descrição: Função para que, dado um CPF, retornar quais auxílios essa pessoa recebe e quais instituições oferecem esse auxílio a ela. */
CREATE OR REPLACE FUNCTION get_auxilio_instituicao (cpf_func PESSOA.cpf%TYPE) RETURN VARCHAR2 IS
    TYPE TIPO_AUXILIO_INSTITUICAO_PESSOA IS RECORD 
    (nome_instituicao INSTITUICAO.nome%TYPE, nome_auxilio AUXILIO.nome_auxilio%TYPE);
    
    TYPE TIPO_AUXILIO_INSTITUICAO_PESSOA_TABELA 
    IS TABLE OF TIPO_AUXILIO_INSTITUICAO_PESSOA;
    
    tab_aux_inst_pes TIPO_AUXILIO_INSTITUICAO_PESSOA_TABELA :=
    TIPO_AUXILIO_INSTITUICAO_PESSOA_TABELA();
    
    resultado VARCHAR2(400) := '';
    
    CURSOR c_aux_inst_pes IS SELECT * FROM OFERECE_AUXILIO WHERE cpf = cpf_func;
    
    BEGIN
        FOR registro_aux_inst IN c_aux_inst_pes LOOP
            tab_aux_inst_pes.EXTEND;
            SELECT i.nome INTO tab_aux_inst_pes(tab_aux_inst_pes.LAST).nome_instituicao FROM INSTITUICAO i WHERE i.cnpj = registro_aux_inst.cnpj;
            SELECT a.nome_auxilio INTO tab_aux_inst_pes(tab_aux_inst_pes.LAST).nome_auxilio FROM AUXILIO a WHERE a.cod_auxilio = registro_aux_inst.cod_aux;
        END LOOP;
        WHILE tab_aux_inst_pes.COUNT > 0 LOOP
            resultado := resultado || 'Auxílio: ' || tab_aux_inst_pes(tab_aux_inst_pes.LAST).nome_auxilio || 
                    '; Instituição: ' || tab_aux_inst_pes(tab_aux_inst_pes.LAST).nome_instituicao || ';' || chr(10);
            tab_aux_inst_pes.TRIM();
        END LOOP;
        RETURN resultado;
    END;
    /
    
SELECT get_auxilio_instituicao('462') FROM DUAL;

/*3. BLOCO ANÔNIMO  */

/*4, 6, 7, 10, 14, 16. CREATE PROCEDURE, %TYPE, %ROWTYPE, LOOP EXIT WHEN, CURSOR (OPEN, FETCH e CLOSE), USO DE PARÂMETROS (IN, OUT ou IN OUT)  
Descrição: Procedure que busca todos os telefones que possuam o valor do parâmetro como DDD. */
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
    /

EXECUTE pesquisa_telefone_DDD('82');

/*8. IF ELSIF  */

/*9. CASE WHEN  */

/*15. EXCEPTION WHEN  */

/*17. CREATE OR REPLACE PACKAGE  */

/*18. CREATE OR REPLACE PACKAGE BODY  */

/*19. CREATE OR REPLACE TRIGGER (COMANDO)  */

/*20. CREATE OR REPLACE TRIGGER (LINHA)  */
