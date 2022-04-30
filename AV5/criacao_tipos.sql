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
                                   RETURN SELF AS RESULT,
        begin
            self.DDD := DDD;
            self.telefone := telefone;
        end;
    
    CONSTRUCTOR FUNCTION tp_telefone(DDDtelefone int)
                                   RETURN SELF AS RESULT,
        DDD int := (DDDtelefone/POWER(10,9))*POWER(10,9);
        telefone int := DDDtelefone - DDD;
        begin
            self.DDD := DDD;
            self.telefone := telefone;
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
CREATE OR REPLACE TYPE tp_dependente AS OBJECT(
    primeiro_nome varchar(100),
    sobrenomes_centrais varchar(100),
    ultimos_nomes varchar(100),
    parentesco varchar(100),
    data_nasc DATE
);
/

CREATE OR REPLACE TYPE BODY tp_dependente AS

    ORDER MEMBER FUNCTION comparaDependente (d tp_dependente) RETURN INTEGER IS
    begin
        IF(self.)
    end;

/
    

-- TIPO NESTED TABLE DE DEPENDENTE --
CREATE OR REPLACE TYPE tp_nt_dependentes AS TABLE OF tp_dependente;
/

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
    dependentes tp_nt_dependentes,

    FINAL MEMBER PROCEDURE set_DataNasc (data DATE)
    
) NOT FINAL NOT INSTANTIABLE;
/

-- Tá dando erro de compilação
-- ALTER TYPE tp_dependente
--     ADD MEMBER FUNCTION getParente() RETURN tp_pessoa;

--     ORDER MEMBER FUNCTION comparaDependente (d tp_dependente) RETURN INTEGER;
-- /

-- obj: ocupacao
CREATE OR REPLACE TYPE tp_ocupacao as OBJECT(
    cpf_origem varchar(100),
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
    
    MEMBER PROCEDURE fazTransferencia(agenciaDest in out varchar,
                                     contaDest in out varchar, 
                                     valor in out number)
) NOT FINAL NOT INSTANTIABLE;
/

CREATE OR REPLACE TYPE BODY tp_conta as
    member procedure fazTransferencia(agenciaDest in out varchar, contaDest in out varchar, valor in out number) is 
        sucesso exception;
        semMoney exception;
        contaInvalida exception;
        conta_dest tp_conta;
        ehCC boolean;
    begin
        IF (saldo_atual <= valor) THEN
            raise semMoney;
        END IF;
        
        /* soninho */
        /* Checkar se existe a conta agenciaDest, contaDest */

        select * into conta_dest
        from tb_conta_corrente cc
        where (agenciaDest = cc.numero_agencia and contaDest = cc.numero_conta);

        ehCC := true;
        if (conta_dest = null) then
            select * into conta_dest
            from tb_conta_poupanca pc
            where (agenciaDest = pc.numero_agencia and contaDest = pc.numero_conta);
    	    ehCC := false;
            if (conta_dest = null) then
                raise contaInvalida
            end if;
        end if;

        saldo_atual := saldo_atual - valor;

        if (ehCC) then
            update tb_conta_corrente cc
               set cc.saldo_atual = cc.saldo_atual - valor;
               where agenciaDest =cc.numero_agencia and contaDest = cc.numero_conta)  
        else
            update tb_conta_poupanca pc
                set pc.saldo_atual = pc.saldo_atual - valor;
                where agenciaDest = pc.numero_agencia and contaDest = pc.numero_conta 
        end if;
        
        /*TODO - adicionar transferencia na tabela de transfere - Passar como referencia...*/
        if valor >= 5000 then
            insert into tp_transfere Values();
            /* Adicionar a data e hora atual (testar...) */
            /* SELECT CONVERT (TIME, GETDATE()); */
        else
            insert into tp_transfere Values()
        end if;
        
        raise sucesso;
    exception
      when semMoney then
        dbms_output.put_line('Rejected - Saldo insuficiente');
      when contaInvalida then
        dbms_output.put_line('Rejected - Conta destino não existe');
      when sucesso then
        dbms_output.put_line('Accept - Sua transferencia foi aprovada');
    end fazTransferencia;

end;
/

-- obj: conta corrente
CREATE OR REPLACE TYPE tp_conta_corrente UNDER tp_conta(
  credito_disponivel NUMBER(10, 2),
  limite_credito NUMBER(10, 2),
  taxa NUMBER(5, 2),
  positivo NUMBER(1)
);
/

ALTER TYPE tp_conta_corrente DROP ATTRIBUTE (positivo);
/

-- obj: conta poupanca
CREATE OR REPLACE TYPE tp_conta_poupanca UNDER tp_conta(
    juros_rend NUMBER(5,4)
);
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
    auditor    REF tp_auditor 
);
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