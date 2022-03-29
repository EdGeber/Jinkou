create table Instituicao(  
  cnpj varchar(14),  
  nome varchar(100) not null,  
  data_abertura date, 
  constraint pk_cnpj primary key(cnpj), 
  constraint ck_cnpj  check(length(cnpj) = '14')
);

/* Povoamento, eu acho, isso não deveria ficar aqui sl. Só falando*/

INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('00000993788450', 'Caixa Econômica Federal', TO_DATE('17/12/1902', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('71954503790463', 'Universidade Federal de Pernambuco', TO_DATE('07/02/1856', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('22210292435128', 'Minha Criatividade acabou', TO_DATE('06/06/1666', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('18101153985142', 'Só pra testar se está funcionando', TO_DATE('01/04/1824', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('51343527479898', 'Eu não sei mais o que colocar', TO_DATE('21/10/2006', 'DD/MM/YYYY'));
INSERT INTO Instituicao(cnpj, nome, data_abertura) VALUES ('46674246944235', 'Depois eu mudo isso', TO_DATE('23/12/1999', 'DD/MM/YYYY'));
