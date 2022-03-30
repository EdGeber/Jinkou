CREATE TABLE Transfere(
data DATE,
horario TIMESTAMP,
numero_agencia_orig VARCHAR(100),
numero_conta_orig VARCHAR(100),
numero_agencia_dest VARCHAR(100),
numero_conta_dest VARCHAR(100),
cpf_auditor VARCHAR(100),

CONSTRAINT Transfere_pkey PRIMARY KEY (data, horario,numero_agencia_orig,numero_conta_orig,numero_agencia_dest,numero_conta_dest),

CONSTRAINT Transfere_fkey_auditor FOREIGN KEY (cpf_auditor)
REFERENCES Auditor(cpf),

CONSTRAINT Transfere_fkey_conta_orig FOREIGN KEY (numero_agencia_orig, numero_conta_orig)
REFERENCES Conta(numero_agencia, numero_conta),

CONSTRAINT Transfere_fkey_conta_dest FOREIGN KEY (numero_agencia_dest, numero_conta_dest)
REFERENCES Conta(numero_agencia, numero_conta)
);
