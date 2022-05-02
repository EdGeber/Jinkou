    /* 
    Todos os relacionamentos precisam ser transformados em 
        varray ou nestedTable
    */ 

    -- obj: ativo financeiro
CREATE OR REPLACE TYPE tp_ativo_financeiro AS OBJECT (
  nome VARCHAR2(100),
  tipo VARCHAR2(100)
);
/
-- obj: auxilio
CREATE OR REPLACE TYPE tp_auxilio AS OBJECT(
    cod_auxilio VARCHAR2(5),
    nome_auxilio VARCHAR2(100)
) 
/
-- obj: instituicao
CREATE OR REPLACE TYPE tp_instituicao AS OBJECT(
  cnpj VARCHAR2(14),
  nome VARCHAR2(100),
  data_abertura DATE,

  FINAL MEMBER PROCEDURE set_DataAbertura (data DATE)
);
/

-- obj: telefone
CREATE OR REPLACE TYPE tp_telefone AS OBJECT (
  DDD int, -- xx
  telefone int, -- xxxxx-xxxx

    CONSTRUCTOR FUNCTION tp_telefone(DDD int, telefone int)
                                   RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION tp_telefone(DDDtelefone int)
                                   RETURN SELF AS RESULT,

  MAP MEMBER FUNCTION telefoneTOint RETURN INTEGER
);
/

CREATE OR REPLACE TYPE BODY tp_telefone AS 

    CONSTRUCTOR FUNCTION tp_telefone(DDD int, telefone int)
                                   RETURN SELF AS RESULT IS
        begin
            self.DDD := DDD;
            self.telefone := telefone;
            return;
        end;
    
    CONSTRUCTOR FUNCTION tp_telefone(DDDtelefone int)
                                   RETURN SELF AS RESULT IS
        DDD int := (DDDtelefone/POWER(10,9))*POWER(10,9);
        telefone int := DDDtelefone - DDD;
        begin
            self.DDD := DDD;
            self.telefone := telefone;
            return;
        end;

    MAP MEMBER FUNCTION telefoneTOint RETURN INTEGER IS    
        t int := DDD*POWER(10,9) + telefone;
        begin
            return t;
        end;
END;
/

-- varray: telefone
CREATE OR REPLACE TYPE tp_array_telefone AS VARRAY (5) OF tp_telefone;
/

-- obj: cep
CREATE OR REPLACE TYPE tp_cep AS OBJECT(
    cep varchar(100),
    rua varchar(100),
    bairro varchar(100),
    cidade varchar(100),
    estado varchar(100)
);
/

-- obj: dependente
-- obj: pessoa
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    cpf varchar(100), 
    primeiro_nome varchar(100), 
    sobrenomes_centrais varchar(100), 
    ultimo_nome varchar(100), 
    endereco_numero int, 
    endereco_complemento varchar(100), 
    data_nasc date, 
    cep tp_cep,
    telefones tp_array_telefone,

    FINAL MEMBER PROCEDURE set_DataNasc (data DATE)
    
) NOT FINAL NOT INSTANTIABLE;
/

CREATE OR REPLACE TYPE tp_dependente AS OBJECT(
    primeiro_nome varchar(100),
    sobrenomes_centrais varchar(100),
    ultimos_nomes varchar(100),
    parentesco varchar(100),
    data_nasc DATE,
    
    MEMBER FUNCTION getParente() RETURN tp_pessoa,
    ORDER MEMBER FUNCTION comparaDependente(d tp_dependente) RETURN INTEGER;
);
/

-- CREATE OR REPLACE TYPE BODY tp_dependente AS

--     ORDER MEMBER FUNCTION comparaDependente (d tp_dependente) RETURN INTEGER IS
--     begin
--         IF(self.)
--     end;

-- /
    


-- TIPO NESTED TABLE DE DEPENDENTE --
CREATE OR REPLACE TYPE tp_nt_dependentes AS TABLE OF tp_dependente;
/

ALTER TYPE tp_pessoa ADD ATTRIBUTE (dependentes tp_nt_dependentes) CASCADE;
/

-- obj: ocupacao
CREATE OR REPLACE TYPE tp_ocupacao as OBJECT(
    ocupacao varchar(100)
);
/

-- varray: ocupacoes
CREATE OR REPLACE TYPE tp_array_ocupacao AS VARRAY (5) OF tp_ocupacao;
/

-- OBJ: cliente
CREATE OR REPLACE TYPE tp_cliente UNDER tp_pessoa(
  ocupacoes tp_array_ocupacao
);
/

/* declare
    auditor tp_auditor := tp_auditor('56464','José','','Jota',0,'Apt 825', '',
        tp_cep('5643563','aaaaa','bbbbbb','ccccc','PE'),
        tp_array_telefone(tp_telefone(81,9865134684)),tp_nt_dependentes(),8);
    motivo varchar := 'Cartao';
    conta_org tp_conta_corrente := tp_conta_corrente();
    conta_dest tp_conta_poupanca := tp_conta_poupanca();
begin
    DBMS_OUTPUT.PUT_LINE('Detalhes da conta');
end;
 */
-- obj: auditor
CREATE OR REPLACE TYPE tp_auditor UNDER tp_pessoa(
    tempo_serv NUMBER
);
/

-- obj: conta
CREATE OR REPLACE TYPE tp_conta AS OBJECT(
    numero_agencia VARCHAR(100),
    numero_conta VARCHAR(100),
    data_criacao DATE,
    nome_banco VARCHAR(100),
    saldo_atual NUMBER(10,2),
    
    MEMBER PROCEDURE fazTransferencia(SELF tp_conta,
                                     contaDest in out tp_conta, 
                                     valor in out number,
                                     auditor in out tp_auditor,
                                     motivo in out varchar
                                     ),
    MEMBER PROCEDURE exibirDetalhesConta
) NOT FINAL NOT INSTANTIABLE;
/



-- obj: conta corrente
CREATE OR REPLACE TYPE tp_conta_corrente UNDER tp_conta(
  credito_disponivel NUMBER(10, 2),
  limite_credito NUMBER(10, 2),
  taxa NUMBER(5, 2),
  positivo NUMBER(1),

  OVERRIDING MEMBER PROCEDURE exibirDetalhesConta
);
/

ALTER TYPE tp_conta_corrente DROP ATTRIBUTE (positivo);
/

CREATE OR REPLACE TYPE BODY tp_conta_corrente AS
    OVERRIDING MEMBER PROCEDURE exibirDetalhesConta IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Detalhes da conta');
        DBMS_OUTPUT.PUT_LINE('Tipo da conta: corrente');
        DBMS_OUTPUT.PUT_LINE('Número da agência: ' || numero_agencia);
        DBMS_OUTPUT.PUT_LINE('Número da conta: ' || numero_conta);
        -- DBMS_OUTPUT.PUT_LINE('Data da criação da conta: ' || TO_CHAR(data_criacao));
        DBMS_OUTPUT.PUT_LINE('Nome do banco: ' || nome_banco);
        DBMS_OUTPUT.PUT_LINE('Saldo atual: ' || TO_CHAR(saldo_atual));
        DBMS_OUTPUT.PUT_LINE('Crédito disponível: ' || TO_CHAR(credito_disponivel));
        DBMS_OUTPUT.PUT_LINE('Limite de crédito: ' || TO_CHAR(limite_credito));
        DBMS_OUTPUT.PUT_LINE('Taxa: ' || TO_CHAR(taxa));
    END;
END;
/
-- obj: conta poupanca
CREATE OR REPLACE TYPE tp_conta_poupanca UNDER tp_conta(
    juros_rend NUMBER(5,4),
    
    OVERRIDING MEMBER PROCEDURE exibirDetalhesConta
);
/

CREATE OR REPLACE TYPE BODY tp_conta_poupanca AS
    OVERRIDING MEMBER PROCEDURE exibirDetalhesConta IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Detalhes da conta');
        DBMS_OUTPUT.PUT_LINE('Tipo da conta: poupança');
        DBMS_OUTPUT.PUT_LINE('Número da agência: ' || numero_agencia);
        DBMS_OUTPUT.PUT_LINE('Número da conta: ' || numero_conta);
        DBMS_OUTPUT.PUT_LINE('Data da criação da conta: ' || TO_CHAR(data_criacao));
        DBMS_OUTPUT.PUT_LINE('Nome do banco: ' || nome_banco);
        DBMS_OUTPUT.PUT_LINE('Saldo atual: ' || TO_CHAR(saldo_atual));
        DBMS_OUTPUT.PUT_LINE('Juros de rendimento: ' || TO_CHAR(juros_rend));
    END;
END;
/

-- obj: movimenta
CREATE OR REPLACE TYPE tp_movimenta AS OBJECT(
    conta REF tp_conta,
    cliente REF tp_cliente    
);
/

-- obj: transfere
CREATE OR REPLACE TYPE tp_transfere AS OBJECT(
    data DATE,
    horario TIMESTAMP,
    valor number,
    status VARCHAR(100),
    motivo varchar(100),

    conta_orig REF tp_conta,
    conta_dest REF tp_conta,
    
    /* Possível erro aqui: 
       É preciso ver se não há problema de referencia vázia */
    auditor REF tp_auditor 
);
/

CREATE OR REPLACE TYPE BODY tp_conta AS
    member procedure fazTransferencia(SELF tp_conta,
                                     contaDest in out tp_conta, 
                                     valor in out number,
                                     auditor in out tp_auditor DEFAULT null,
                                     motivo in out varchar) 
    is 
        sucesso exception;
        semMoney exception; 
        auditorNecessario exception;  
        horario_transf TIMESTAMP;
        data date;
        status VARCHAR;
    begin
        data := CONVERT(SYSDATE, GETDATE());
        horario_transf := cast(SYSDATE as TIME);
        
        IF (saldo_atual <= valor) THEN
            raise semMoney;
        END IF;

        IF (valor >= 5000 && auditor == null) THEN
            raise auditorNecessario;
        END IF;

        raise sucesso;
        
        exception
        when semMoney then
            dbms_output.put_line('Rejected - Saldo insuficiente');
            INSERT INTO tb_transfere(conta_orig, conta_dest, data, horario, valor, status, motivo, auditor)
             VALUES(SELF, conta_dest, data, horario_transf, valor, "Rejeitado", motivo, auditor)

        when auditorNecessario then
            INSERT INTO tb_transfere(conta_orig, conta_dest, data, horario, valor, status, motivo, auditor)
            VALUES(SELF, conta_dest, data, horario_transf, valor, "Em Anadamento", motivo, auditor)
            dbms_output.put_line('Rejected - É necessário informar auditor para transferencias >= 5000.00');
        when sucesso then
            dbms_output.put_line('Accept - Sua transferencia foi aprovada');

            IF( valor >= 5000)
                INSERT INTO tb_transfere(conta_orig, conta_dest, data, horario, valor, status, motivo, auditor)
                                  VALUES(SELF, conta_dest, data, horario_transf, valor, "Não concluída", motivo, auditor)
                dbms_output.put_line('Sucesso - Sua transferencia está em Análise');
            ELSE
                INSERT INTO tb_transfere(conta_orig, conta_dest, data, horario, valor, status, motivo, auditor)
                VALUES(SELF, conta_dest, data, horario_transf, valor, "Aceito", motivo, auditor)
                dbms_output.put_line('Sucesso - Sua transferencia foi Aceita');                
            END IF;
            saldo_atual := saldo_atual - valor;
            contaDest.saldo_atual = contaDest.saldo_atual - valor;
        end fazTransferencia;
        
    end
end
/


-- obj: investe em
CREATE OR REPLACE TYPE tp_investe_em AS OBJECT(
    cliente REF tp_cliente,
    ativo_financeiro REF tp_ativo_financeiro,
    conta_corrente REF tp_conta_corrente,
    data_inicio DATE,
    hora_inicio TIMESTAMP,
    valor_mensal_investido NUMBER(7,2)
);
/

-- obj: oferece auxilio
CREATE OR REPLACE TYPE tp_oferece_auxilio AS OBJECT(
    movimenta REF tp_movimenta,
    auxilio REF tp_auxilio,
    instituicao REF tp_instituicao,
    valor_mensal number(8,2),
    data_inicio DATE
);
/
