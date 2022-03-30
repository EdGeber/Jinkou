CREATE TABLE Conta_investe_em(
data_inicio DATE,
hora_inicio TIMESTAMP,
valor_mensal_investido NUMBER(7,2),
nome_ativo VARCHAR(100),
numero_agencia VARCHAR(100),
numero_conta VARCHAR(100),

CONSTRAINT Conta_investe_em_fkey_movimenta FOREIGN KEY (numero_agencia,numero_conta)
REFERENCES Movimenta(numero_agencia,numero_conta),

CONSTRAINT Conta_investe_em_fkey_ativo FOREIGN KEY (nome_ativo)
REFERENCES Ativo_financeiro(nome)
);