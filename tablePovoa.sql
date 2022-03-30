
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
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('22210292435128', 'Minha Criatividade acabou', TO_DATE('06/06/1666', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('18101153985142', 'Só pra testar se está funcionando', TO_DATE('01/04/1824', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('51343527479898', 'Eu não sei mais o que colocar', TO_DATE('21/10/2006', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('46674246944235', 'Depois eu mudo isso', TO_DATE('23/12/1999', 'DD/MM/YYYY'));
