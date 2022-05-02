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
            return;
        end;
    
    CONSTRUCTOR FUNCTION tp_telefone(DDDtelefone int)
                                   RETURN SELF AS RESULT,
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
CREATE OR REPLACE TYPE tp_dependente AS OBJECT(
    primeiro_nome varchar(100),
    sobrenomes_centrais varchar(100),
    ultimos_nomes varchar(100),
    parentesco varchar(100),
    data_nasc DATE
);
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
ALTER TYPE tp_dependente
    ADD MEMBER FUNCTION getParente RETURN IS tp_pessoa;
/
ALTER TYPE tp_dependente
    ORDER MEMBER FUNCTION comparaDependente(d tp_dependente) RETURN is INTEGER;
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
    MEMBER PROCEDURE exibirDetalhesConta(SELF tp_conta)
) NOT FINAL NOT INSTANTIABLE;
/



-- obj: conta corrente
CREATE OR REPLACE TYPE tp_conta_corrente UNDER tp_conta(
  credito_disponivel NUMBER(10, 2),
  limite_credito NUMBER(10, 2),
  taxa NUMBER(5, 2),
  positivo NUMBER(1),

  OVERRIDING MEMBER PROCEDURE exibirDetalhesConta(SELF tp_conta_corrente)
);
/

ALTER TYPE tp_conta_corrente DROP ATTRIBUTE (positivo);
/

CREATE TYPE BODY tp_conta_corrente AS
    OVERRIDING MEMBER PROCEDURE exibirDetalhesConta(SELF tp_conta) IS
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
-- obj: conta poupanca
CREATE OR REPLACE TYPE tp_conta_poupanca UNDER tp_conta(
    juros_rend NUMBER(5,4),
    
    OVERRIDING MEMBER PROCEDURE exibirDetalhesConta(SELF tp_conta_poupanca)
);
/

CREATE TYPE BODY tp_conta_poupanca AS
    OVERRIDING MEMBER PROCEDURE exibirDetalhesConta(SELF tp_conta) IS
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
             VALUES(SELF, conta_dest, data, horario_transf, valor, "Rejeitado", motivo, auditor);

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


-------------------------------------------------------------------------------



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
)
    NESTED TABLE dependentes STORE AS tb_dependentes_cliente;  
/

CREATE TABLE tb_auditor OF tp_auditor(
    cpf PRIMARY KEY,
    primeiro_nome NOT NULL,
    endereco_numero CHECK (endereco_numero >= 0)
) 
    NESTED TABLE dependentes STORE AS tp_dependentes_auditor; 
/



CREATE OR REPLACE TYPE BODY tp_dependente AS

  ADD MEMBER FUNCTION getParente() RETURN tp_pessoa AS  

  parente_encontrado BOOLEAN := false;
  cpf_atual tp_pessoa.cpf%TYPE;

  cursor cpfs_ntsDependentes is
    ((select cpf, dependentes from tb_cliente)
    union
     (select cpf, dependentes from tb_auditor));

  begin
    -- itera sobre cada dependente de cada cliente de tb_cliente
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


--------------------------------------------------------------------------


-- Povoamento Ativo_financeiro
INSERT INTO tb_ativo_financeiro VALUES (
  tp_ativo_financeiro(
    'Tesouro Selic',
    'Renda fixa'
    )
  );
INSERT INTO tb_ativo_financeiro VALUES (
  tp_ativo_financeiro(
    'CDB', 
    'Renda fixa'
    )
  );
INSERT INTO tb_ativo_financeiro VALUES (
  tp_ativo_financeiro(
    'LCI', 
    'Renda fixa'
    )
  );
INSERT INTO tb_ativo_financeiro VALUES (
  tp_ativo_financeiro(
    'LCA', 
    'Renda fixa'
    )
  );
INSERT INTO tb_ativo_financeiro VALUES (
  tp_ativo_financeiro(
    'Ações', 
    'Renda variável'
    )
  );

SELECT * FROM tb_ativo_financeiro
-- Povoamento: Auxilio
CREATE SEQUENCE auxilio_seq INCREMENT BY 1 START WITH 1;

INSERT INTO tb_auxilio VALUES (
  tp_auxilio(
    auxilio_seq.nextval,
    'Moradia Estudantil'
    )
  );
INSERT INTO tb_auxilio VALUES (
  tp_auxilio(
    auxilio_seq.nextval,
    'Auxílio-Creche'
    )
  );
INSERT INTO tb_auxilio VALUES (
  tp_auxilio(
    auxilio_seq.nextval,
    'Bolsa Família'
    )
  );
INSERT INTO tb_auxilio VALUES (
  tp_auxilio(
    auxilio_seq.nextval,
    'Auxílio Emergencial'
    )
  );
INSERT INTO tb_auxilio VALUES (
  tp_auxilio(
    auxilio_seq.nextval,
    'Auxílio Internet'
    )
  );
INSERT INTO tb_auxilio VALUES (
  tp_auxilio(
    auxilio_seq.nextval,
    'Vale Transporte'
    )
  );

-- Povoamento: Instituição
INSERT INTO tb_instituicao VALUES (
    tp_instituicao(
        '00000993788450',
        'Caixa Econômica Federal',
        TO_DATE('17/12/1902', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_instituicao VALUES (
    tp_instituicao(
        '71954503790463',
        'Universidade Federal de Pernambuco',
        TO_DATE('07/02/1856', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_instituicao VALUES (
    tp_instituicao(
        '22210292435128',
        'Porto Digital', 
        TO_DATE('19/12/2000', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_instituicao VALUES (
    tp_instituicao(
        '18101153985142',
        'VTex', 
        TO_DATE('01/04/2000', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_instituicao VALUES (
    tp_instituicao(
        '51343527479898',
        'Mercadinho Daora', 
        TO_DATE('21/10/2012', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_instituicao VALUES (
    tp_instituicao(
        '46674246944235',
        'Criança Esperança', 
        TO_DATE('23/12/1986', 'DD/MM/YYYY')
    )
);

-- Povoamento: Cliente
INSERT INTO tb_cliente VALUES (
    tp_cliente(
      '001', 
      'Kisho', 
      'Murakami',
      'Inoue', 
      1122, 
      'Perto do templo',
      to_date('07/09/2003', 'dd/mm/yyyy'), 
      tp_cep(
        '001', 
        'Algarobas', 
        'Parnamirim', 
        'Parnamirim', 
        'RN'
        ),
      tp_array_telefone(
        tp_telefone(9338284531), 
        tp_telefone(9351513333)
        ),
      tp_nt_dependentes(
        tp_dependente('Josevan', 'Almir', 'Valerio', 'Pai', to_date('05/04/2002','DD/MM/YYYY'))
        ),
      tp_array_ocupacao(tp_ocupacao('Advogada'))
    )
);

INSERT INTO tb_cliente VALUES (
    tp_cliente(
        '010', 
        'Rosemildo', 
        null,
        'Cambalacho', 
        544, 
        'APT 1501',
        to_date('20/12/1953', 'dd/mm/yyyy'), 
        tp_cep(
            '010', 
            'Rua Professor Damorim', 
            'Don Helder', 
            'Jaboatão dos Guararapes', 
            'PE'),
        tp_array_telefone(
            tp_telefone(44, 38704688),
            tp_telefone(44, 61407254)
        ),
        tp_nt_dependentes(
            tp_dependente(
                'Jacinto', 
                'Perereira', 
                'da Silva', 
                'Avô', 
                to_date('12/12/2000','DD/MM/YYYY')
            )
        ),
        tp_array_ocupacao(
            tp_ocupacao('Medico')
        )
    )
);

INSERT INTO tb_cliente VALUES (
    tp_cliente(
      '462', 
      'Nestor', 
      'Heleno',
      'Ptolomeu', 
      544, 
      'APT 1501',
      to_date('16/01/2000', 'dd/mm/yyyy'), 
      tp_cep(
        '010', 
        'Rua Professor Damorim', 
        'Don Helder', 
        'Jaboatão dos Guararapes', 
        'PE'
        ),
      tp_array_telefone(
        tp_telefone(97, 26346734)
        ),
      tp_nt_dependentes(
        tp_dependente('Flávia', 'Martins', 'Sodré', 'Filha', to_date('05/11/2020','DD/MM/YYYY')),
        tp_dependente('Khalil', 'Sadul', 'Al', 'Irmão', to_date('12/12/1985','DD/MM/YYYY')),
        tp_dependente('José', 'Armando','Canduras', 'Tio', to_date('12/12/2000','DD/MM/YYYY'))
        ),
      tp_array_ocupacao(tp_ocupacao('Professor'))
    )
);

INSERT INTO tb_cliente VALUES (
    tp_cliente(
      '534', 
      'Silvia', 
      'Carlinda',
      'Rogeria', 
      1, 
      null,
      to_date('30/12/1962', 'dd/mm/yyyy'), 
      tp_cep(
        '100', 
        'Rua Doutor Damorim', 
        'Barra de Jangada', 
        'Jaboatão dos Guararapes', 
        'PE'
        ),
      tp_array_telefone(
        tp_telefone(6122897253),
        tp_telefone(6145105597)
        ),
      tp_nt_dependentes(
        tp_dependente('Andra', 'Janes', 'Camilo', 'Filha', to_date('05/11/1992','DD/MM/YYYY')),
        tp_dependente('Balan', 'Clodoaldo', 'Garcia', 'Irmão', to_date('12/03/1930','DD/MM/YYYY')),
        tp_dependente('Severino', 'Elioner', 'Cabral', 'Tio', to_date('12/12/1985','DD/MM/YYYY'))
        ),
      tp_array_ocupacao(tp_ocupacao('Jornalista'))
    )
);

INSERT INTO tb_cliente VALUES (
    tp_cliente(
        '888', 
        'Amora', 
        'Carneiro',
        'Gafanhoto', 
        3, 
        'Chacara dos Sonhos',
        to_date('14/05/1995', 'dd/mm/yyyy'), 
        tp_cep(
            '001', 
            'Algarobas', 
            'Parnamirim', 
            'Parnamirim', 
            'RN'
        ),
        tp_array_telefone(
            tp_telefone(13, 33125636)
        ),
        tp_nt_dependentes(),
        tp_array_ocupacao(tp_ocupacao('Engenheiro'))
    )
);

-- Povoamento: Auditor
INSERT INTO tb_auditor VALUES (
    tp_auditor(
        '594', 
        'Maria', 
        'Pires',
        'Esmeralda', 
        595, 
        'Na roça',
        to_date('04/08/1988', 'dd/mm/yyyy'),
        tp_cep(
            '011', 
            'Rua PhD Damorim', 
            'Pina', 
            'Recife', 
            'PE'
        ),
        tp_array_telefone(
            tp_telefone(82, 37681394),
            tp_telefone(82, 92457943)
        ),
        null,
        133
    )
);

INSERT INTO tb_auditor VALUES (
    tp_auditor(
        '534', 
        'Silvia', 
        'Carlinda',
        'Rogeria', 
        1, 
        null,
        to_date('30/12/1962', 'dd/mm/yyyy'), 
        tp_cep(
            '100', 
            'Rua Doutor Damorim', 
            'Barra de Jangada', 
            'Jaboatão dos Guararapes', 
            'PE'
        ),
        tp_array_telefone(
            tp_telefone(6122897253),
            tp_telefone(6145105597)
        ),
        tp_nt_dependentes(
            tp_dependente('Andra', 'Janes', 'Camilo', 'Filha', to_date('05/11/1992','DD/MM/YYYY')),
            tp_dependente('Balan', 'Clodoaldo', 'Garcia', 'Irmão', to_date('12/03/1930','DD/MM/YYYY')),
            tp_dependente('Severino', 'Elioner', 'Cabral', 'Tio', to_date('12/12/1985','DD/MM/YYYY'))
        ),
        422
    )
);

-- Povoamento: Conta Corrente
/*
  tp_conta_corrente(numero_agencia, 
                    numero_conta, 
                    data_criacao, 
                    nome_banco, 
                    saldo_atual,
                    credito_disponivel,
                    limite_credito,
                    taxa,
                    positivo);
*/
INSERT into tb_conta_corrente VALUES(
    tp_conta_corrente(
        '001', 
        '891756213', 
        TO_DATE('17/12/2014', 'DD/MM/YYYY'), 
        'Banco do Brasil', 
        10000.12,
        3948.23, 
        21000.00, 
        0.8
    )
);

INSERT into tb_conta_corrente VALUES(
    tp_conta_corrente(
        '163', 
        '123432189', 
        TO_DATE('17/04/2020', 'DD/MM/YYYY'), 
        'Banco Inter', 
        3200.37,
        678.50, 
        2000.00, 
        0.2
    )
);

INSERT into tb_conta_corrente VALUES(
    tp_conta_corrente(
        '932', 
        '089375612', 
        TO_DATE('30/09/2019', 'DD/MM/YYYY'), 
        'Nubank', 
        2500.00,
        20.00, 
        5000.00, 
        0.8
    )
);

INSERT INTO tb_conta_corrente VALUES (
  tp_conta_corrente(
    '765',
    '891756213',
    TO_DATE('27/11/2016', 'DD/MM/YYYY'),
    'Banco Inter',
    5430.00,
    1500.00, 
    7000.00, 
    0.6
  )
);

-- Povoamento: Conta Poupanca
/*
tp_conta_poupanca(agencia, conta, data, banco, saldo, juros)
*/
insert into tb_conta_poupanca values(
  tp_conta_poupanca('854', '837917841', TO_DATE('28/05/2010', 'DD/MM/YYYY'), 'Banco do Brasil',    35.12, 0.24),
  tp_conta_poupanca('129', '891756213', TO_DATE('10/06/2018', 'DD/MM/YYYY'), 'Banco Bradesco',    810.75, 0.342),
  tp_conta_poupanca('367', '891756213', TO_DATE('07/02/2012', 'DD/MM/YYYY'), 'Banco Santander', 12111.12, 5.322)
);

-- Povoamento: Movimenta
/*
tp_movimenta(
  (SELECT ref(conta)
  from tb_conta_? conta
  where conta.numero_agencia = '' and conta.numero_conta = ''),
  (SELECT ref(cliente)
  from tb_cliente cliente
  where cliente.cpf = '')
)*/
insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '765' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '534'),
  
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_poupanca conta
    where conta.numero_agencia = '367' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '001'),

  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_poupanca conta
    where conta.numero_agencia = '854' and conta.numero_conta = '837917841'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '001'),
  
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_poupanca conta
    where conta.numero_agencia = '129' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '888'),
  
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_poupanca conta
    where conta.numero_agencia = '129' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '462'),
  
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '001' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '462'),
  
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '001' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '010'),
  
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_poupanca conta
    where conta.numero_agencia = '129' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '010'),
  
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '163' and conta.numero_conta = '123432189'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '010'),
  
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '163' and conta.numero_conta = '123432189'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '462'),

  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '932' and conta.numero_conta = '089375612'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '888'),
    
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '932' and conta.numero_conta = '089375612'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '462'),
);

-- Povoamento: Transfere
/*
    tp_transfere(
      data,
      horario,
      valor,
      status,
      motivo,
      -- conta_orig --
      (SELECT ref(conta)
      from tb_conta_? conta -- ? pode ser poupanca ou corrente
      where conta.numero_agencia = '' 
      and conta.numero_conta = ''),
      -- conta_dest --
      (SELECT ref(conta)
      from tb_conta_? conta -- ? pode ser poupanca ou corrente
      where conta.numero_agencia = '' 
      and conta.numero_conta = ''),
      -- auditor --
      (SELECT ref(aud)
      from tb_auditor
      where aud.cpf = '')
                )
*/
INSERT INTO tb_transfere VALUES(
    tp_transfere(
        TO_DATE('07/02/2020', 'DD/MM/YYYY'), 
        TO_TIMESTAMP('10:13:18', 'HH24:MI:SS'), 
        57.00, 
        'Aceito', 
        'Pix',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '001' 
        and conta.numero_conta = '891756213'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '163' 
        and conta.numero_conta = '123432189'),
        -- auditor --
        null),

    tp_transfere(
        TO_DATE('02/03/2022', 'DD/MM/YYYY'), 
        TO_TIMESTAMP('23:21:19', 'HH24:MI:SS'), 
        300.00, 
        'Aceito', 
        'Pix',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '001' 
        and conta.numero_conta = '891756213'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '163' 
        and conta.numero_conta = '123432189'),
        -- auditor --
        null),
  
    tp_transfere(
        TO_DATE('23/02/2022', 'DD/MM/YYYY'),
        TO_TIMESTAMP('12:45:18', 'HH24:MI:SS'),
        30.00,
        'Aceito',
        'TED',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_poupanca conta 
        where conta.numero_agencia = '129' 
        and conta.numero_conta = '891756213'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_poupanca conta 
        where conta.numero_agencia = '854' 
        and conta.numero_conta = '837917841'),
        -- auditor --
        null),
    
    tp_transfere(
        TO_DATE('03/02/2021', 'DD/MM/YYYY'),
        TO_TIMESTAMP('14:30:00', 'HH24:MI:SS'),
        10000.00,
        'Não concluída',
        'TED',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_poupanca conta 
        where conta.numero_agencia = '367' 
        and conta.numero_conta = '891756213'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_poupanca conta 
        where conta.numero_agencia = '854' 
        and conta.numero_conta = '837917841'),
        -- auditor --
        (SELECT ref(aud)
        from tb_auditor
        where aud.cpf = '594')
        ),
    
    tp_transfere(
        TO_DATE('25/03/2022', 'DD/MM/YYYY'),
        TO_TIMESTAMP('16:57:25', 'HH24:MI:SS'),
        70.00,
        'Não concluída',
        'Pix',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '163' 
        and conta.numero_conta = '123432189'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '932' 
        and conta.numero_conta = '089375612'),
        -- auditor --
        null),
    
    tp_transfere(
        TO_DATE('05/03/2022', 'DD/MM/YYYY'),
        TO_TIMESTAMP('09:28:05', 'HH24:MI:SS'),
        57.00,
        'Aceito',
        'Pix',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '932' 
        and conta.numero_conta = '089375612'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '163' 
        and conta.numero_conta = '123432189'),
        -- auditor --
        null),
    
    tp_transfere(
        TO_DATE('07/02/2022', 'DD/MM/YYYY'),
        TO_TIMESTAMP('10:13:18', 'HH24:MI:SS'),
        100000.00,
        'Rejeitado',
        'Pix',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '001' 
        and conta.numero_conta = '891756213'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '163' 
        and conta.numero_conta = '123432189'),
        -- auditor --
        (SELECT ref(aud)
        from tb_auditor
        where aud.cpf = '534')
        ),
    
    tp_transfere(
        TO_DATE('02/03/2021', 'DD/MM/YYYY'),
        TO_TIMESTAMP('23:30:19', 'HH24:MI:SS'),
        25342.00,
        'Aceito',
        'Pix',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '001' 
        and conta.numero_conta = '891756213'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '932' 
        and conta.numero_conta = '089375612'),
        -- auditor --
        (SELECT ref(aud)
        from tb_auditor
        where aud.cpf = '534')
        ),
    
    tp_transfere(
        TO_DATE('23/11/2022', 'DD/MM/YYYY'),
        TO_TIMESTAMP('12:11:40', 'HH24:MI:SS'),
        323.00,
        'Rejeitado',
        'TED',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_poupanca conta 
        where conta.numero_agencia = '129' 
        and conta.numero_conta = '891756213'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_poupanca conta 
        where conta.numero_agencia = '854' 
        and conta.numero_conta = '837917841'),
        -- auditor --
        null),
    
    tp_transfere(
        TO_DATE('01/03/2022', 'DD/MM/YYYY'),
        TO_TIMESTAMP('10:14:41', 'HH24:MI:SS'),
        572.00,
        'Rejeitado',
        'TED',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '001' 
        and conta.numero_conta = '891756213'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '163' 
        and conta.numero_conta = '123432189'),
        -- auditor --
        null),
    
    tp_transfere(
        TO_DATE('21/04/2022', 'DD/MM/YYYY'),
        TO_TIMESTAMP('09:22:23', 'HH24:MI:SS'),
        3.00,
        'Não concluída',
        'PIX',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_poupanca conta 
        where conta.numero_agencia = '129' 
        and conta.numero_conta = '891756213'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_corrente conta 
        where conta.numero_agencia = '932' 
        and conta.numero_conta = '089375612'),
        -- auditor --
        null),
    
    tp_transfere(
        TO_DATE('22/07/2022', 'DD/MM/YYYY'),
        TO_TIMESTAMP('13:05:55', 'HH24:MI:SS'),
        332333.00,
        'Aceito',
        'TED',
        -- conta_orig --
        (SELECT ref(conta)
        from tb_conta_poupanca conta 
        where conta.numero_agencia = '367' 
        and conta.numero_conta = '891756213'),
        -- conta_dest --
        (SELECT ref(conta)
        from tb_conta_poupanca conta 
        where conta.numero_agencia = '854' 
        and conta.numero_conta = '837917841'),
        -- auditor --
        (SELECT ref(aud)
        from tb_auditor
        where aud.cpf = '534')
        )
);

-- Povoamento: Investe em
/* 
    TO_TIMESTAMP('12:11:40', 'HH24:MI:SS')   
    cliente REF tp_cliente,
    ativo_financeiro REF tp_ativo_financeiro,
    conta_corrente REF tp_conta_corrente,
    data_inicio DATE,
    hora_inicio TIMESTAMP,
    valor_mensal_investido NUMBER(7,2)
 */
INSERT INTO tb_investe_em VALUES (
  tp_investe_em(
    (SELECT REF(C) FROM tb_cliente C WHERE C.cpf = '462'),
    (SELECT REF(A) FROM tb_ativo_financeiro A WHERE A.nome = 'Tesouro Selic'),
    (SELECT REF(CC) FROM tb_conta_corrente CC WHERE CC.numero_agencia = '001' AND CC.numero_conta = '891756213'),
    TO_DATE('15/05/2012', 'DD/MM/YYYY'),
    TO_TIMESTAMP('12:23:52', 'HH24:MI:SS'),
    57.00
  )
);
INSERT INTO tb_investe_em VALUES (
  tp_investe_em(
    (SELECT REF(C) FROM tb_cliente C WHERE C.cpf = '462'),
    (SELECT REF(A) FROM tb_ativo_financeiro A WHERE A.nome = 'Tesouro Selic'),
    (SELECT REF(CC) FROM tb_conta_corrente CC WHERE CC.numero_agencia = '163' AND CC.numero_conta = '123432189'),
    TO_DATE('31/01/2001', 'DD/MM/YYYY'),
    TO_TIMESTAMP('10:21:03', 'HH24:MI:SS'),
    102.00
  )
);
INSERT INTO tb_investe_em VALUES (
  tp_investe_em(
    (SELECT REF(C) FROM tb_cliente C WHERE C.cpf = '462'),
    (SELECT REF(A) FROM tb_ativo_financeiro A WHERE A.nome = 'CDB'),
    (SELECT REF(CC) FROM tb_conta_corrente CC WHERE CC.numero_agencia = '001' AND CC.numero_conta = '891756213'),
    TO_DATE('15/05/2012', 'DD/MM/YYYY'),
    TO_TIMESTAMP('12:23:52', 'HH24:MI:SS'),
    532.30
  )
);
INSERT INTO tb_investe_em VALUES (
  tp_investe_em(
    (SELECT REF(C) FROM tb_cliente C WHERE C.cpf = '010'),
    (SELECT REF(A) FROM tb_ativo_financeiro A WHERE A.nome = 'Ações'),
    (SELECT REF(CC) FROM tb_conta_corrente CC WHERE CC.numero_agencia = '163' AND CC.numero_conta = '123432189'),
    TO_DATE('15/05/2012', 'DD/MM/YYYY'),
    TO_TIMESTAMP('12:23:52', 'HH24:MI:SS'),
     72.50
  )
);
INSERT INTO tb_investe_em VALUES (
  tp_investe_em(
    (SELECT REF(C) FROM tb_cliente C WHERE C.cpf = '010'),
    (SELECT REF(A) FROM tb_ativo_financeiro A WHERE A.nome = 'LCI'),
    (SELECT REF(CC) FROM tb_conta_corrente CC WHERE CC.numero_agencia = '163' AND CC.numero_conta = '123432189'),
    TO_DATE('18/03/2021', 'DD/MM/YYYY'),
    TO_TIMESTAMP('14:32:59', 'HH24:MI:SS'),
    123.30
  )
);
INSERT INTO tb_investe_em VALUES (
  tp_investe_em(
    (SELECT REF(C) FROM tb_cliente C WHERE C.cpf = '010'),
    (SELECT REF(A) FROM tb_ativo_financeiro A WHERE A.nome = 'LCA'),
    (SELECT REF(CC) FROM tb_conta_corrente CC WHERE CC.numero_agencia = '163' AND CC.numero_conta = '123432189'),
    TO_DATE('01/12/2000', 'DD/MM/YYYY'),
    TO_TIMESTAMP('12:23:52', 'HH24:MI:SS'),
    72.50
  )
);

-- POVOAMENTO Oferece Auxilio
/*
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta m WHERE mov.numero_agencia = '' and mov.numero_conta = ''),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod = 'xxxxx'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = ''),
        xx,
        TO_DATE('','DD/MM/YYYY')
        
*/
INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta m 
            WHERE mov.cpf = '001' mov.numero_agencia = '367' and mov.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod = '1'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '00000993788450'),
        500.00,
        TO_DATE('17/09/2020', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta m 
            WHERE mov.cpf = '462' AND mov.numero_agencia = '129' AND mov.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod = '2'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '71954503790463'),
        1000.00,
        TO_DATE('10/02/2020', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta m 
            WHERE mov.cpf = '888' AND mov.numero_agencia = '932' AND mov.numero_conta = '089375612'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod = '4'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '00000993788450'),
        700.00,
       TO_DATE('05/12/2021', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta m 
            WHERE mov.cpf = '462' AND mov.numero_agencia = '932' AND mov.numero_conta = '089375612'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod = '3'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '71954503790463'),
        10000.00,
        TO_DATE('01/01/2014', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta m 
            WHERE mov.cpf = '010' AND mov.numero_agencia = '001' AND mov.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod = '3'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '22210292435128'),
        150.00,
        TO_DATE('01/01/2010', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta m 
            WHERE mov.cpf = '001' AND mov.numero_agencia = '367' AND mov.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod = '5'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '22210292435128'),
        300.00,
        TO_DATE('04/08/2020', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta m 
            WHERE mov.cpf = '001' AND mov.numero_agencia = '129' AND mov.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod = '1'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '71954503790463'),
        1000.00,
        TO_DATE('27/02/2002', 'DD/MM/YYYY'))
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta m 
            WHERE mov.cpf = '462' AND mov.numero_agencia = '001' AND mov.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod = '6'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '71954503790463'),
        100.00,
       TO_DATE('01/01/2022', 'DD/MM/YYYY'))
    )
);

--insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio) values 
--('010', '001', '891756213', '22210292435128', 3, 150.00, TO_DATE('01/01/2010', 'DD/MM/YYYY'));
INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta m 
            WHERE mov.cpf = '010' AND mov.numero_agencia = '001' AND mov.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod = '5'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '22210292435128'),
        150.00,
        TO_DATE('01/01/2010', 'DD/MM/YYYY')
    )
);


