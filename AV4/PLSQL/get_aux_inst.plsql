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