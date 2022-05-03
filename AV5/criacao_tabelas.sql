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

  MEMBER FUNCTION getparente RETURN VARCHAR AS  

  parente_encontrado BOOLEAN := FALSE;
  cpf_atual VARCHAR(100);
  dependentes tp_nt_dependentes;
  
  found INTEGER;
    
  CURSOR cpfs_ntsdependentes IS
  SELECT cpf, dependentes FROM tb_relac_dependente_pessoa;
  
  BEGIN
    OPEN cpfs_ntsdependentes;
    LOOP
        FETCH cpfs_ntsdependentes INTO cpf_atual,dependentes;
        
        SELECT COUNT(*) INTO found FROM TABLE(SELECT relac.dependentes 
            FROM tb_relac_dependente_pessoa relac WHERE relac.cpf = cpf_atual) D 
            WHERE SELF.primeiro_nome = D.primeiro_nome AND
                SELF.sobrenomes_centrais = D.sobrenomes_centrais AND
                SELF.ultimos_nomes = D.ultimos_nomes;
                
        IF(found > 0) THEN
            parente_encontrado := TRUE;
            EXIT;
        END IF;
        
        EXIT WHEN cpfs_ntsdependentes%notfound;
    END LOOP;
    CLOSE cpfs_ntsdependentes;
    IF parente_encontrado = FALSE THEN
        cpf_atual := NULL;
    END IF;
    RETURN cpf_atual;
  END;
  
  ORDER MEMBER FUNCTION comparadependente (D tp_dependente) RETURN INTEGER IS
  proprio_nome_completo VARCHAR2(300) := SELF.primeiro_nome || SELF.sobrenomes_centrais || SELF.ultimos_nomes;
  outro_nome_completo   VARCHAR2(300) :=    D.primeiro_nome ||    D.sobrenomes_centrais ||    D.ultimos_nomes;
  BEGIN
    IF(proprio_nome_completo > outro_nome_completo) THEN
        RETURN 1;
    END IF;
    IF(proprio_nome_completo = outro_nome_completo) THEN
        RETURN 0;
    END IF;
    RETURN -1;
  END;
END;
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
