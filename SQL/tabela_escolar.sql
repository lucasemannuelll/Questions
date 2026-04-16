-- tb_aluno N:N tb_disc
-- tb_prof N:N tb_disc
-- tb_aluno N:1 tb_turma
-- tb_prof N:N tb_turma

CREATE TABLE tb_aluno (
    id_aluno INT AUTO_INCREMENT,
    nome VARCHAR(100),
    matricula VARCHAR(16) UNIQUE,
    telefone VARCHAR(16),
    responsavel VARCHAR(32),
    telefone_responsavel VARCHAR(16),
    data_nasc DATE,
    data_matricula DATE,
    cpf VARCHAR(11) UNIQUE,
    email VARCHAR(50) UNIQUE,

    PRIMARY KEY(id_aluno),

    id_turma INT,

    FOREIGN KEY (id_turma) REFERENCES tb_turma(id_turma)
);

CREATE TABLE tb_prof (
    id_prof INT AUTO_INCREMENT,
    nome VARCHAR(32),
    telefone VARCHAR(32),
    data_nasc DATE,
    data_contratacao DATE,
    salario DECIMAL(10, 2),
    cpf CHAR(11) UNIQUE,
    carga_horaria INT,

    PRIMARY KEY (id_prof)
);

CREATE TABLE tb_turma (
    id_turma INT AUTO_INCREMENT,
    nome VARCHAR (32),
    turno ENUM('manha', 'tarde', 'noite', 'integral'),

    PRIMARY KEY(id_turma)
);

CREATE TABLE tb_disc (
    id_disc INT AUTO_INCREMENT,
    nome VARCHAR(32),
    carga_horaria INT,

    PRIMARY KEY(id_disc)
);

-- Relationships

CREATE TABLE tb_aluno_disc (
    fk_aluno INT,
    fk_disc INT,
    
    PRIMARY KEY (fk_aluno, fk_disc),

    FOREIGN KEY (fk_aluno) REFERENCES tb_aluno(id_aluno),
    FOREIGN KEY (fk_disc) REFERENCES tb_disc(id_disc)
);

CREATE TABLE tb_prof_disc ();

CREATE TABLE tb_prod_turma ();
