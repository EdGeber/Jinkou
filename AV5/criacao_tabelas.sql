CREATE TABLE tb_ativo_financeiro OF tp_ativo_financeiro (
  nome PRIMARY KEY
);
/

CREATE TABLE tb_auxilio OF tp_auxilio(
    cod_auxilio PRIMARY KEY,
    nome_auxilio NOT NULL
);
/

CREATE TABLE tb_instituicao OF tp_instituicao (
  cnpj PRIMARY KEY CHECK(length(cnpj) = '14')
);
/

CREATE TABLE tb_cep OF tp_cep (
  cep PRIMARY KEY
);
/

CREATE TABLE tb_cliente OF tp_cliente(
    cpf PRIMARY KEY,
    primeiro_nome NOT NULL,
    endereco_numero CHECK (endereco_numero >= 0)
)
    NESTED TABLE dependentes STORE AS tb_dependentes_cliente;  
/

CREATE TABLE tb_auditor OF tp_auditor(
    cpf PRIMARY KEY,
    primeiro_nome NOT NULL,
    endereco_numero CHECK (endereco_numero >= 0),
) 
    NESTED TABLE  dependentes AS tp_dependentes_auditor; 
/

/*
CREATE OR REPLACE TYPE BODY tp_dependente AS

    ADD MEMBER FUNCTION getParente() RETURN tp_pessoa AS  
    begin
      -- iterar sobre a concatenação da tabela tb_cliente
      -- com a tabela tb_auditor
    end;

    ORDER MEMBER FUNCTION comparaDependente (d tp_dependente) RETURN INTEGER IS
    begin
        -- ordenar primeiro por nome de parente, e então pelo próprio nome
        IF(self.)
    end;

/
*/

CREATE TABLE tb_conta_corrente OF tp_conta_corrente (
  CONSTRAINT tb_conta_corrente_pkey PRIMARY KEY(numero_agencia,numero_conta),
  CONSTRAINT chk_credito_valido CHECK(credito_disponivel <= limite_credito)
);
/

CREATE TABLE tb_conta_poupanca OF tp_conta_poupanca (
  CONSTRAINT tb_conta_poupanca_pkey PRIMARY KEY(numero_agencia,numero_conta)
);
/

CREATE TABLE tb_movimenta OF tp_movimenta (
  conta NOT NULL,
  cliente WITH ROWID REFERENCES tb_cliente NOT NULL
);
/

CREATE TABLE tb_transfere OF tp_transfere(
    CONSTRAINT Audita_5k_check CHECK ((valor >= 5000.00 AND auditor != NULL)
                                      OR (valor < 5000.00 AND auditor = NULL))
);
/

CREATE TABLE tb_investe_em OF tp_investe_em (
  cliente SCOPE IS tb_cliente,
  ativo_financeiro WITH ROWID REFERENCES tb_ativo_financeiro,
  conta_corrente WITH ROWID REFERENCES tb_conta_corrente
);
/

CREATE TABLE tb_oferece_auxilio OF tp_oferece_auxilio (
  movimenta WITH ROWID REFERENCES tb_movimenta,
  auxilio WITH ROWID REFERENCES tb_auxilio,
  instituicao WITH ROWID REFERENCES tb_instituicao
);