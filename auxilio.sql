CREATE TABLE Auxilio( 
cod_auxilio varchar(5), 
nome_auxilio varchar(100) NOT NULL, 
CONSTRAINT Auxilio_pkey PRIMARY KEY(cod_auxilio))

CREATE SEQUENCE auxilio_seq INCREMENT BY 1 START WITH 1

INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Moradia Estudantil');
INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Auxílio-Creche');
INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Bolsa Família');
INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Auxílio Emergencial');
INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Auxílio Internet');
INSERT INTO Auxilio VALUES (auxilio_seq.nextval,'Vale Transporte');