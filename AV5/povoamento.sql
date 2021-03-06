-- INSERT INTO
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
/

--Povoamento: tb_relac_dependente_pessoa
INSERT INTO tb_relac_dependente_pessoa VALUES(
    '001',
    tp_nt_dependentes(
        tp_dependente('Josevan', 'Almir', 'Valerio', 'Pai', to_date('05/04/2002','DD/MM/YYYY'))
    )
);
/
INSERT INTO tb_relac_dependente_pessoa VALUES(
    '010',
    tp_nt_dependentes(
            tp_dependente(
                'Jacinto', 
                'Perereira', 
                'da Silva', 
                'Avô', 
                to_date('12/12/2000','DD/MM/YYYY')
            )
        )
);
/
INSERT INTO tb_relac_dependente_pessoa VALUES(
    '462',
    tp_nt_dependentes(
        tp_dependente('Flávia', 'Martins', 'Sodré', 'Filha', to_date('05/11/2020','DD/MM/YYYY')),
        tp_dependente('Khalil', 'Sadul', 'Al', 'Irmão', to_date('12/12/1985','DD/MM/YYYY')),
        tp_dependente('José', 'Armando','Canduras', 'Tio', to_date('12/12/2000','DD/MM/YYYY'))
    )
);
/
INSERT INTO tb_relac_dependente_pessoa VALUES(
    '534',
     tp_nt_dependentes(
        tp_dependente('Andra', 'Janes', 'Camilo', 'Filha', to_date('05/11/1992','DD/MM/YYYY')),
        tp_dependente('Balan', 'Clodoaldo', 'Garcia', 'Irmão', to_date('12/03/1930','DD/MM/YYYY')),
        tp_dependente('Severino', 'Elioner', 'Cabral', 'Tio', to_date('12/12/1985','DD/MM/YYYY'))
     )
);
/
INSERT INTO tb_relac_dependente_pessoa VALUES(
    '888',
    tp_nt_dependentes()
);
/
INSERT INTO tb_relac_dependente_pessoa VALUES(
    '594',
    NULL
);
/

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
        422
    )
);

-- Povoamento: Conta Corrente
INSERT into tb_conta_corrente VALUES(
    tp_conta_corrente(
        '001', 
        '891756213', 
        TO_DATE('17/12/2014', 'DD/MM/YYYY'), 
        'Banco do Brasil', 
        10000.12,
        3948.23, 
        21000.00, 
        0.8,
        1
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
        0.2,
        0
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
        0.8,
        1
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
    0.6,
    1
  )
);

-- Povoamento: Conta Poupanca
insert into tb_conta_poupanca values(
  tp_conta_poupanca('854', '837917841', TO_DATE('28/05/2010', 'DD/MM/YYYY'), 'Banco do Brasil',    35.12, 0.24)
);
/
insert into tb_conta_poupanca values(
  tp_conta_poupanca('129', '891756213', TO_DATE('10/06/2018', 'DD/MM/YYYY'), 'Banco Bradesco',    810.75, 0.342)
);
/
insert into tb_conta_poupanca values(
  tp_conta_poupanca('367', '891756213', TO_DATE('07/02/2012', 'DD/MM/YYYY'), 'Banco Santander', 12111.12, 5.322)
);
/

-- Povoamento: Movimenta
insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '765' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '534'))
);
/

insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_poupanca conta
    where conta.numero_agencia = '367' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '001'))
);
/

insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_poupanca conta
    where conta.numero_agencia = '854' and conta.numero_conta = '837917841'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '001'))
);
/

insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_poupanca conta
    where conta.numero_agencia = '129' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '888'))
);
/

insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_poupanca conta
    where conta.numero_agencia = '129' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '462'))
);
/

insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '001' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '462'))
);
/

insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '001' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '010'))
);
/

insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_poupanca conta
    where conta.numero_agencia = '129' and conta.numero_conta = '891756213'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '010'))
);
/

insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '163' and conta.numero_conta = '123432189'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '010'))
);
/

insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '163' and conta.numero_conta = '123432189'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '462'))
);
/

insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '932' and conta.numero_conta = '089375612'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '888'))
);
/

insert into tb_movimenta values(
  tp_movimenta(
    (SELECT ref(conta)
    from tb_conta_corrente conta
    where conta.numero_agencia = '932' and conta.numero_conta = '089375612'),
    (SELECT ref(cliente)
    from tb_cliente cliente
    where cliente.cpf = '462'))
);
/

-- Povoamento: Transfere
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
        null) 
);
/

INSERT INTO tb_transfere VALUES(
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
        null)
);
/

    INSERT INTO tb_transfere VALUES(
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
        null)
);
/

INSERT INTO tb_transfere VALUES(
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
        from tb_auditor aud
        where aud.cpf = '594')
        )
);
/

INSERT INTO tb_transfere VALUES(
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
        null)
);
/

INSERT INTO tb_transfere VALUES(
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
        null)
);
/

INSERT INTO tb_transfere VALUES(
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
        from tb_auditor aud
        where aud.cpf = '534')
        )
);
/

INSERT INTO tb_transfere VALUES(
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
        from tb_auditor aud
        where aud.cpf = '534')
        )
);
/

INSERT INTO tb_transfere VALUES(
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
        null)
);
/

INSERT INTO tb_transfere VALUES(
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
        null)
);
/

INSERT INTO tb_transfere VALUES(
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
        null)
);
/

INSERT INTO tb_transfere VALUES(
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
        from tb_auditor aud
        where aud.cpf = '534')
        )
);
/

-- Povoamento: Investe em
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
INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta mov 
            WHERE mov.cliente.cpf = '001' AND mov.conta.numero_agencia = '367' and mov.conta.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod_auxilio = '1'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '00000993788450'),
        500.00,
        TO_DATE('17/09/2020', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta mov 
            WHERE mov.cliente.cpf = '462' AND mov.conta.numero_agencia = '129' AND mov.conta.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod_auxilio = '2'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '71954503790463'),
        1000.00,
        TO_DATE('10/02/2020', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta mov 
            WHERE mov.cliente.cpf = '888' AND mov.conta.numero_agencia = '932' AND mov.conta.numero_conta = '089375612'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod_auxilio = '4'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '00000993788450'),
        700.00,
       TO_DATE('05/12/2021', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta mov 
            WHERE mov.cliente.cpf = '462' AND mov.conta.numero_agencia = '932' AND mov.conta.numero_conta = '089375612'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod_auxilio = '3'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '71954503790463'),
        10000.00,
        TO_DATE('01/01/2014', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta mov 
            WHERE mov.cliente.cpf = '010' AND mov.conta.numero_agencia = '001' AND mov.conta.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod_auxilio = '3'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '22210292435128'),
        150.00,
        TO_DATE('01/01/2010', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta mov 
            WHERE mov.cliente.cpf = '001' AND mov.conta.numero_agencia = '367' AND mov.conta.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod_auxilio = '5'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '22210292435128'),
        300.00,
        TO_DATE('04/08/2020', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta mov 
            WHERE mov.cliente.cpf = '001' AND mov.conta.numero_agencia = '854' AND mov.conta.numero_conta = '837917841'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod_auxilio = '1'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '71954503790463'),
        1000.00,
        TO_DATE('27/02/2002', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta mov
            WHERE mov.cliente.cpf = '462' AND mov.conta.numero_agencia = '001' AND mov.conta.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod_auxilio = '6'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '71954503790463'),
        100.00,
       TO_DATE('01/01/2022', 'DD/MM/YYYY')
    )
);

INSERT INTO tb_oferece_auxilio VALUES (
    tp_oferece_auxilio(
        (SELECT REF(mov) FROM tb_movimenta mov
            WHERE mov.cliente.cpf = '010' AND mov.conta.numero_agencia = '001' AND mov.conta.numero_conta = '891756213'),
        (SELECT REF(aux) FROM tb_auxilio aux WHERE aux.cod_auxilio = '5'),
        (SELECT REF(ins) FROM tb_instituicao ins WHERE ins.cnpj = '22210292435128'),
        150.00,
        TO_DATE('01/01/2010', 'DD/MM/YYYY')
    )
);
