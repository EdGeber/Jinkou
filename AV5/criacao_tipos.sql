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

  MAP MEMBER FUNCTION telefoneTOint RETURN INTEGER
);
/

CREATE OR REPLACE TYPE BODY tp_telefone AS 

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
    data_nasc DATE,
);
/

-- TIPO NESTED TABLE DE DEPENDENTE --
CREATE OR REPLACE TYPE tp_nt_dependentes AS TABLE OF tp_dependente;

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

-- obj: ocupacao
CREATE OR REPLACE TYPE tp_ocupacao as OBJECT(
    cpf_origem varchar(100),
    ocupacao varchar(100)
);
/

-- varray: ocupacoes
CREATE OR REPLACE TYPE tp_array_ocupacao AS VARRAY (5) OF tp_ocupacao;
/

-- OBJ: PESSOA
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
    saldo_atual NUMBER(10,2)
) NOT FINAL NOT INSTANTIABLE;
/

-- obj: conta corrente
CREATE OR REPLACE TYPE tp_conta_corrente UNDER tp_conta(
  credito_disponivel NUMBER(10, 2),
  limite_credito NUMBER(10, 2),
  taxa NUMBER(5, 2),
  positivo NUMBER(1)
);
/

-- obj: conta poupanca
CREATE OR REPLACE TYPE tp_conta_poupanca UNDER tp_conta(
    juros_rend NUMBER(5,4)
);
/

-- obj: movimenta
CREATE OR REPLACE TYPE tp_movimenta AS OBJECT(
    numero_agencia VARCHAR(100),
    numero_conta VARCHAR(100),
    cpf VARCHAR(100)
);
/

-- obj: transfere
CREATE OR REPLACE TYPE tp_transfere AS OBJECT(
    data DATE,
    horario TIMESTAMP,
    valor number,
    status VARCHAR(100),
    motivo varchar(100),
    numero_agencia_orig VARCHAR(100),
    numero_conta_orig VARCHAR(100),
    numero_agencia_dest VARCHAR(100),
    numero_conta_dest VARCHAR(100),
    cpf_auditor VARCHAR(100)
);
/

-- obj: investe em
CREATE OR REPLACE TYPE tp_investe_em AS OBJECT(
    nome_ativo VARCHAR(100),
    numero_agencia VARCHAR(100),
    numero_conta VARCHAR(100),
    cpf VARCHAR(100),
    data_inicio DATE,
    hora_inicio TIMESTAMP,
    valor_mensal_investido NUMBER(7,2)
);
/

-- obj: oferece auxilio
CREATE OR REPLACE TYPE tp_oferece_auxilio AS OBJECT(
    cpf varchar(100),
    numero_agencia varchar(100),
    numero_conta varchar(100),
    cnpj varchar(14),
    cod_aux varchar(5),
    valor_mensal number(8,2),
    data_inicio DATE
);
/