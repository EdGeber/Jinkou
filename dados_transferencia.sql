CREATE TABLE Dados_transferencia(
data DATE,
horario TIMESTAMP,
valor VARCHAR(100),
status VARCHAR(100),
motivo VARCHAR(100),
numero_agencia_orig VARCHAR(100),
numero_conta_orig VARCHAR(100),
cpf_orig VARCHAR(100),

CONSTRAINT Dados_transfer_pkey PRIMARY KEY (data,horario),

CONSTRAINT Dados_transfer_fkey_cliente FOREIGN KEY (cpf_orig)
REFERENCES Cliente(cpf),

CONSTRAINT Dados_transfer_fkey_origem FOREIGN KEY (numero_agencia_orig,numero_conta_orig)
REFERENCES Conta(numero_agencia, numero_conta)
);