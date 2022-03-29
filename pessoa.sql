CREATE TABLE CEP ( 
cep varchar(100), 
rua varchar(100), 
bairro varchar(100), 
cidade varchar(100), 
estado varchar(100), 
CONSTRAINT CEP_pkey 
PRIMARY KEY (cep) 
);

CREATE TABLE Cliente (
cpf varchar(100),
primeiro_nome varchar(100),
sobrenomes_centrais varchar(100),
ultimos_nomes varchar(100),
data_nasc number,
endereco_número varchar(100),
edereco_complemento varchar(100),
cep varchar(100),

CONSTRAINT Cliente_pkey
PRIMARY KEY (cpf),

CONSTRAINT Cliente_fkey
FOREIGN KEY (cep)
REFERENCES CEP (cep)
);

CREATE TABLE Auditor (
cpf varchar(100),
primeiro_nome varchar(100),
sobrenomes_centrais varchar(100),
ultimos_nomes varchar(100),
data_nasc number,
endereco_número varchar(100),
edereco_complemento varchar(100),
cep varchar(100),
Tempo_serv number,

CONSTRAINT Auditor_pkey
PRIMARY KEY (cpf),

CONSTRAINT Auditor_fkey
FOREIGN KEY (cep)
REFERENCES CEP (cep)
);
