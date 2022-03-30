CREATE TABLE Investe_em(
nome_ativo VARCHAR(100),
numero_agencia VARCHAR(100),
numero_conta VARCHAR(100),
cpf VARCHAR(100),

CONSTRAINT Investe_em_fkey_movimenta FOREIGN KEY (numero_agencia,numero_conta,cpf)
REFERENCES Movimenta(numero_agencia,numero_conta,cpf),

CONSTRAINT Investe_em_fkey_ativo FOREIGN KEY (nome_ativo)
REFERENCES Ativo_financeiro(nome_ativo)
);