CREATE TABLE Movimenta(
numero_agencia VARCHAR(100),
numero_conta VARCHAR(100),
cpf VARCHAR(100),

CONSTRAINT Movimenta_pkey PRIMARY KEY(numero_agencia,numero_conta,cpf),

CONSTRAINT Moviment_fkey_pessoa 
FOREIGN KEY (cpf)
REFERENCES Cliente(cpf),

CONSTRAINT Moviment_fkey_conta 
FOREIGN KEY (numero_agencia, numero_conta)
REFERENCES Conta(numero_agencia, numero_conta)
);
