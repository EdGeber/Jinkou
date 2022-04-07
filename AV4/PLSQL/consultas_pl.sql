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

/*3, 9. BLOCO ANÔNIMO, CASE WHEN
Descrição: Relatório de instituições que fornecem determinado auxílio.
*/
/*Declaração do bloco anônimo*/
DECLARE
    /* Declaração do tipo: inst_aux 
     * que será usado para referenciar 
     * as instituições que oferecem o auxilio */
    TYPE inst_aux IS RECORD (
        st_instituicao Oferece_auxilio.cnpj%TYPE,
        st_auxilio Oferece_auxilio.cod_aux%TYPE
    );
    /* Declaração das variáveis que serão 
     * acessadas posteriormente */
    var_auxilio inst_aux;
    var_codauxilio VARCHAR(20); -- grava um código de auxilio
    var_nomeauxilio VARCHAR(20); -- grava um nome de instituição
    var_nomeinstituicao VARCHAR(50); -- guarda o nome de uma instituição
    /* Cursor que será utilizado no FOR LOOP para retorno de cada
     * cnpj para pode retornar a devida instituição após */
    CURSOR curs_cnpj IS SELECT cnpj FROM Oferece_auxilio;
BEGIN
    /* Variável que fará o papel de input*/
    var_nomeauxilio := 'Moradia Estudantil';
    /* Caso o input (var_nomeauxilio) exista no sistema,
     * guarda o código do auxilio na variável var_codauxilio */
    CASE var_nomeauxilio
    WHEN 'Moradia Estudantil' THEN
        var_codauxilio := 1;
    WHEN 'Auxílio-Creche' THEN
        var_codauxilio := 2;
    WHEN 'Bolsa Família' THEN
        var_codauxilio := 3;
    WHEN 'Auxílio Emergencial' THEN
        var_codauxilio := 4;
    WHEN 'Auxílio Internet' THEN
        var_codauxilio := 5;
    WHEN 'Vale Transporte' THEN
        var_codauxilio := 6;
    ELSE 
        /* Caso o input não exista, retorna uma mensagem de erro.*/
        DBMS_OUTPUT.PUT_LINE('Esse auxílio não está no sistema.');
    END CASE;
    /* Inicio do FOR LOOP */
    BEGIN
        /* Guarda cada cnpj que tenha o código de auxilio
         * definido anteriormente. */
        FOR curs_cnpj IN (SELECT cnpj FROM Oferece_auxilio 
                        WHERE cod_aux = var_codauxilio )
        LOOP
            /* Guarda o nome da instituição que possui o
             * cnpj que foi encontrado anteriormente.*/
            SELECT nome INTO var_nomeinstituicao 
            FROM Instituicao 
            WHERE cnpj = (curs_cnpj.cnpj);
            /* Retorna o nome da instituição que oferece 
             * determinado auxilio. */
            DBMS_OUTPUT.PUT_LINE(var_nomeinstituicao);
        END LOOP;
    END;
END;

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



/*15. EXCEPTION WHEN 
Descrição: dado um telefone e um cpf, tenta remover a tupla da tabela telefone, mas levanta uma exceção caso a tupla não exista. */
CREATE OR REPLACE PROCEDURE deleta_telefone 
    (telefone_to_delete IN TELEFONE.telefone%TYPE,
    cpf_pessoa IN TELEFONE.cpf_origem%TYPE) IS
    
    telefone_not_found EXCEPTION;
    BEGIN 
        DELETE FROM TELEFONE WHERE cpf_origem = cpf_pessoa AND telefone = telefone_to_delete;
        IF SQL%NOTFOUND THEN
            RAISE telefone_not_found;
        END IF;
        EXCEPTION
            WHEN telefone_not_found THEN
            dbms_output.put_line('Telefone não existe na base de dados');
    END;
    /

EXECUTE deleta_telefone('(93) 3828-4531', '001');

/*17. CREATE OR REPLACE PACKAGE  */

/*18. CREATE OR REPLACE PACKAGE BODY  */

/*8. IF ELSIF  */
-- Procedure Helper para o trigger de comando
-- Atualiza o valor de uma variavel de acordo com a quantidade de ocorrencia daquele status em um dado ano.
create or replace procedure get_number_Tranferencia(
    variavel out number, 
    ano date, 
    statusTarget Transfere.status%type
) is transfException Exception;
begin
    -- Aqui está o if.. elsif.. else
    if(statusTarget != 'Aceito' and statusTarget != 'Rejeitado' and statusTarget != 'Não concluída' and statusTarget != 'todas') then 
        raise transfException;
    elsif(statusTarget = 'todas') then
        select count(*) 
        into variavel
        from Transfere
        where (to_char(Transfere.data, 'YYYY') = to_char(ano, 'YYYY'));
    else
        select count(*) 
        into variavel
        from Transfere
        where (to_char(Transfere.data, 'YYYY') = to_char(ano, 'YYYY') and (Transfere.status = statusTarget));
    end if;
    exception 
        when transfException then
            RAISE_APPLICATION_ERROR(-20001,'Status de transferência invalido', FALSE);
end get_number_Tranferencia;
/

/*19. CREATE OR REPLACE TRIGGER (COMANDO)  */
-- Retorna a quantidade de transferencias aceitas, em analise e rejeitadas no ano atual e também a quantidade total de transferencias
-- Apos o insert na tabela de Transferencias
create or replace trigger Numero_transferencia_mes
after insert on Transfere
DECLARE
    totaltm number;
    acpttm number;
    rjcttm number;
    qtm number;
    totalt number;
    today date;

Begin
    select sysdate into today from dual;
    
    -- Total de transferencia no mes.
    get_number_Tranferencia(totaltm, today, 'todas');
    -- Total de trnasferencia aceitas no mes.
    get_number_Tranferencia(acpttm, today, 'Aceito');
    -- Total de transferencias rejeitadas no mes.
    get_number_Tranferencia(rjcttm, today, 'Rejeitado');
    -- Total de transferencias em analise no mes.
    get_number_Tranferencia(qtm, today, 'Não concluída');
    
    -- Total de transferencias na tabela.
    select count(*) 
    into totalt
    from Transfere;
    -- Output
    DBMS_OUTPUT.PUT_LINE('dados da tabela Transfere:');
    DBMS_OUTPUT.PUT_LINE('  Neste ano de '||to_char(today, 'YYYY')||' foram feitas: ');
    DBMS_OUTPUT.PUT_LINE('      '||acpttm||' transferência(s) Aceita(s)');
    DBMS_OUTPUT.PUT_LINE('      '||qtm||' transferência(s) Em analíse');
    DBMS_OUTPUT.PUT_LINE('      '||rjcttm||' transferência(s) Rejeitada(s)');
    DBMS_OUTPUT.PUT_LINE('  Totalizando: ');
    DBMS_OUTPUT.PUT_LINE('      '||totaltm||' transferência(s) no ano');
    DBMS_OUTPUT.PUT_LINE('      '||totalt||' transferencia(s) ao todo');
END;
/ 
-- Teste para o Trigger de comando
/*insert into Transfere(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) 
    values (TO_DATE('07/11/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('14:11:10', 'HH24:MI:SS'), 5000.00, 'Rejeitado', 'TED', '367', '891756213', '854', '837917841', '594');
*/


/*20. CREATE OR REPLACE TRIGGER (LINHA)  */
--Descrição: não permite que o saldo de uma conta poupança seja negativo mas permite que o saldo de contas correntes o sejam
CREATE OR REPLACE TRIGGER saldo_poupanca_checker
BEFORE UPDATE OF saldo_atual ON conta
FOR EACH ROW
DECLARE
    contas_achadas INTEGER;
BEGIN
    IF :NEW.saldo_atual < 0 THEN
        
        SELECT count(*) INTO contas_achadas FROM conta_poupanca
        WHERE  numero_agencia = :NEW.numero_agencia
        AND    numero_conta   = :NEW.numero_conta;
        
        IF contas_achadas != 0 THEN
            RAISE_APPLICATION_ERROR(-20010,
            'Saldo da conta poupança não pode ser negativo');
        END IF;
    END IF;
END;
/
