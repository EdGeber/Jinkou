-- CREATE OR REPLACE TYPE 
-- Objeto: ativo financeiro
CREATE OR REPLACE TYPE tp_ativo_financeiro AS OBJECT (
  nome VARCHAR2(100),
  tipo VARCHAR2(100)
);
/

-- Objeto: auxilio
CREATE OR REPLACE TYPE tp_auxilio AS OBJECT(
    cod_auxilio VARCHAR2(5),
    nome_auxilio VARCHAR2(100)
); 
/

-- FINAL MEMBER
-- Objeto: instituicao
CREATE OR REPLACE TYPE tp_instituicao AS OBJECT(
  cnpj VARCHAR2(14),
  nome VARCHAR2(100),
  data_abertura DATE,

  FINAL MEMBER PROCEDURE set_DataAbertura (cnpj_in IN VARCHAR2, data IN DATE)
);
/

-- CREATE OR REPLACE TYPE BODY
-- Type body com procedure que altera a data de abertura de uma instituição
CREATE OR REPLACE TYPE BODY tp_instituicao AS
    FINAL MEMBER PROCEDURE set_DataAbertura(cnpj_in IN VARCHAR2, data IN DATE) IS
    BEGIN
        UPDATE tb_instituicao i SET i.data_abertura = data WHERE i.cnpj = cnpj_in;
    END;
END;
/
    
-- MAP MEMBER FUNCTION E CONSTRUCTOR FUNCTION
-- Objeto: telefone
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

-- Type body com dois construtores (um para cada forma de entrada de um telefone) e uma map member function que serve para comparar os telefones em um order by
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
        
        DDD int := floor(DDDtelefone/POWER(10,8));
        telefone int := DDDtelefone - (DDD*POWER(10,8));
        begin
            self.DDD := DDD;
            self.telefone := telefone;
            return;
        end;

    MAP MEMBER FUNCTION telefoneTOint RETURN INTEGER IS    
        t int := DDD*POWER(10,8) + telefone;
        begin
            return t;
        end;
END;
/

-- VARRAY
-- Varray: telefone
CREATE OR REPLACE TYPE tp_array_telefone AS VARRAY (5) OF tp_telefone;
/

-- Objeto: cep
CREATE OR REPLACE TYPE tp_cep AS OBJECT(
    cep varchar(100),
    rua varchar(100),
    bairro varchar(100),
    cidade varchar(100),
    estado varchar(100)
);
/

-- NOT FINAL E NOT INSTANTIABLE
-- Objeto: pessoa
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    cpf varchar(100), 
    primeiro_nome varchar(100), 
    sobrenomes_centrais varchar(100), 
    ultimo_nome varchar(100), 
    endereco_numero int, 
    endereco_complemento varchar(100), 
    data_nasc date, 
    cep tp_cep,
    telefones tp_array_telefone
    
) NOT FINAL NOT INSTANTIABLE;
/

-- MEMBER FUNCTION E ORDER MEMBER FUNCTION
-- Objeto: dependente
CREATE OR REPLACE TYPE tp_dependente AS OBJECT(
    primeiro_nome varchar(100),
    sobrenomes_centrais varchar(100),
    ultimos_nomes varchar(100),
    parentesco varchar(100),
    data_nasc DATE,
    
    MEMBER FUNCTION getParente RETURN varchar,
    ORDER MEMBER FUNCTION comparaDependente(d tp_dependente) RETURN INTEGER
);
/

-- NESTED TABLE
-- Nested tabel: dependentes
CREATE OR REPLACE TYPE tp_nt_dependentes AS TABLE OF tp_dependente;
/

-- Tabela que relaciona uma pessoa a uma nested table de dependentes
CREATE TABLE tb_relac_dependente_pessoa(
    cpf varchar(100),
    dependentes tp_nt_dependentes
) NESTED TABLE dependentes STORE AS tb_dependentes;
/

-- Objeto: ocupacao
CREATE OR REPLACE TYPE tp_ocupacao as OBJECT(
    ocupacao varchar(100)
);
/

-- Varray: ocupacoes
CREATE OR REPLACE TYPE tp_array_ocupacao AS VARRAY (5) OF tp_ocupacao;
/

-- HERANÇA DE TIPOS (UNDER)
-- Objeto: cliente
CREATE OR REPLACE TYPE tp_cliente UNDER tp_pessoa(
  ocupacoes tp_array_ocupacao
);
/

-- Objeto: auditor
CREATE OR REPLACE TYPE tp_auditor UNDER tp_pessoa(
    tempo_serv NUMBER
);
/

-- MEMBER PROCEDURE
-- Objeto: conta
CREATE OR REPLACE TYPE tp_conta AS OBJECT(
    numero_agencia VARCHAR(100),
    numero_conta VARCHAR(100),
    data_criacao DATE,
    nome_banco VARCHAR(100),
    saldo_atual NUMBER(10,2),
    
    MEMBER PROCEDURE exibirDetalhesConta
) NOT FINAL NOT INSTANTIABLE;
/

-- OVERRIDING MEMBER
-- Objeto: conta corrente
CREATE OR REPLACE TYPE tp_conta_corrente UNDER tp_conta(
  credito_disponivel NUMBER(10, 2),
  limite_credito NUMBER(10, 2),
  taxa NUMBER(5, 2),
  positivo NUMBER(1),

  OVERRIDING MEMBER PROCEDURE exibirDetalhesConta
);
/

-- Type body de tp_conta_corrente com procedure que printa os detalhes de uma conta corrente
CREATE OR REPLACE TYPE BODY tp_conta_corrente AS
    OVERRIDING MEMBER PROCEDURE exibirDetalhesConta IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Detalhes da conta');
        DBMS_OUTPUT.PUT_LINE('Tipo da conta: corrente');
        DBMS_OUTPUT.PUT_LINE('Número da agência: ' || numero_agencia);
        DBMS_OUTPUT.PUT_LINE('Número da conta: ' || numero_conta);
        DBMS_OUTPUT.PUT_LINE('Data da criação da conta: ' || TO_CHAR(data_criacao));
        DBMS_OUTPUT.PUT_LINE('Nome do banco: ' || nome_banco);
        DBMS_OUTPUT.PUT_LINE('Saldo atual: ' || TO_CHAR(saldo_atual));
        DBMS_OUTPUT.PUT_LINE('Crédito disponível: ' || TO_CHAR(credito_disponivel));
        DBMS_OUTPUT.PUT_LINE('Limite de crédito: ' || TO_CHAR(limite_credito));
        DBMS_OUTPUT.PUT_LINE('Taxa: ' || TO_CHAR(taxa));
    END;
END;
/

-- Objeto: conta poupanca
CREATE OR REPLACE TYPE tp_conta_poupanca UNDER tp_conta(
    juros_rend NUMBER(5,4),
    
    OVERRIDING MEMBER PROCEDURE exibirDetalhesConta
);
/

-- Type body de tp_conta_poupanca com procedure que printa os detalhes de uma conta poupança
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

-- REF
-- Objeto: movimenta
CREATE OR REPLACE TYPE tp_movimenta AS OBJECT(
    conta REF tp_conta,
    cliente REF tp_cliente    
);
/

-- Objeto: transfere
CREATE OR REPLACE TYPE tp_transfere AS OBJECT(
    data DATE,
    horario TIMESTAMP,
    valor number,
    status VARCHAR(100),
    motivo varchar(100),

    conta_orig REF tp_conta,
    conta_dest REF tp_conta,
    auditor REF tp_auditor 
);
/

-- Objeto: investe em
CREATE OR REPLACE TYPE tp_investe_em AS OBJECT(
    cliente REF tp_cliente,
    ativo_financeiro REF tp_ativo_financeiro,
    conta_corrente REF tp_conta_corrente,
    data_inicio DATE,
    hora_inicio TIMESTAMP,
    valor_mensal_investido NUMBER(7,2)
);
/

-- Objeto: oferece auxilio
CREATE OR REPLACE TYPE tp_oferece_auxilio AS OBJECT(
    movimenta REF tp_movimenta,
    auxilio REF tp_auxilio,
    instituicao REF tp_instituicao,
    valor_mensal number(8,2),
    data_inicio DATE
);
/

-- ALTER TYPE: 
-- Adicionando uma member function a tp_oferece_auxilio
ALTER TYPE tp_oferece_auxilio 
    -- Retorna o valor anual recebido do auxilio
    ADD MEMBER FUNCTION valor_anual(SELF tp_oferece_auxilio)
    RETURN NUMBER CASCADE;
/

-- Body do tp_oferece_auxilio
CREATE OR REPLACE TYPE BODY tp_oferece_auxilio AS
    MEMBER FUNCTION valor_anual(SELF tp_oferece_auxilio)
    RETURN NUMBER IS  
    BEGIN
        RETURN SELF.valor_mensal * 12;
    END;
END;
/
