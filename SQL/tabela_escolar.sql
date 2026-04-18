-- tb_aluno N:N tb_disc
-- tb_prof N:N tb_disc
-- tb_aluno N:1 tb_turma
-- tb_prof N:N tb_turma

DROP TABLE IF EXISTS tb_aluno_disc;
DROP TABLE IF EXISTS tb_prof_disc;
DROP TABLE IF EXISTS tb_prof_turma;
DROP TABLE IF EXISTS tb_aluno;
DROP TABLE IF EXISTS tb_prof;
DROP TABLE IF EXISTS tb_disc;
DROP TABLE IF EXISTS tb_turma;

CREATE TABLE tb_turma (
    id_turma INT AUTO_INCREMENT,
    nome VARCHAR (32),
    turno ENUM('manha', 'tarde', 'noite', 'integral'),

    PRIMARY KEY(id_turma)
);

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

CREATE TABLE tb_disc (
    id_disc INT AUTO_INCREMENT,
    nome VARCHAR(32),
    carga_horaria INT,

    PRIMARY KEY(id_disc)
);

-- Junction Tables

CREATE TABLE tb_aluno_disc (
    fk_aluno INT,
    fk_disc INT,
    
    PRIMARY KEY (fk_aluno, fk_disc),

    FOREIGN KEY (fk_aluno) REFERENCES tb_aluno(id_aluno),
    FOREIGN KEY (fk_disc) REFERENCES tb_disc(id_disc)
);

CREATE TABLE tb_prof_disc (
    fk_prof INT,
    fk_disc INT,

    PRIMARY KEY(fk_prof, fk_disc),

    FOREIGN KEY(fk_prof) REFERENCES tb_prof(id_prof),
    FOREIGN KEY(fk_disc) REFERENCES tb_disc(id_disc)
);

CREATE TABLE tb_prof_turma (
    fk_prof INT,
    fk_turma INT,

    PRIMARY KEY(fk_prof, fk_turma),

    FOREIGN KEY(fk_prof) REFERENCES tb_prof(id_prof),
    FOREIGN KEY(fk_turma) REFERENCES tb_turma(id_turma)
);

-- INSERT QUERIES

INSERT IGNORE INTO tb_disc (nome, carga_horaria) VALUES
    ('Mathematics', 80),
    ('History', 60),
    ('Physics', 80),
    ('Biology', 60);

INSERT IGNORE INTO tb_turma (nome, turno) VALUES
    ('101-A', 'manha'),
    ('202-B', 'tarde'),
    ('303-C', 'noite');

INSERT IGNORE INTO tb_prof (nome, telefone, data_nasc, data_contratacao, salario, cpf, carga_horaria) VALUES
    ('Alice Smith', '555-0101', '1985-05-15', '2020-02-10', 4500.00, '12345678901', 40),
    ('Bob Johnson', '555-0202', '1978-11-20', '2018-03-15', 5200.00, '98765432100', 36);

INSERT IGNORE INTO tb_aluno (nome, matricula, telefone, responsavel, telefone_responsavel, data_nasc, data_matricula, cpf, email, id_turma) VALUES
    ('John Doe', 'MAT2026-001', '555-9988', 'Jane Doe', '555-7766', '2008-04-12', '2026-01-10', '11122233344', 'john.doe@email.com', 1),
    ('Maria Garcia', 'MAT2026-002', '555-4433', 'Carlos Garcia', '555-2211', '2009-07-22', '2026-01-12', '55566677788', 'maria.g@email.com', 2);

INSERT IGNORE INTO tb_prof_disc VALUES
    (1, 1),
    (1, 3),
    (2, 2);

INSERT IGNORE INTO tb_aluno_disc VALUES
    (1, 1),
    (1, 3),
    (2, 2),
    (2, 4);

INSERT IGNORE INTO tb_prof_turma VALUES
    (2, 1),
    (2, 2),
    (1, 1);

-- SELECT QUERIES

SELECT a.nome AS Aluno, t.nome AS Turma, t.turno
FROM tb_aluno a
JOIN tb_turma t ON a.id_turma = t.id_turma;

SELECT nome, salario, carga_horaria 
FROM tb_prof 
WHERE salario > 5000;

SELECT p.nome AS Professor, t.nome AS Turma, t.turno
FROM tb_prof p
JOIN tb_prof_turma pt ON p.id_prof = pt.fk_prof
JOIN tb_turma t ON pt.fk_turma = t.id_turma;

SELECT t.nome AS Turma, COUNT(a.id_aluno) AS Total_Alunos
FROM tb_turma t
LEFT JOIN tb_aluno a ON t.id_turma = a.id_turma
GROUP BY t.id_turma;

SELECT SUM(salario) AS Folha_Pagamento_Total FROM tb_prof;

SELECT nome, data_nasc 
FROM tb_aluno 
WHERE data_nasc > '2000-12-31';
