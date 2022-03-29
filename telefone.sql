create table Telefone(  
  cpf_origem varchar(100),
  telefone varchar(100),
  
  constraint pk_telefone primary key (cpf_origem, telefone),
  constraint fk_telefonePessoa foreign key (cpf_origem) references Pessoa(cpf)
);
