create table Oferece_auxílio(
    cpf varchar(100),
    numero_agencia varchar(100),
    numero_conta varchar(100),
    cnpj varchar(14),
    cod_aux varchar(5),

    constraint fk_movimenta foreign key (cpf, numero_agencia, numero_conta) references Movimenta(cpf, numero_agencia, numero_conta),
    constraint fk_cnpj foreign key (cnpj) references Instituicao(cnpj),
    constraint fk_codaux foreign key (cod_aux) references Auxilio(cod_aux),
    
    constraint pk_ofereceAuxilio primary key (cpf, numero_agencia, numero_conta, cnpj, cod_aux)
);
