CREATE TABLE tb_ativo_financeiro OF tp_ativo_financeiro (
  nome PRIMARY KEY
);
/
-- OI :D
CREATE TABLE tb_auxilio OF tp_auxilio(
    cod_auxilio PRIMARY KEY,
    nome_auxilio NOT NULL
);
/

CREATE TABLE tb_instituicao OF tp_instituicao (
  cnpj PRIMARY KEY CHECK(length(cnpj) = '14')
);
/

-- CREATE TABLE tb_cep OF tp_cep (
--   cep PRIMARY KEY
-- );
-- /

CREATE TABLE tb_cliente OF tp_cliente(
    cpf PRIMARY KEY,
    primeiro_nome NOT NULL,
    endereco_numero CHECK (endereco_numero >= 0)
);  
/

CREATE TABLE tb_auditor OF tp_auditor(
    cpf PRIMARY KEY,
    primeiro_nome NOT NULL,
    endereco_numero CHECK (endereco_numero >= 0)
); 
/



CREATE OR REPLACE TYPE BODY tp_dependente AS

  MEMBER FUNCTION getParente RETURN varchar AS  

  parente_encontrado BOOLEAN := false;
  cpf_atual varchar(100);

  cursor cpfs_ntsDependentes is
  select cpf, dependentes from tb_relac_dependente_pessoa;

  begin
    -- itera sobre cada dependente de cada cliente de tb_cliente

    --TODO: consertar cursor (open, fetch, close, etc)
    for cpf_atual, ntDependentes in cpfs_ntsDependentes loop
      for dependente in table(ntDependentes) loop
        if(self.primeiro_nome = dependente.primeiro_nome and
        self.sobrenomes_centrais = dependente.sobrenomes_centrais and
        self.ultimo_nome = dependente.ultimo_nome) then
          parente_encontrado := true;
          exit;
        end if;
      end loop;
        if(parente_encontrado) then exit end if;
    end loop;
    return cpf_atual;
  end;

  ORDER MEMBER FUNCTION comparaDependente (d tp_dependente) RETURN INTEGER IS
  proprio_nome_completo varchar2(300) := self.primeiro_nome || self.sobrenomes_centrais || self.ultimo_nome;
  outro_nome_completo   varchar2(300) :=    d.primeiro_nome ||    d.sobrenomes_centrais ||    d.ultimo_nome;
  begin
    if(proprio_nome_completo > outro_nome_completo) then return 1 end if;
    if(proprio_nome_completo = outro_nome_completo) then return 0 end if;
    return -1;
  end;
end;
/



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
