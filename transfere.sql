CREATE TABLE Transfere(
data DATE,
horario TIMESTAMP,
numero_agencia VARCHAR(100),
numero_conta VARCHAR(100), 
cpf_auditor VARCHAR(100),

CONSTRAINT Transfere_pkey PRIMARY KEY (data,horario),

CONSTRAINT Transfere_fkey_auditor FOREIGN KEY (cpf_auditor)
REFERENCES Auditor(cpf_auditor),

CONSTRAINT Transfere_fkey_conta_orig FOREIGN KEY (numero_agencia, numero_conta)
REFERENCES Conta(numero_agencia, numero_conta),

CONSTRAINT Transfere_fkey_conta_dest FOREIGN KEY (numero_agencia, numero_conta)
REFERENCES Conta(numero_agencia, numero_conta)
);