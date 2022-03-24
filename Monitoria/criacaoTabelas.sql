DROP TABLE monitoria;
DROP TABLE prova;
DROP TABLE aluno_turma;
DROP TABLE aluno;
DROP TABLE ministra;
DROP TABLE turma;
DROP TABLE disciplina;
DROP TABLE professor;
DROP TABLE pessoa;
DROP TABLE projeto;
DROP TABLE curso;

CREATE TABLE curso (
	codigo_curso NUMBER,
	nome VARCHAR2(30) NOT NULL,
	CONSTRAINT curso_pk PRIMARY KEY (codigo_curso)
);

CREATE TABLE projeto (
	codigo_projeto NUMBER,
	titulo VARCHAR2(30) NOT NULL,
	conceito VARCHAR2(7),
	hp VARCHAR2(50),
	CONSTRAINT projeto_pk PRIMARY KEY (codigo_projeto),
	CONSTRAINT projeto_conceito_ck CHECK (conceito IN ('BOM', 'RUIM', 'REGULAR'))
);

CREATE TABLE pessoa (
	matricula_pessoa NUMBER,
	nome VARCHAR2(50) NOT NULL,
	sexo CHAR(1) NOT NULL,
	CONSTRAINT pessoa_pk PRIMARY KEY (matricula_pessoa)
);

CREATE TABLE professor (
	matricula_professor NUMBER,
	data_admissao DATE NOT NULL,
	matricula_lider NUMBER,
	CONSTRAINT professor_pk PRIMARY KEY (matricula_professor),
	CONSTRAINT professor_matricula_prof_fk FOREIGN KEY (matricula_professor) REFERENCES pessoa (matricula_pessoa),
	CONSTRAINT professor_matricula_lider_fk FOREIGN KEY (matricula_lider) REFERENCES professor (matricula_professor)
);

CREATE TABLE disciplina (
	codigo_disciplina NUMBER,
	ementa VARCHAR2(50) NOT NULL,
	conteudo_programatico VARCHAR2(100) NOT NULL,
	matricula_professor NUMBER NOT NULL,
	CONSTRAINT disciplina_pk PRIMARY KEY (codigo_disciplina),
	CONSTRAINT disciplina_matricula_prof_fk FOREIGN KEY (matricula_professor) REFERENCES professor (matricula_professor)
);


CREATE TABLE turma (
	codigo_disciplina NUMBER,
	codigo_curso NUMBER,
	ano_semestre VARCHAR2(6),
	CONSTRAINT turma_pk PRIMARY KEY (codigo_disciplina,codigo_curso,ano_semestre),
	CONSTRAINT turma_codigo_disciplina_fk FOREIGN KEY (codigo_disciplina) REFERENCES disciplina (codigo_disciplina),
	CONSTRAINT turma_codigo_curso_fk FOREIGN KEY (codigo_curso) REFERENCES curso (codigo_curso),
	CONSTRAINT turma_ano_semestre_ck CHECK (ano_semestre LIKE '____._')
);

CREATE TABLE ministra (
	codigo_disciplina NUMBER,
	codigo_curso NUMBER,
	ano_semestre VARCHAR2(6),
	matricula_professor NUMBER,
	CONSTRAINT ministra_pk PRIMARY KEY (codigo_disciplina,codigo_curso,ano_semestre,matricula_professor),
	CONSTRAINT ministra_turma_fk FOREIGN KEY (codigo_disciplina,codigo_curso,ano_semestre) REFERENCES turma (codigo_disciplina,codigo_curso,ano_semestre),
	CONSTRAINT ministra_matricula_prof_fk FOREIGN KEY (matricula_professor) REFERENCES professor (matricula_professor)
);

CREATE TABLE aluno (
	matricula_aluno NUMBER,
	nota_vestibular DECIMAL(5,3) NOT NULL,
	codigo_curso NUMBER NOT NULL,
	CONSTRAINT aluno_pk PRIMARY KEY (matricula_aluno),
	CONSTRAINT aluno_matricula_aluno_fk FOREIGN KEY (matricula_aluno) REFERENCES pessoa (matricula_pessoa),
	CONSTRAINT aluno_codigo_curso_fk FOREIGN KEY (codigo_curso) REFERENCES curso (codigo_curso)
);

CREATE TABLE aluno_turma (
	codigo_disciplina NUMBER,
	codigo_curso NUMBER,
	ano_semestre VARCHAR2(6),
	matricula_aluno NUMBER,
	codigo_projeto NUMBER,
	CONSTRAINT aluno_turma_pk PRIMARY KEY (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno),
	CONSTRAINT aluno_turma_turma_fk FOREIGN KEY (codigo_disciplina,codigo_curso,ano_semestre) REFERENCES turma (codigo_disciplina,codigo_curso,ano_semestre),
	CONSTRAINT aluno_turma_matricula_aluno_fk FOREIGN KEY (matricula_aluno) REFERENCES aluno (matricula_aluno),
	CONSTRAINT aluno_turma_codigo_projeto_fk FOREIGN KEY (codigo_projeto) REFERENCES projeto (codigo_projeto)
);

CREATE TABLE prova (
	codigo_disciplina NUMBER,
	codigo_curso NUMBER,
	ano_semestre VARCHAR2(6),
	matricula_aluno NUMBER,
	descricao VARCHAR2(10),
	nota DECIMAL(3,1) NOT NULL,
	CONSTRAINT prova_pk PRIMARY KEY (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno,descricao),
	CONSTRAINT prova_aluno_turma_fk FOREIGN KEY (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno) REFERENCES aluno_turma (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno)
);

CREATE TABLE monitoria (
	codigo_disciplina NUMBER,
	codigo_curso NUMBER,
	ano_semestre VARCHAR2(6),
	matricula_aluno NUMBER,
	matricula_professor NUMBER NOT NULL,
	CONSTRAINT monitoria_pk PRIMARY KEY (codigo_disciplina,codigo_curso,ano_semestre,matricula_aluno),
	CONSTRAINT monitoria_turma_fk FOREIGN KEY (codigo_disciplina,codigo_curso,ano_semestre) REFERENCES turma (codigo_disciplina,codigo_curso,ano_semestre),
	CONSTRAINT monitoria_matricula_aluno_fk FOREIGN KEY (matricula_aluno) REFERENCES aluno (matricula_aluno),
	CONSTRAINT monitoria_matricula_prof_fk FOREIGN KEY (matricula_professor) REFERENCES professor (matricula_professor)
);

