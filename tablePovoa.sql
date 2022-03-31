
-- Povoamento Ativo_financeiro
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('Tesouro Selic', 'Renda fixa');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('CDB', 'Renda fixa');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('LCI', 'Renda fixa');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('LCA', 'Renda fixa');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('Ações', 'Renda variável');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('Fundos de investimento', 'Renda variável');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('Fundos imobiliários', 'Renda variável');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('ETF', 'Renda variável');


-- Povoamento: Auxilio
CREATE SEQUENCE auxilio_seq INCREMENT BY 1 START WITH 1;

INSERT INTO Auxilio(cod_auxilio, nome_auxilio) VALUES (auxilio_seq.nextval,'Moradia Estudantil');
INSERT INTO Auxilio(cod_auxilio, nome_auxilio) VALUES (auxilio_seq.nextval,'Auxílio-Creche');
INSERT INTO Auxilio(cod_auxilio, nome_auxilio) VALUES (auxilio_seq.nextval,'Bolsa Família');
INSERT INTO Auxilio(cod_auxilio, nome_auxilio) VALUES (auxilio_seq.nextval,'Auxílio Emergencial');
INSERT INTO Auxilio(cod_auxilio, nome_auxilio) VALUES (auxilio_seq.nextval,'Auxílio Internet');
INSERT INTO Auxilio(cod_auxilio, nome_auxilio) VALUES (auxilio_seq.nextval,'Vale Transporte');

/* Povoamento: Instituição*/
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('00000993788450', 'Caixa Econômica Federal', TO_DATE('17/12/1902', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('71954503790463', 'Universidade Federal de Pernambuco', TO_DATE('07/02/1856', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('22210292435128', 'Porto Digital', TO_DATE('19/12/2000', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('18101153985142', 'VTex', TO_DATE('01/04/2000', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('51343527479898', 'Mercadinho Daora', TO_DATE('21/10/2012', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('46674246944235', 'Criança Esperança', TO_DATE('23/12/1986', 'DD/MM/YYYY'));

-- Povoamento: CEP
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('001', 'Algarobas', 'Parnamirim', 'Parnamirim', 'RN');
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('010', 'Rua Professor Damorim', 'Don Helder', 'Jaboatão dos Guararapes', 'PE');
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('100', 'Rua Doutor Damorim', 'Barra de Jangada', 'Jaboatão dos Guararapes', 'PE');
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('011', 'Rua PhD Damorim', 'Pina', 'Recife', 'PE');
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('100', 'Rua Damorim', 'Cidade Universitária', 'Recife', 'PE');
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('101', 'Rua pasg', 'Saint-Cloud', 'Paris', 'Región Parisiana');

-- Povoamento: Pessoaa
INSERT INTO PESSOA(cpf, primeiro_nome, sobrenomes_centrais,
                   ultimo_nome, endereco_numero, endereco_complemento,
                   data_nasc, cep)
    VALUES ('001', 'Kisho', 'Murakami',
            'Inoue', 1122, 'Perto do templo',
             to_date('07/09/2003', 'dd/mm/yyyy'), '001');
        
INSERT INTO PESSOA
    VALUES ('010', 'Rosemildo', null,
            'Cambalacho', 544, 'APT 1501',
            to_date('20/12/1953', 'dd/mm/yyyy'), '010');

INSERT INTO PESSOA
    VALUES ('462', 'Nestor', 'Heleno',
            'Ptolomeu', 544, 'APT 1501',
            to_date('16/01/2000', 'dd/mm/yyyy'), '010');

INSERT INTO PESSOA
    VALUES ('594', 'Maria', 'Pires',
            'Esmeralda', 595, 'Na roça',
            to_date('04/08/1988', 'dd/mm/yyyy'), '011');

INSERT INTO PESSOA
    VALUES ('534', 'Silvia', 'Carlinda',
            'Rogeria', 1, null,
            to_date('30/12/1962', 'dd/mm/yyyy'), '100');

INSERT INTO PESSOA
    VALUES ('888', 'Amora', 'Carneiro',
            'Gafanhoto', 3, 'Chacara dos Sonhos',
            to_date('14/05/1995', 'dd/mm/yyyy'), '001');


-- Povoamento: Cliente
insert into Cliente(cpf) values ('001');
insert into Cliente(cpf) values ('010');
insert into Cliente(cpf) values ('462');
insert into Cliente(cpf) values ('888');

-- Povoamento: Auditor
insert into Auditor(cpf, Tempo_serv) values ('594', 133);
insert into Auditor(cpf, Tempo_serv) values ('534', 422);

-- Povoamento: Telefone
insert into Telefone(cpf_origem, telefone) values ('001', '(93) 3828-4531');
insert into Telefone(cpf_origem, telefone) values ('010', '(44) 3870-4688');
insert into Telefone(cpf_origem, telefone) values ('462', '(97) 2634-6734');
insert into Telefone(cpf_origem, telefone) values ('888', '(13) 3312-5636');
insert into Telefone(cpf_origem, telefone) values ('594', '(82) 3768-1394');
insert into Telefone(cpf_origem, telefone) values ('534', '(61) 2289-7253');

insert into Telefone(cpf_origem, telefone) values ('010', '(44) 6140-7254');
insert into Telefone(cpf_origem, telefone) values ('594', '(82) 5689-7491');
insert into Telefone(cpf_origem, telefone) values ('534', '(61) 4510-5597');
insert into Telefone(cpf_origem, telefone) values ('594', '(82) 9245-7943');  

-- Povoamento: Ocupação
insert into Ocupacao(cpf_origem, ocupacao) values ('001', 'Advogada');
insert into Ocupacao(cpf_origem, ocupacao) values ('010', 'Medico');
insert into Ocupacao(cpf_origem, ocupacao) values ('462', 'Professor');
insert into Ocupacao(cpf_origem, ocupacao) values ('888', 'Engenheiro');
insert into Ocupacao(cpf_origem, ocupacao) values ('462', 'Dentista');

-- Povoamento: Conta
insert into Conta(numero_agencia, numero_conta, data_criacao, nome_banco, saldo_atual)
    values ('001', '891756213', TO_DATE('17/12/2014', 'DD/MM/YYYY'), 'Banco do Brasil', 10000.12);

insert into Conta(numero_agencia, numero_conta, data_criacao, nome_banco, saldo_atual) 
    values ('163', '123432189', TO_DATE('17/04/2020', 'DD/MM/YYYY'), 'Banco Inter', 3200.37);

insert into Conta(numero_agencia, numero_conta, data_criacao, nome_banco, saldo_atual) 
    values ('932', '089375612', TO_DATE('30/09/2019', 'DD/MM/YYYY'), 'Nubank', 2500.00);

insert into Conta(numero_agencia, numero_conta, data_criacao, nome_banco, saldo_atual) 
    values ('854', '837917841', TO_DATE('28/05/2010', 'DD/MM/YYYY'), 'Banco do Brasil', 35.12);

insert into Conta(numero_agencia, numero_conta, data_criacao, nome_banco, saldo_atual) 
    values ('129', '891756213', TO_DATE('10/06/2018', 'DD/MM/YYYY'), 'Banco Bradesco', 810.75);

insert into Conta(numero_agencia, numero_conta, data_criacao, nome_banco, saldo_atual) 
    values ('367', '891756213', TO_DATE('07/02/2012', 'DD/MM/YYYY'), 'Banco Santander', 12111.12);

-- Povoamento: ContaCorrente
insert into Conta_Corrente(numero_agencia, numero_conta, credito_disponivel, limite_credito, taxa, positivo)
    values ('001', '891756213', 3948.23, 21000.00, 0.8, 1);
insert into Conta_Corrente(numero_agencia, numero_conta, credito_disponivel, limite_credito, taxa, positivo)
    values ('163', '123432189', 678.50, 2000.00, 0.2, 1);
insert into Conta_Corrente(numero_agencia, numero_conta, credito_disponivel, limite_credito, taxa, positivo)
    values ('932', '089375612', 20.00, 5000.00, 0.8, 0);

-- Povoamento: ContaPoupanca
insert into Conta_Poupanca(numero_agencia, numero_conta, juros_rend)
    values ('854', '837917841', 0.24);
    
insert into Conta_Poupanca(numero_agencia, numero_conta, juros_rend)
    values ('129', '891756213', 0.342);

insert into Conta_Poupanca(numero_agencia, numero_conta, juros_rend)
    values ('367', '891756213', 5.322);

-- Povoamento: Movimenta
insert into Movimenta(numero_agencia, numero_conta, cpf) values ('367', '891756213', '001');
insert into Movimenta(numero_agencia, numero_conta, cpf) values ('854', '837917841', '001');
insert into Movimenta(numero_agencia, numero_conta, cpf) values ('129', '891756213', '888');
insert into Movimenta(numero_agencia, numero_conta, cpf) values ('129', '891756213', '462' );
insert into Movimenta(numero_agencia, numero_conta, cpf) values ('001', '891756213', '462');
insert into Movimenta(numero_agencia, numero_conta, cpf) values ('001', '891756213', '010');
insert into Movimenta(numero_agencia, numero_conta, cpf) values ('129', '891756213', '001');
insert into Movimenta(numero_agencia, numero_conta, cpf) values ('163', '123432189', '010');
insert into Movimenta(numero_agencia, numero_conta, cpf) values ('163', '123432189', '462');
insert into Movimenta(numero_agencia, numero_conta, cpf) values ('932', '089375612', '888');
insert into Movimenta(numero_agencia, numero_conta, cpf) values ('932', '089375612', '462');

-- Povoamento: Transfere
insert into Transfere(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) 
    values (TO_DATE('07/02/2020', 'DD/MM/YYYY'), TO_TIMESTAMP('10:13:18', 'HH:MI:SS'), 57.00, 'Aceito', 'Pix', '001', '891756213', '163', '123432189', null);

insert into Transfere(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) 
    values (TO_DATE('02/03/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('23:21:19', 'HH:MI:SS'), 300.00, 'Aceito', 'Pix', '001', '891756213', '932', '089375612', null);

insert into Transfere(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) 
    values (TO_DATE('23/02/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('12:45:18', 'HH:MI:SS'), 30.00, 'Aceito', 'TED', '129', '891756213', '854', '837917841', null);

insert into Transfere(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) 
    values (TO_DATE('03/02/2021', 'DD/MM/YYYY'), TO_TIMESTAMP('14:30:00', 'HH:MI:SS'), 10000.00, 'Não concluída', 'TED', '367', '891756213', '854', '837917841', '594');

insert into Transfere(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) 
    values (TO_DATE('25/03/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('16:57:25', 'HH:MI:SS'), 70.00, 'Não concluída', 'Pix', '163', '123432189', '932', '089375612', null);

insert into Transfere(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) 
    values (TO_DATE('05/03/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('09:28:05', 'HH:MI:SS'), 57.00, 'Aceito', 'Pix', '932', '089375612', '163', '123432189', null);

-- Povoamento: Conta Investe em
insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta) 
    value (TO_DATE('05/10/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('09:28:05', 'HH:MI:SS'), 57.00, 'NFT SCAM', '367', '891756213');

insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta)
    value (TO_DATE('31/01/2001', 'DD/MM/YYYY'), TO_TIMESTAMP('10:21:03', 'HH:MI:SS'), 102.00, 'BIT CONNECT', '163', '123432189');
 
insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta)
    value (TO_DATE('23/02/2002', 'DD/MM/YYYY'), TO_TIMESTAMP('11:40:23', 'HH:MI:SS'), 521.00, 'SilkRoad', '163', '123432189');
 
insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta)
    value (TO_DATE('15/05/2012', 'DD/MM/YYYY'), TO_TIMESTAMP('12:23:52', 'HH:MI:SS'), 532.30, 'Gamespot', '367', '891756213');
 
insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta)
    value (TO_DATE('18/03/2021', 'DD/MM/YYYY'), TO_TIMESTAMP('14:32:59', 'HH:MI:SS'), 123.30, 'MacroHard', '932', '089375612');
 
insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta)
    value (TO_DATE('01/12/2000', 'DD/MM/YYYY'), TO_TIMESTAMP('15:03:00', 'HH:MI:SS'), 72.50, 'IboAbelha', '367', '891756213');
 
-- Povoamento: Investe em
insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf)
    values ('Tesouro Selic','001', '891756213', '462');

insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf)
    values ('Tesouro Selic','163', '123432189', '462');

insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf)
    values ('CDB','001', '891756213', '462');

insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf)
    values ('Ações','163', '123432189','010');

insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf)
    values ('LCI','163', '123432189','010');

insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf)
    values ('LCA','163', '123432189','010');

insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf)
    values ('Fundos de investimento','001', '891756213', '462');

insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf)
    values ('Fundos imobiliários', '001', '891756213', '462');

insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf)
    values ('ETF','163', '123432189','010');

-- Povoamento: Oferece auxilio
insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio)
    values ('001', '367', '891756213', '00000993788450', 1, 500.00, TO_DATE('17/09/2020', 'DD/MM/YYYY'));

insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio)
    values ('462', '129', '891756213', '71954503790463', 2, 1000.00, TO_DATE('10/02/2020', 'DD/MM/YYYY'));

insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio)
    values ('888','932', '089375612', '00000993788450', 4, 700.00, TO_DATE('05/12/2021', 'DD/MM/YYYY'));

insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio)
    values ('462', '932', '089375612', '71954503790463', 3, 10000.00, TO_DATE('01/01/2014', 'DD/MM/YYYY'));

insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio)
    values ('010', '001', '891756213', '22210292435128', 3, 150.00, TO_DATE('01/01/2010', 'DD/MM/YYYY'));

insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio)
    values ('001','129', '891756213', '71954503790463',1, 1000.00, TO_DATE('27/02/2002', 'DD/MM/YYYY'));

insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio)
    values ('001','367', '891756213', '22210292435128', 5, 300.00, TO_DATE('04/08/2020', 'DD/MM/YYYY'));

insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio)
    values ('462', '001', '891756213', '71954503790463',6, 100.00, TO_DATE('01/01/2022', 'DD/MM/YYYY'));


-- Povoamento: Dependente
insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc)
    values ('001', 'Josevan', 'Almir', 'Valerio', 'Pai', to_date('05/04/2002','DD/MM/YYYY'));

insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc)
    values ('010', 'Jacinto', 'Perereira', 'da Silva', 'Avô', to_date('12/12/2000','DD/MM/YYYY'));
    
insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc)
    values ('462', 'Khalil', 'Sadul', 'Al', 'Irmão', to_date('12/12/1985','DD/MM/YYYY'));

insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc)
    values ('462', 'José', 'Armando','Canduras', 'Tio', to_date('12/12/2000','DD/MM/YYYY'));

insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc)
    values ('534', 'Balan', 'Clodoaldo', 'Garcia', 'Irmão', to_date('12/03/1930','DD/MM/YYYY'));

insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc)
    values ('534', 'Severino', 'Elioner', 'Cabral', 'Tio', to_date('12/12/1985','DD/MM/YYYY'));

