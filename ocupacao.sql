create table Ocupacao(  
  cpf_origem varchar(100),
  ocupacao varchar(100),
  
  constraint pk_ocupacao primary key (cpf_origem, ocupacao),
  constraint fk_ocupacaoCliente foreign key (cpf_origem) references Cliente(cpf)
);
