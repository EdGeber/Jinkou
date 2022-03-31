
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

CREATE SEQUENCE auxilio_seq INCREMENT BY 1 START WITH 1

INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Moradia Estudantil');
INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Auxílio-Creche');
INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Bolsa Família');
INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Auxílio Emergencial');
INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Auxílio Internet');
INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Vale Transporte');

/* Povoamento: Instituição*/
-- mudar
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('00000993788450', 'Caixa Econômica Federal', TO_DATE('17/12/1902', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('71954503790463', 'Universidade Federal de Pernambuco', TO_DATE('07/02/1856', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('22210292435128', 'Porto Digital', TO_DATE('19/12/2000', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('18101153985142', 'VTex', TO_DATE('01/04/2000', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('51343527479898', 'Mercadinho Daora', TO_DATE('21/10/2006', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('46674246944235', 'Criança Esperança', TO_DATE('23/12/1986', 'DD/MM/YYYY'));

-- https://www.namegenerator.co/

-- Povoamento: CEP
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('001', 'Algarobas', 'Parnamirim', 'Parnamirim', 'RN');
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('010', 'Rua Professor Damorim', 'Don Helder', 'Jaboatão dos Guararapes', 'PE');
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('100', 'Rua Doutor Damorim', 'Barra de Jangada', 'Jaboatão dos Guararapes', 'PE');
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('011', 'Rua PhD Damorim', 'Pina', 'Recife', 'PE');
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('100', 'Rua Damorim', 'Cidade Universitária', 'Recife', 'PE');
INSERT INTO CEP (cep, rua, bairro, cidade, estado) VALUES ('101', 'Rua pasg', 'Saint-Cloud', 'Paris', 'Región Parisiana');

-- Povoamento: Pessoa
INSERT INTO PESSOA(cpf, primeiro_nome, sobrenomes_centrais, ultimos_nomes, endereco_numero, endereco_complemento, data_nasc, cep)
    VALUES ('001', 'Kisho', 'Murakami', 'Inoue', 1122, 'Perto do templo',  to_date('07/09/2003', 'dd/mm/yyyy'), '001');
        
INSERT INTO PESSOA(cpf, primeiro_nome, ultimos_nomes, endereco_numero, endereco_complemento, data_nasc, cep)
    VALUES ('010', 'Rosemildo', 'Cambalacho', 544, 'APT 1501', to_date('20/12/1953', 'dd/mm/yyyy'), '010');

INSERT INTO PESSOA(cpf, primeiro_nome, sobrenomes_centrais, ultimos_nomes, endereco_numero, endereco_complemento, data_nasc, cep)
    VALUES ('462', 'Nestor', 'Heleno', 'Ptolomeu', 544, 'APT 201', to_date('16/01/2000', 'dd/mm/yyyy'), '010');

INSERT INTO PESSOA(cpf, primeiro_nome, ultimos_nomes, endereco_numero, data_nasc, cep)
    VALUES ('594', 'Maria', 'Esmeralda', 595, to_date('04/08/1988', 'dd/mm/yyyy'), '011');

INSERT INTO PESSOA(cpf, primeiro_nome, sobrenomes_centrais, ultimos_nomes, endereco_numero, data_nasc, cep)
    VALUES ('534', 'Silvia', 'Carlinda', 'Rogeria', 1, to_date('30/12/1962', 'dd/mm/yyyy'), '100');

INSERT INTO PESSOA(cpf, primeiro_nome, ultimos_nomes, endereco_numero, endereco_complemento, data_nasc, cep)
    VALUES ('888', 'Lineu', 'Carneiro', 3, 'Chacara dos Sonhos', to_date('14/05/1995', 'dd/mm/yyyy'), '001');

/* 
INSERT INTO PESSOA(cpf, primeiro_nome, sobrenomes_centrais, ultimos_nomes, endereco_numero, endereco_complemento, data_nasc, cep)
    VALUES ('534', 'Augusto', 'Guerrido', 'Correia', 544, 'Casa B', to_date('02/07/2005', 'dd/mm/yyyy'), '101'); */

-- Povoamento: Cliente
insert into Cliente(cpf) values ('001');
insert into Cliente(cpf) values ('010');
insert into Cliente(cpf) values ('462');
insert into Cliente(cpf) values ('888');

-- Povoamento: Auditor
insert into Auditor(cpf, Temp_serv) values ('594', 133);
insert into Auditor(cpf, Temp_serv) values ('534', 422);

-- Povoamento: Telefone
insert into Telefone(cpf_origem, telefone) values ('001', '(93) 3828-4531');
insert into Telefone(cpf_origem, telefone) values ('010', '(44) 3870-4688');
insert into Telefone(cpf_origem, telefone) values ('462', '(97) 2634-6734');
insert into Telefone(cpf_origem, telefone) values ('888', '(13) 3312-5636');
insert into Telefone(cpf_origem, telefone) values ('594', '(82) 3768-1394');
insert into Telefone(cpf_origem, telefone) values ('534', '(61) 2289-7253');

/*
insert into Telefone(cpf_origem, telefone) values ('010', '(44) 3870-4688');
insert into Telefone(cpf_origem, telefone) values ('594', '(82) 3768-1394');
insert into Telefone(cpf_origem, telefone) values ('534', '(61) 2289-7253');

insert into Telefone(cpf_origem, telefone) values ('594', '(82) 3768-1394');  
*/

-- Povoamento: Ocupação
insert into Ocupacao(cpf_origem, ocupacao) values ('001', 'Advogada');
insert into Ocupacao(cpf_origem, ocupacao) values ('010', 'Médico');
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
    values ('932', '089375612', );


-- Povoamento: ContaPoupanca
insert into Conta_Poupanca(numero_agencia, numero_conta, juros_rend)
    values ('854', '837917841', 0.24);
    
insert into Conta_Poupanca(numero_agencia, numero_conta, juros_rend)
    values ('129', '891756213', 0.342);

insert into Conta_Poupanca(numero_agencia, numero_conta, juros_rend)
    values ('367', '891756213', 5.322);

-- Povoamento: Movimenta
insert into Movimenta(numero_agencia, numero_conta, cpf) values ();
insert into Movimenta(numero_agencia, numero_conta, cpf) values ();
insert into Movimenta(numero_agencia, numero_conta, cpf) values ();
insert into Movimenta(numero_agencia, numero_conta, cpf) values ();
insert into Movimenta(numero_agencia, numero_conta, cpf) values ();
insert into Movimenta(numero_agencia, numero_conta, cpf) values ();

-- Povoamento: Dados transferencia
insert into Dados_transferencia(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, cpf_orig) values ();
insert into Dados_transferencia(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, cpf_orig) values ();
insert into Dados_transferencia(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, cpf_orig) values ();
insert into Dados_transferencia(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, cpf_orig) values ();
insert into Dados_transferencia(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, cpf_orig) values ();
insert into Dados_transferencia(data, horario, valor, status, motivo, numero_agencia_orig, numero_conta_orig, cpf_orig) values ();

-- Povoamento: Transfere
insert into Transfere(data, horario, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) values ();
insert into Transfere(data, horario, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) values ();
insert into Transfere(data, horario, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) values ();
insert into Transfere(data, horario, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) values ();
insert into Transfere(data, horario, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) values ();
insert into Transfere(data, horario, numero_agencia_orig, numero_conta_orig, numero_agencia_dest, numero_conta_dest, cpf_auditor) values ();

-- Povoamento: Conta Investe em
insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta) value ();
insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta) value ();
insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta) value ();
insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta) value ();
insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta) value ();
insert into Conta_investe_em(data_inicio, hora_inicio, valor_mensal_investido, nome_ativo, numero_agencia, numero_conta) value ();
-- Povoamento: Investe em
insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf) values ();
insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf) values ();
insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf) values ();
insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf) values ();
insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf) values ();
insert into Investe_em(nome_ativo, numero_agencia, numero_conta, cpf) values ();
-- Povoamento: Oferece auxilio
insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio) values ();
insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio) values ();
insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio) values ();
insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio) values ();
insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio) values ();
insert into Oferece_auxilio(cpf, numero_agencia, numero_conta, cnpj, cod_aux, valor_mensal, data_inicio) values ();

-- Povoamento: Dependente
insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc) values ();
insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc) values ();
insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc) values ();
insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc) values ();
insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc) values ();
insert into Dependente(cpf_parente, primeiro_nome, sobrenomes_centrais, ultimos_nomes, parentesco, data_nasc) values ();
