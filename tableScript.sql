/* 
    Tabelas Principais: apenas com chave primárias (Sem chaves estrangeiras)
 */

-- Table: Ativo Financeiro
CREATE TABLE Ativo_financeiro (
    nome VARCHAR(100), 
    nipo VARCHAR(100), 
    
    CONSTRAINT Ativo_financeiro_pkey PRIMARY KEY (nome)
);

-- Table: Auxilio
CREATE TABLE Auxilio( 
    cod_auxilio varchar(5), 
    nome_auxilio varchar(100) NOT NULL, 

    CONSTRAINT Auxilio_pkey PRIMARY KEY(cod_auxilio)
);

-- Table: Instituicao
create table Instituicao(  
    cnpj varchar(14),  
    nome varchar2(100) not null,  
    data_abertura date, 

    constraint pk_instituicao primary key(cnpj), 
    constraint ck_cnpj  check(length(cnpj) = '14')
);

-- Table: CEP
CREATE TABLE CEP ( 
    cep varchar(100), 
    rua varchar(100), 
    bairro varchar(100), 
    cidade varchar(100), 
    estado varchar(100), 
    
    CONSTRAINT CEP_pkey PRIMARY KEY (cep) 
);


/* 
    Tabelas Dependentes: com chaves Estrangeiras
*/
-- Table: Pessoa
create table Pessoa(
    cpf varchar(100) not null, 
    primeiro_nome varchar(100) not null, 
    sobrenomes_centrais varchar(100), 
    ultimos_nomes varchar(100), 
    endereco_numero int check(endereco_numero >= 0), 
    endereco_complemento varchar(100), 
    data_nasc date, 
    cep varchar(100),

    constraint fk_PessoaCEP foreign key (cep) references CEP(cep),
    constraint pk_Pessoa primary key(cpf)
);

-- Table: Cliente
CREATE TABLE Cliente (
    cpf varchar(100),
    CONSTRAINT Cliente_pkey
    PRIMARY KEY (cpf),

    CONSTRAINT fk_ClientePessoa
    FOREIGN KEY (cpf)
    REFERENCES Pessoa (cpf)
);

-- Table: Auditor
CREATE TABLE Auditor (
    cpf varchar(100),
    Tempo_serv number,

    CONSTRAINT pk_auditor
    PRIMARY KEY (cpf),

    CONSTRAINT fk_auditorPessoa
    FOREIGN KEY (cpf)
    REFERENCES Pessoa (cpf)
);

-- Table: Telefone
create table Telefone(  
    cpf_origem varchar(100),
    telefone varchar(100),

    constraint pk_telefone primary key (cpf_origem, telefone),
    constraint fk_telefonePessoa foreign key (cpf_origem) references Pessoa(cpf)
);

--Table: Ocupação
create table Ocupacao(  
    cpf_origem varchar(100),
    ocupacao varchar(100),

    constraint pk_ocupacao primary key (cpf_origem, ocupacao),
    constraint fk_ocupacaoCliente foreign key (cpf_origem) references Cliente(cpf)
);


--Table: Conta
 CREATE TABLE Conta(
    numero_agencia VARCHAR(100),
    numero_conta VARCHAR(100),
    data_criacao DATE,
    nome_banco VARCHAR(100),
    saldo_atual NUMBER(10,2) DEFAULT 0,

    CONSTRAINT Conta_pkey PRIMARY KEY(numero_agencia,numero_conta)
);

--Table: ContaCorrente
CREATE TABLE Conta_Corrente(
    numero_agencia VARCHAR(100),
    numero_conta VARCHAR(100),
    credito_disponivel NUMBER(10,2) NOT NULL,
    limite_credito NUMBER(10,2) NOT NULL,
    taxa NUMBER(5,2),
    positivo number(1) check((positivo = 1) or (positivo = 0)),

    CONSTRAINT Conta_Corrente_fkey
    FOREIGN KEY(numero_agencia,numero_conta) 
    REFERENCES Conta(numero_agencia,numero_conta),

    CONSTRAINT Conta_Corrente_pkey PRIMARY KEY(numero_agencia,numero_conta),

    CONSTRAINT chk_credito_valido CHECK(credito_disponivel <= limite_credito)
);

--Table: ContaPoupanca
CREATE TABLE Conta_Poupanca(
    numero_agencia VARCHAR(100),
    numero_conta VARCHAR(100),
    juros_rend NUMBER(5,2),

    CONSTRAINT Conta_Poupanca_fkey
    FOREIGN KEY(numero_agencia,numero_conta) 
    REFERENCES Conta(numero_agencia,numero_conta),

    CONSTRAINT Conta_Poupanca_pkey PRIMARY KEY(numero_agencia,numero_conta)
);

--Table: Movimenta
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


--Table: Dados transferencia
CREATE TABLE Dados_transferencia(
    data DATE,
    horario TIMESTAMP,
    valor VARCHAR(100),
    status VARCHAR(100),
    motivo VARCHAR(100),
    numero_agencia_orig VARCHAR(100),
    numero_conta_orig VARCHAR(100),
    cpf_orig VARCHAR(100),

    CONSTRAINT Dados_transfer_pkey PRIMARY KEY (data,horario,numero_agencia_orig,numero_conta_orig),

    CONSTRAINT Dados_transfer_fkey_cliente FOREIGN KEY (cpf_orig)
    REFERENCES Cliente(cpf),

    CONSTRAINT Dados_transfer_fkey_origem FOREIGN KEY (numero_agencia_orig,numero_conta_orig)
    REFERENCES Conta(numero_agencia, numero_conta)
);

--table: Transfere
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

/* --Table: Conta Investe em
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
    REFERENCES Ativo_financeiro(nome),

    constraint pk_conta_investe_em primary key(numero_agencia, numero_conta, nome_ativo)
); */

--table: Investe em
CREATE TABLE Investe_em(
    nome_ativo VARCHAR(100),
    numero_agencia VARCHAR(100),
    numero_conta VARCHAR(100),
    cpf VARCHAR(100),

    CONSTRAINT Investe_em_fkey_movimenta FOREIGN KEY (numero_agencia,numero_conta,cpf)
    REFERENCES Movimenta(numero_agencia,numero_conta,cpf),

    CONSTRAINT Investe_em_fkey_ativo FOREIGN KEY (nome_ativo)
    REFERENCES Ativo_financeiro(nome),

    constraint pk_investe_em primary key(cpf, numero_agencia, numero_conta, nome_ativo)
);

--table: Oferece auxilio
create table Oferece_auxilio(
    cpf varchar(100),
    numero_agencia varchar(100),
    numero_conta varchar(100),
    cnpj varchar(14),
    cod_aux varchar(5),
    valor_mensal number(*,2),
    data_início DATE,
    
    constraint fk_movimenta foreign key (cpf, numero_agencia, numero_conta) references Movimenta(cpf, numero_agencia, numero_conta),
    constraint fk_cnpj foreign key (cnpj) references Instituicao(cnpj),
    constraint fk_codaux foreign key (cod_aux) references Auxilio(cod_auxilio),
    
    constraint pk_ofereceAuxilio primary key (cpf, numero_agencia, numero_conta, cnpj, cod_aux)
);

