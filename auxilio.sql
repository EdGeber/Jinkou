CREATE TABLE Auxilio(
cod_auxilio varchar(5),
nome_auxilio varchar(100) NOT NULL,
CONSTRAINT Auxilio_pkey PRIMARY KEY(cod_auxilio));

INSERT INTO Auxilio VALUES (03541,'Moradia Estudantil');
INSERT INTO Auxilio VALUES (02653,'Auxílio-Creche');
INSERT INTO Auxilio VALUES (54513,'Bolsa Família');
INSERT INTO Auxilio VALUES (45223,'Auxílio Emergencial');
INSERT INTO Auxilio VALUES (77368,'Auxílio Internet');
INSERT INTO Auxilio VALUES (00646,'Vale Transporte');