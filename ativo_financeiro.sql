CREATE TABLE Ativo_financeiro (Nome VARCHAR(100), Tipo VARCHAR(100), CONSTRAINT Ativo_financeiro_pkey PRIMARY KEY (Nome));;

INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('Tesouro Selic', 'Renda fixa');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('CDB', 'Renda fixa');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('LCI', 'Renda fixa');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('LCA', 'Renda fixa');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('Ações', 'Renda variável');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('Fundos de investimento', 'Renda variável');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('Fundos imobiliários', 'Renda variável');
INSERT INTO Ativo_financeiro(Nome, Tipo) VALUES ('ETF', 'Renda variável');


