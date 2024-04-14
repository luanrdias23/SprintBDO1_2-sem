
DROP TABLE tg_bairro CASCADE CONSTRAINTS;

DROP TABLE tg_cidade CASCADE CONSTRAINTS;

DROP TABLE tg_contato_usuario CASCADE CONSTRAINTS;

DROP TABLE tg_endereco_usuario CASCADE CONSTRAINTS;

DROP TABLE tg_estado CASCADE CONSTRAINTS;

DROP TABLE tg_fornecedor CASCADE CONSTRAINTS;

DROP TABLE tg_logradouro CASCADE CONSTRAINTS;

DROP TABLE tg_telefone_usuario CASCADE CONSTRAINTS;

DROP TABLE tg_tipo_contato CASCADE CONSTRAINTS;

DROP TABLE tg_transacao CASCADE CONSTRAINTS;

DROP TABLE tg_usuario CASCADE CONSTRAINTS;

DROP TABLE tg_vegetais CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE tg_bairro (
    id_bairro   NUMBER(10) NOT NULL,
    id_cidade   NUMBER(2) NOT NULL,
    nm_bairro   VARCHAR2(30) NOT NULL,
    nm_zona     VARCHAR2(15) NOT NULL,
    dt_cadastro DATE NOT NULL
);

ALTER TABLE tg_bairro
    ADD CHECK ( nm_zona IN ( 'Zona Leste ', 'Centro',  
                              'Zona Norte', 'Zona Oeste', 'Zona Sul' ) );

ALTER TABLE tg_bairro ADD CONSTRAINT tg_bairro_pk PRIMARY KEY ( id_bairro );

CREATE TABLE tg_cidade (
    id_cidade   NUMBER(10) NOT NULL,
    id_estado   NUMBER(2) NOT NULL,
    sg_cidade   CHAR(2) NOT NULL,
    cd_ibge     NUMBER(8) NOT NULL,
    nr_ddd      NUMBER(3) NOT NULL,
    nm_cidade   VARCHAR2(30) NOT NULL,
    dt_cadastro DATE NOT NULL
);

ALTER TABLE tg_cidade ADD CONSTRAINT tg_cidade_pk PRIMARY KEY ( id_cidade );

CREATE TABLE tg_contato_usuario (
    id_contato  NUMBER(10) NOT NULL,
    id_usuario  NUMBER(2) NOT NULL,
    id_tipo     NUMBER(2) NOT NULL,
    nm_contato  VARCHAR2(30) NOT NULL,
    nr_ddi      NUMBER(3) NOT NULL,
    nr_ddd      NUMBER(3),
    nr_telefone NUMBER(10),
    dt_cadastro DATE NOT NULL
);

ALTER TABLE tg_contato_usuario ADD CONSTRAINT tg_contato_usuario_pk PRIMARY KEY ( id_contato );

CREATE TABLE tg_endereco_usuario (
    id_endereco    NUMBER(10) NOT NULL,
    id_logradouro  NUMBER(2) NOT NULL,
    id_usuario     NUMBER(2) NOT NULL,
    nr_logradouro  NUMBER(7),
    ds_complemento VARCHAR2(30),
    ds_ponto_ref   VARCHAR2(30),
    dt_inicio      DATE NOT NULL,
    dt_fim         DATE,
    dt_cadastro    DATE NOT NULL
);

ALTER TABLE tg_endereco_usuario ADD CONSTRAINT tg_endereco_usuario_pk PRIMARY KEY ( id_endereco );

CREATE TABLE tg_estado (
    id_estado   NUMBER(10) NOT NULL,
    sg_estado   CHAR(2) NOT NULL,
    nm_estado   VARCHAR2(30) NOT NULL,
    dt_cadastro DATE NOT NULL
);

ALTER TABLE tg_estado ADD CONSTRAINT tg_estado_pk PRIMARY KEY ( id_estado );

CREATE TABLE tg_fornecedor (
    id_fornecedor  NUMBER(10) NOT NULL,
    nm_fornecedor  VARCHAR2(50) NOT NULL,
    nm_localizacao VARCHAR2(50),
    nr_fornecedor  NUMBER(11),
    id_usuario     NUMBER(10) NOT NULL
);

COMMENT ON COLUMN tg_fornecedor.id_fornecedor IS
    'REHISTRAR OS FORNECEDORES ';

COMMENT ON COLUMN tg_fornecedor.nm_fornecedor IS
    'ESSE ATRIBUTO VAI REGISTRAR O NOME DO FORNECEDOR.';

COMMENT ON COLUMN tg_fornecedor.nm_localizacao IS
    'LOCALIZA??O DO FORNECEDOR ';

COMMENT ON COLUMN tg_fornecedor.nr_fornecedor IS
    'iNFORMA??O DE CONTATO COM O FORNECEDOR ';

ALTER TABLE tg_fornecedor ADD CONSTRAINT tg_fornecedor_pk PRIMARY KEY ( id_fornecedor );

CREATE TABLE tg_logradouro (
    id_logradouro NUMBER(10) NOT NULL,
    id_bairro     NUMBER(2) NOT NULL,
    nm_logradouro VARCHAR2(30) NOT NULL,
    nr_cep        NUMBER(8) NOT NULL,
    dt_cadastro   DATE NOT NULL
);

ALTER TABLE tg_logradouro ADD CONSTRAINT tg_logradouro_pk PRIMARY KEY ( id_logradouro );

CREATE TABLE tg_telefone_usuario (
    id_telefone NUMBER(10) NOT NULL,
    id_usuario  NUMBER(2) NOT NULL,
    nr_ddi      NUMBER(3) NOT NULL,
    nr_ddd      NUMBER(3) NOT NULL,
    nr_telefone NUMBER(10) NOT NULL,
    tp_telefone VARCHAR2(20) NOT NULL,
    st_telefone CHAR(1) NOT NULL,
    dt_cadastro DATE NOT NULL
);

CREATE TABLE tg_tipo_contato (
    id_tipo     NUMBER(10) NOT NULL,
    nm_tipo     VARCHAR2(10) NOT NULL,
    dt_inico    DATE NOT NULL,
    dt_fim      DATE,
    dt_cadastro DATE NOT NULL
);

ALTER TABLE tg_tipo_contato ADD CONSTRAINT tg_tipo_contato_pk PRIMARY KEY ( id_tipo );

CREATE TABLE tg_transacao (
    id_transacao       NUMBER(10) NOT NULL,
    id_fornecedor      NUMBER(10) NOT NULL,
    id_vegetais        NUMBER(10) NOT NULL,
    qnt_vegetais       NUMBER(10) NOT NULL,
    dt_transacao       DATE NOT NULL,
    nr_preco_unitario  NUMBER(10) NOT NULL,
    nr_total_transacao NUMBER(10) NOT NULL
);

COMMENT ON COLUMN tg_transacao.id_transacao IS
    'ATRIBUTO PARA REGISTRAR AS TRANS??ES QUE PODEM SER FEITAS ';

COMMENT ON COLUMN tg_transacao.nr_preco_unitario IS
    'aTRIBUTO PARA REGISTRAR OS PRE?OS DOS PRODUTOS ';

COMMENT ON COLUMN tg_transacao.nr_total_transacao IS
    'aTRIBUTO PARA REGISTRAR O PRE?O TOTAL DOS  PRODUTOS ';

ALTER TABLE tg_transacao ADD CONSTRAINT tg_transacao_pk PRIMARY KEY ( id_transacao );

CREATE TABLE tg_usuario (
    id_usuario    NUMBER(10) NOT NULL,
    nm_usuario    VARCHAR2(30) NOT NULL,
    nr_cpf        NUMBER(12) NOT NULL,
    nm_rg         VARCHAR2(15),
    dt_nascimento DATE,
    fl_genero     CHAR(1),
    dt_cadastro   DATE,
    nm_email      VARCHAR2(100) NOT NULL,
    nm_senha      VARCHAR2(100) NOT NULL
);

ALTER TABLE tg_usuario
    ADD CHECK ( fl_genero IN ( 'M ', 'F' ) );

ALTER TABLE tg_usuario ADD CONSTRAINT tg_usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE tg_usuario ADD CONSTRAINT tg_usuario_nr_cpf_un UNIQUE ( nr_cpf );

ALTER TABLE tg_usuario ADD CONSTRAINT tg_usuario_nm_rg_un UNIQUE ( nm_rg );

CREATE TABLE tg_vegetais (
    id_vegetais NUMBER(10) NOT NULL,
    id_usuario  NUMBER(10) NOT NULL,
    nm_vegetais VARCHAR2(50) NOT NULL,
    st_vegetal  CHAR(1) NOT NULL,
    lk_imagem   VARCHAR2(50),
    dt_imagem   DATE
);

COMMENT ON COLUMN tg_vegetais.id_vegetais IS
    'iD PARA REGISTROS DE VEGETAIS ';

COMMENT ON COLUMN tg_vegetais.nm_vegetais IS
    'ESTE ATRIBUTO VAI ESPECIFICAR O NOME DO VEGETAL';

COMMENT ON COLUMN tg_vegetais.st_vegetal IS
    'ESTE ATRIBUTO VAI REGISTRAR O ESTADO DO ALIMENTO';

ALTER TABLE tg_vegetais ADD CONSTRAINT tg_vegetais_pk PRIMARY KEY ( id_vegetais );

ALTER TABLE tg_logradouro
    ADD CONSTRAINT fk_bairro_logradouro FOREIGN KEY ( id_bairro )
        REFERENCES tg_bairro ( id_bairro );

ALTER TABLE tg_bairro
    ADD CONSTRAINT fk_cidades_bairros FOREIGN KEY ( id_cidade )
        REFERENCES tg_cidade ( id_cidade );

ALTER TABLE tg_cidade
    ADD CONSTRAINT fk_estados_cidades FOREIGN KEY ( id_estado )
        REFERENCES tg_estado ( id_estado );

ALTER TABLE tg_transacao
    ADD CONSTRAINT fk_fornecedor_transacao FOREIGN KEY ( id_fornecedor )
        REFERENCES tg_fornecedor ( id_fornecedor );

ALTER TABLE tg_endereco_usuario
    ADD CONSTRAINT fk_logradouro_endereco FOREIGN KEY ( id_logradouro )
        REFERENCES tg_logradouro ( id_logradouro );

ALTER TABLE tg_contato_usuario
    ADD CONSTRAINT fk_tipo_contato FOREIGN KEY ( id_tipo )
        REFERENCES tg_tipo_contato ( id_tipo );

ALTER TABLE tg_contato_usuario
    ADD CONSTRAINT fk_usuario_contato FOREIGN KEY ( id_usuario )
        REFERENCES tg_usuario ( id_usuario );

ALTER TABLE tg_endereco_usuario
    ADD CONSTRAINT fk_usuario_endereco FOREIGN KEY ( id_usuario )
        REFERENCES tg_usuario ( id_usuario );

ALTER TABLE tg_fornecedor
    ADD CONSTRAINT fk_usuario_fornecedor FOREIGN KEY ( id_usuario )
        REFERENCES tg_usuario ( id_usuario );

ALTER TABLE tg_telefone_usuario
    ADD CONSTRAINT fk_usuario_telefone FOREIGN KEY ( id_usuario )
        REFERENCES tg_usuario ( id_usuario );

ALTER TABLE tg_vegetais
    ADD CONSTRAINT fk_usuario_vegetal FOREIGN KEY ( id_usuario )
        REFERENCES tg_usuario ( id_usuario );

ALTER TABLE tg_transacao
    ADD CONSTRAINT fk_vegetal_transacao FOREIGN KEY ( id_vegetais )
        REFERENCES tg_vegetais ( id_vegetais );
        





INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
VALUES (1, 'AC', 'Acre', TO_DATE('2023-02-10', 'YYYY-MM-DD'));
    

    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (2, 'AL', 'Alagoas', TO_DATE('2021-10-24', 'YYYY-MM-DD'));
    

    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (3, 'AP', 'Amapá', TO_DATE('2023-09-13', 'YYYY-MM-DD'));
    

    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (4, 'AM', 'Amazonas', TO_DATE('2023-01-19', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (5, 'BA', 'Bahia', TO_DATE('2022-04-06', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (6, 'CE', 'Ceará', TO_DATE('2022-08-16', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (7, 'DF', 'Distrito Federal', TO_DATE('2023-02-27', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (8, 'ES', 'Espírito Santo', TO_DATE('2022-12-03', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (9, 'GO', 'Goiás', TO_DATE('2021-02-03', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (10, 'MA', 'Maranhão', TO_DATE('2021-06-01', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (11, 'MT', 'Mato Grosso', TO_DATE('2020-02-06', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (12, 'MS', 'Mato Grosso do Sul', TO_DATE('2022-11-24', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (13, 'MG', 'Minas Gerais', TO_DATE('2023-02-27', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (14, 'PA', 'Pará', TO_DATE('2023-04-24', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (15, 'PB', 'Paraíba', TO_DATE('2021-04-26', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (16, 'PR', 'Paraná', TO_DATE('2020-09-28', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (17, 'PE', 'Pernambuco', TO_DATE('2022-09-27', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (18, 'PI', 'Piauí', TO_DATE('2020-05-28', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (19, 'RJ', 'Rio de Janeiro', TO_DATE('2021-07-06', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (20, 'RN', 'Rio Grande do Norte', TO_DATE('2021-03-23', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (21, 'RS', 'Rio Grande do Sul', TO_DATE('2022-06-20', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (22, 'RO', 'Rondônia', TO_DATE('2023-07-29', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (23, 'RR', 'Roraima', TO_DATE('2022-04-26', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (24, 'SC', 'Santa Catarina', TO_DATE('2020-07-16', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (25, 'SP', 'São Paulo', TO_DATE('2022-03-22', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (26, 'SE', 'Sergipe', TO_DATE('2021-02-16', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (27, 'TO', 'Tocantins', TO_DATE('2021-05-09', 'YYYY-MM-DD'));
    
     -- inserindo as cidades 
    
    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (1, 1, 'ZX', 6780953, 75, 'Rio Branco', TO_DATE('2020-04-06', 'YYYY-MM-DD'));
        

    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (2, 1, 'EQ', 6794861, 65, 'Cruzeiro do Sul', TO_DATE('2021-02-11', 'YYYY-MM-DD'));
        

    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (3, 1, 'TN', 2612102, 63, 'Sena Madureira', TO_DATE('2020-06-20', 'YYYY-MM-DD'));
        

    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (4, 1, 'DY', 3357160, 54, 'Tarauacá', TO_DATE('2023-03-27', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (5, 1, 'CK', 1953265, 62, 'Feijó', TO_DATE('2022-12-02', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (6, 2, 'QI', 7355899, 97, 'Maceió', TO_DATE('2020-06-02', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (7, 2, 'DB', 3626375, 82, 'Arapiraca', TO_DATE('2021-06-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (8, 2, 'MW', 2601081, 28, 'Palmeira dos Índios', TO_DATE('2022-11-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (9, 2, 'VY', 4873067, 72, 'Rio Largo', TO_DATE('2023-07-22', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (10, 2, 'JK', 101502, 12, 'Penedo', TO_DATE('2022-02-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (11, 3, 'NI', 712368, 58, 'Macapá', TO_DATE('2020-01-28', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (12, 3, 'OX', 7143900, 33, 'Santana', TO_DATE('2023-11-04', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (13, 3, 'XZ', 1120723, 72, 'Laranjal do Jari', TO_DATE('2023-09-02', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (14, 3, 'PG', 7914450, 8, 'Oiapoque', TO_DATE('2020-09-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (15, 3, 'US', 8942646, 1, 'Mazagão', TO_DATE('2023-06-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (16, 4, 'YV', 7866291, 20, 'Manaus', TO_DATE('2022-02-27', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (17, 4, 'HU', 186736, 34, 'Parintins', TO_DATE('2021-03-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (18, 4, 'WR', 6231010, 99, 'Itacoatiara', TO_DATE('2020-02-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (19, 4, 'EU', 8351983, 59, 'Manacapuru', TO_DATE('2020-10-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (20, 4, 'BX', 2961427, 50, 'Coari', TO_DATE('2022-07-21', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (21, 5, 'AP', 2016722, 48, 'Salvador', TO_DATE('2023-05-17', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (22, 5, 'DB', 2010661, 74, 'Feira de Santana', TO_DATE('2022-12-12', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (23, 5, 'MR', 6850056, 47, 'Vitória da Conquista', TO_DATE('2020-09-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (24, 5, 'CO', 6589073, 95, 'Camaçari', TO_DATE('2023-06-20', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (25, 5, 'XM', 1562185, 73, 'Itabuna', TO_DATE('2023-08-09', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (26, 6, 'HG', 9290815, 77, 'Fortaleza', TO_DATE('2021-08-16', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (27, 6, 'YF', 2747233, 79, 'Caucaia', TO_DATE('2022-08-09', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (28, 6, 'MM', 4066245, 91, 'Juazeiro do Norte', TO_DATE('2020-11-12', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (29, 6, 'GR', 4375917, 38, 'Maracanaú', TO_DATE('2020-12-11', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (30, 6, 'PG', 4162398, 54, 'Sobral', TO_DATE('2023-07-17', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (31, 7, 'TW', 8814906, 58, 'Brasília', TO_DATE('2023-05-05', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (32, 8, 'LG', 175927, 27, 'Vitória', TO_DATE('2021-04-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (33, 8, 'QD', 3641393, 67, 'Vila Velha', TO_DATE('2021-04-07', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (34, 8, 'JY', 3154024, 3, 'Cariacica', TO_DATE('2020-09-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (35, 8, 'IF', 2495092, 99, 'Serra', TO_DATE('2020-05-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (36, 8, 'TN', 3772941, 15, 'Linhares', TO_DATE('2022-06-29', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (37, 9, 'FH', 6674330, 87, 'Goiânia', TO_DATE('2021-07-07', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (38, 9, 'VP', 9277077, 43, 'Aparecida de Goiânia', TO_DATE('2021-05-24', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (39, 9, 'ND', 2771019, 69, 'Anápolis', TO_DATE('2021-07-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (40, 9, 'XP', 2225317, 78, 'Rio Verde', TO_DATE('2020-02-12', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (41, 9, 'AP', 9206487, 35, 'Luziânia', TO_DATE('2023-07-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (42, 10, 'IK', 398255, 95, 'São Luís', TO_DATE('2020-05-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (43, 10, 'VZ', 2868447, 28, 'Imperatriz', TO_DATE('2021-05-05', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (44, 10, 'DE', 1725763, 34, 'Timon', TO_DATE('2022-10-28', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (45, 10, 'HQ', 7043706, 41, 'Caxias', TO_DATE('2022-05-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (46, 10, 'LG', 9864845, 83, 'Codó', TO_DATE('2020-05-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (47, 11, 'HP', 7836266, 20, 'Cuiabá', TO_DATE('2020-02-24', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (48, 11, 'VE', 163324, 35, 'Várzea Grande', TO_DATE('2020-12-02', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (49, 11, 'DH', 5608284, 0, 'Rondonópolis', TO_DATE('2023-06-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (50, 11, 'MP', 6672998, 72, 'Cáceres', TO_DATE('2021-03-15', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (51, 11, 'FX', 2616206, 80, 'Sinop', TO_DATE('2023-02-16', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (52, 12, 'JA', 4430416, 68, 'Campo Grande', TO_DATE('2022-08-21', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (53, 12, 'YU', 3259445, 87, 'Dourados', TO_DATE('2021-01-17', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (54, 12, 'CD', 5892525, 59, 'Três Lagoas', TO_DATE('2021-01-11', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (55, 12, 'ZU', 5493902, 30, 'Corumbá', TO_DATE('2021-11-15', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (56, 12, 'XQ', 1429963, 15, 'Ponta Porã', TO_DATE('2021-02-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (57, 13, 'IP', 1147155, 10, 'Belo Horizonte', TO_DATE('2023-08-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (58, 13, 'HP', 9650398, 64, 'Contagem', TO_DATE('2023-10-19', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (59, 13, 'UQ', 2206128, 13, 'Uberlândia', TO_DATE('2021-02-22', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (60, 13, 'YR', 7098544, 97, 'Juiz de Fora', TO_DATE('2022-02-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (61, 13, 'WN', 6119444, 69, 'Betim', TO_DATE('2021-11-01', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (62, 14, 'FC', 7329176, 99, 'Belém', TO_DATE('2022-05-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (63, 14, 'TS', 3393601, 41, 'Ananindeua', TO_DATE('2020-11-12', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (64, 14, 'AB', 4151320, 99, 'Santarém', TO_DATE('2021-05-12', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (65, 14, 'PR', 3505562, 98, 'Marabá', TO_DATE('2021-08-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (66, 14, 'DI', 2672652, 42, 'Castanhal', TO_DATE('2023-06-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (67, 15, 'KD', 3446820, 19, 'João Pessoa', TO_DATE('2021-02-17', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (68, 15, 'KA', 8592128, 66, 'Campina Grande', TO_DATE('2020-11-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (69, 15, 'QG', 2840902, 89, 'Santa Rita', TO_DATE('2023-05-04', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (70, 15, 'ED', 4273564, 66, 'Patos', TO_DATE('2022-06-18', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (71, 15, 'EU', 5371220, 20, 'Bayeux', TO_DATE('2020-09-18', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (72, 16, 'WM', 7930141, 48, 'Curitiba', TO_DATE('2023-01-29', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (73, 16, 'XO', 6216739, 87, 'Londrina', TO_DATE('2022-07-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (74, 16, 'RV', 5127267, 12, 'Maringá', TO_DATE('2020-03-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (75, 16, 'BH', 9737732, 99, 'Ponta Grossa', TO_DATE('2023-08-07', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (76, 16, 'GN', 8414440, 25, 'Cascavel', TO_DATE('2023-04-25', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (77, 17, 'XQ', 3324792, 86, 'Recife', TO_DATE('2020-09-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (78, 17, 'SP', 8301440, 69, 'Jaboatão dos Guararapes', TO_DATE('2022-05-18', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (79, 17, 'SC', 1912565, 76, 'Olinda', TO_DATE('2021-05-01', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (80, 17, 'FI', 1287263, 52, 'Caruaru', TO_DATE('2023-05-31', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (81, 17, 'SO', 8685120, 51, 'Petrolina', TO_DATE('2023-02-25', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (82, 18, 'IS', 5915457, 59, 'Teresina', TO_DATE('2021-11-17', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (83, 18, 'WS', 1804042, 0, 'Parnaíba', TO_DATE('2023-11-09', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (84, 18, 'WM', 220728, 55, 'Picos', TO_DATE('2023-03-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (85, 18, 'LX', 7411860, 54, 'Floriano', TO_DATE('2022-01-24', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (86, 18, 'FM', 8709154, 38, 'Campo Maior', TO_DATE('2021-09-29', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (87, 19, 'FM', 1786026, 93, 'Rio de Janeiro', TO_DATE('2021-05-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (88, 19, 'FA', 2714211, 85, 'São Gonçalo', TO_DATE('2020-12-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (89, 19, 'LI', 859689, 81, 'Duque de Caxias', TO_DATE('2021-07-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (90, 19, 'HD', 3322518, 94, 'Nova Iguaçu', TO_DATE('2020-08-01', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (91, 19, 'CY', 6740051, 33, 'Niterói', TO_DATE('2021-09-22', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (92, 20, 'MZ', 3798087, 35, 'Natal', TO_DATE('2022-02-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (93, 20, 'NZ', 8408920, 6, 'Mossoró', TO_DATE('2022-12-31', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (94, 20, 'TU', 8208044, 69, 'Parnamirim', TO_DATE('2020-12-02', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (95, 20, 'QK', 1216174, 74, 'São Gonçalo do Amarante', TO_DATE('2022-12-04', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (96, 20, 'NM', 2889957, 68, 'Ceará-Mirim', TO_DATE('2022-05-27', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (97, 21, 'VY', 9036172, 47, 'Porto Alegre', TO_DATE('2023-10-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (98, 21, 'YL', 2323927, 21, 'Caxias do Sul', TO_DATE('2020-04-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (99, 21, 'CM', 4864424, 47, 'Pelotas', TO_DATE('2021-09-29', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (100, 21, 'XB', 7201560, 9, 'Canoas', TO_DATE('2022-11-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (101, 21, 'LZ', 366223, 65, 'Santa Maria', TO_DATE('2020-02-05', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (102, 22, 'ST', 7009533, 30, 'Porto Velho', TO_DATE('2021-05-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (103, 22, 'QK', 9588827, 76, 'Ji-Paraná', TO_DATE('2021-10-13', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (104, 22, 'JI', 9387255, 81, 'Ariquemes', TO_DATE('2020-04-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (105, 22, 'UX', 7152135, 16, 'Vilhena', TO_DATE('2020-04-19', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (106, 22, 'CU', 8574727, 77, 'Cacoal', TO_DATE('2021-08-25', 'YYYY-MM-DD'));

    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (107, 23, 'DM', 5936735, 19, 'Boa Vista', TO_DATE('2022-10-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (108, 23, 'BN', 1127236, 16, 'Rorainópolis', TO_DATE('2020-03-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (109, 23, 'QR', 1397771, 59, 'Mucajaí', TO_DATE('2021-10-09', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (110, 23, 'PW', 183478, 97, 'Alto Alegre', TO_DATE('2020-10-01', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (111, 23, 'UR', 936391, 24, 'Pacaraima', TO_DATE('2021-06-21', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (112, 24, 'IC', 2029822, 2, 'Florianópolis', TO_DATE('2021-12-25', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (113, 24, 'HB', 9789733, 43, 'Joinville', TO_DATE('2020-12-06', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (114, 24, 'SN', 1428515, 92, 'Blumenau', TO_DATE('2020-09-05', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (115, 24, 'LG', 2023375, 55, 'São José', TO_DATE('2023-10-26', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (116, 24, 'VW', 8232118, 87, 'Criciúma', TO_DATE('2021-02-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (117, 25, 'LJ', 514126, 37, 'São Paulo', TO_DATE('2021-03-04', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (118, 25, 'HE', 1635397, 46, 'Guarulhos', TO_DATE('2020-03-25', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (119, 25, 'GU', 5788873, 92, 'Campinas', TO_DATE('2022-11-13', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (120, 25, 'SG', 6644409, 13, 'São Bernardo do Campo', TO_DATE('2020-04-09', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (121, 25, 'KG', 5963448, 18, 'Santo André', TO_DATE('2020-12-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (122, 26, 'UJ', 116393, 26, 'Aracaju', TO_DATE('2020-09-06', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (123, 26, 'IL', 3740129, 65, 'Nossa Senhora do Socorro', TO_DATE('2021-04-27', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (124, 26, 'ET', 4059505, 69, 'Lagarto', TO_DATE('2022-12-18', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (125, 26, 'QS', 6156977, 52, 'Itabaiana', TO_DATE('2020-07-11', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (126, 26, 'CX', 9697977, 19, 'Estância', TO_DATE('2020-08-25', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (127, 27, 'DA', 397691, 6, 'Palmas', TO_DATE('2023-04-26', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (128, 27, 'HG', 729687, 58, 'Araguaína', TO_DATE('2023-05-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (129, 27, 'BG', 9081271, 21, 'Gurupi', TO_DATE('2023-09-16', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (130, 27, 'GB', 5607674, 14, 'Porto Nacional', TO_DATE('2021-05-18', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (131, 27, 'VL', 3718787, 32, 'Paraíso do Tocantins', TO_DATE('2020-11-05', 'YYYY-MM-DD'));

    -- inserindo na tabela bairro


    INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
    VALUES (1, 1, 'Ferreira dos Dourados', 'Zona Norte', TO_DATE('2020-07-12', 'YYYY-MM-DD'));
        

    INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
    VALUES (2, 1, 'Pires', 'Centro', TO_DATE('2021-12-10', 'YYYY-MM-DD'));
        

    INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
    VALUES (3, 1, 'da Costa do Sul', 'Zona Norte', TO_DATE('2020-04-05', 'YYYY-MM-DD'));
        

        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (4, 1, 'Caldeira', 'Zona Oeste', TO_DATE('2021-11-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (5, 1, 'da Conceição', 'Zona Sul', TO_DATE('2021-02-19', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (6, 2, 'Aragão de Cunha', 'Zona Norte', TO_DATE('2020-11-25', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (7, 2, 'Jesus do Sul', 'Centro', TO_DATE('2022-08-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (8, 2, 'Caldeira', 'Zona Norte', TO_DATE('2023-03-14', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (9, 2, 'Sales', 'Zona Oeste', TO_DATE('2020-04-18', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (10, 2, 'Rezende de Correia', 'Zona Sul', TO_DATE('2020-04-14', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (11, 3, 'Martins de Rezende', 'Zona Norte', TO_DATE('2023-07-27', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (12, 3, 'Cardoso Paulista', 'Centro', TO_DATE('2021-04-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (13, 3, 'Costela', 'Zona Norte', TO_DATE('2023-11-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (14, 3, 'da Luz', 'Zona Oeste', TO_DATE('2020-12-17', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (15, 3, 'Teixeira de Goiás', 'Zona Sul', TO_DATE('2023-07-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (16, 4, 'Farias de Cavalcanti', 'Centro', TO_DATE('2022-02-14', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (17, 4, 'Gomes', 'Centro', TO_DATE('2023-02-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (18, 4, 'Santos da Serra', 'Zona Norte', TO_DATE('2020-07-12', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (19, 4, 'Vieira de Minas', 'Zona Oeste', TO_DATE('2021-12-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (20, 4, 'Duarte', 'Zona Sul', TO_DATE('2022-01-23', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (21, 5, 'da Luz das Flores', 'Zona Oeste', TO_DATE('2023-11-09', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (22, 5, 'Silva', 'Centro', TO_DATE('2021-07-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (23, 5, 'Cardoso', 'Zona Norte', TO_DATE('2020-02-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (24, 5, 'Ribeiro', 'Zona Oeste', TO_DATE('2023-09-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (25, 5, 'Duarte', 'Zona Sul', TO_DATE('2021-05-25', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (26, 6, 'Martins', 'Zona Oeste', TO_DATE('2022-03-02', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (27, 6, 'Rezende', 'Centro', TO_DATE('2021-02-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (28, 6, 'da Rocha Alegre', 'Zona Norte', TO_DATE('2021-09-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (29, 6, 'Monteiro', 'Zona Oeste', TO_DATE('2020-05-15', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (30, 6, 'Porto', 'Zona Sul', TO_DATE('2021-08-06', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (31, 7, 'Cunha', 'Zona Oeste', TO_DATE('2020-04-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (32, 7, 'Cardoso da Prata', 'Centro', TO_DATE('2020-05-08', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (33, 7, 'da Paz de Martins', 'Zona Norte', TO_DATE('2020-01-27', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (34, 7, 'Nascimento', 'Zona Oeste', TO_DATE('2023-01-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (35, 7, 'Moreira Verde', 'Zona Sul', TO_DATE('2021-03-31', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (36, 8, 'Rodrigues', 'Zona Oeste', TO_DATE('2022-06-24', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (37, 8, 'Peixoto do Oeste', 'Centro', TO_DATE('2021-06-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (38, 8, 'Moraes do Sul', 'Zona Norte', TO_DATE('2021-11-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (39, 8, 'Viana', 'Zona Oeste', TO_DATE('2022-11-11', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (40, 8, 'Lima', 'Zona Sul', TO_DATE('2021-01-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (41, 9, 'Silveira do Amparo', 'Zona Oeste', TO_DATE('2022-01-19', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (42, 9, 'da Cunha', 'Centro', TO_DATE('2023-08-27', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (43, 9, 'da Paz', 'Zona Norte', TO_DATE('2023-09-23', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (44, 9, 'Peixoto', 'Zona Oeste', TO_DATE('2022-02-26', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (45, 9, 'Ramos', 'Zona Sul', TO_DATE('2023-04-21', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (46, 10, 'Rocha', 'Zona Oeste', TO_DATE('2020-07-09', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (47, 10, 'Correia', 'Centro', TO_DATE('2021-09-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (48, 10, 'Araújo', 'Zona Norte', TO_DATE('2022-03-31', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (49, 10, 'Gomes', 'Zona Oeste', TO_DATE('2023-06-11', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (50, 10, 'da Luz Alegre', 'Zona Sul', TO_DATE('2023-01-06', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (51, 11, 'Rocha Alegre', 'Zona Oeste', TO_DATE('2021-12-24', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (52, 11, 'Lopes de Costa', 'Centro', TO_DATE('2023-01-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (53, 11, 'Monteiro', 'Zona Norte', TO_DATE('2022-07-04', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (54, 11, 'Ribeiro', 'Zona Oeste', TO_DATE('2022-02-21', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (55, 11, 'da Cunha do Campo', 'Zona Sul', TO_DATE('2023-05-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (56, 12, 'Alves', 'Zona Oeste', TO_DATE('2023-03-24', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (57, 12, 'da Rosa', 'Centro', TO_DATE('2020-02-12', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (58, 12, 'Pinto de Novaes', 'Zona Norte', TO_DATE('2020-04-17', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (59, 12, 'Castro do Norte', 'Zona Oeste', TO_DATE('2023-02-23', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (60, 12, 'Cardoso', 'Zona Sul', TO_DATE('2022-04-02', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (61, 13, 'Caldeira de Azevedo', 'Zona Oeste', TO_DATE('2022-11-19', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (62, 13, 'Barros de Silveira', 'Centro', TO_DATE('2022-09-29', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (63, 13, 'Lima', 'Zona Norte', TO_DATE('2022-06-13', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (64, 13, 'da Mota da Praia', 'Zona Oeste', TO_DATE('2023-04-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (65, 13, 'da Rocha', 'Zona Sul', TO_DATE('2021-03-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (66, 14, 'Melo de Goiás', 'Zona Oeste', TO_DATE('2022-12-31', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (67, 14, 'Nascimento Paulista', 'Centro', TO_DATE('2022-01-17', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (68, 14, 'Novaes dos Dourados', 'Zona Norte', TO_DATE('2023-02-24', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (69, 14, 'Farias', 'Zona Oeste', TO_DATE('2021-12-16', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (70, 14, 'Correia', 'Zona Sul', TO_DATE('2023-03-31', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (71, 15, 'da Mota', 'Zona Oeste', TO_DATE('2022-06-26', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (72, 15, 'da Rocha de Alves', 'Centro', TO_DATE('2023-08-07', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (73, 15, 'da Cruz de Goiás', 'Zona Norte', TO_DATE('2023-08-08', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (74, 15, 'Vieira', 'Zona Oeste', TO_DATE('2023-11-15', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (75, 15, 'Pinto de Fernandes', 'Zona Sul', TO_DATE('2022-12-26', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (76, 16, 'Nogueira dos Dourados', 'Zona Oeste', TO_DATE('2023-07-07', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (77, 16, 'Caldeira do Campo', 'Centro', TO_DATE('2021-12-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (78, 16, 'Ribeiro da Praia', 'Zona Norte', TO_DATE('2023-01-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (79, 16, 'da Costa', 'Zona Oeste', TO_DATE('2023-11-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (80, 16, 'Carvalho', 'Zona Sul', TO_DATE('2023-11-10', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (81, 17, 'Aragão de Cavalcanti', 'Zona Oeste', TO_DATE('2021-01-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (82, 17, 'Pereira da Serra', 'Centro', TO_DATE('2021-07-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (83, 17, 'Porto', 'Zona Norte', TO_DATE('2022-05-17', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (84, 17, 'da Costa', 'Zona Oeste', TO_DATE('2022-10-04', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (85, 17, 'Caldeira', 'Zona Sul', TO_DATE('2023-02-25', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (86, 18, 'da Paz de Goiás', 'Zona Oeste', TO_DATE('2022-06-18', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (87, 18, 'da Luz de Rocha', 'Centro', TO_DATE('2022-02-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (88, 18, 'Castro', 'Zona Norte', TO_DATE('2022-04-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (89, 18, 'Novaes', 'Zona Oeste', TO_DATE('2023-02-03', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (90, 18, 'da Luz de da Paz', 'Zona Sul', TO_DATE('2022-09-21', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (91, 19, 'Gonçalves', 'Zona Oeste', TO_DATE('2023-11-13', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (92, 19, 'Aragão Grande', 'Centro', TO_DATE('2020-01-11', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (93, 19, 'Cunha da Serra', 'Zona Norte', TO_DATE('2023-06-14', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (94, 19, 'Fernandes Paulista', 'Zona Oeste', TO_DATE('2021-08-11', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (95, 19, 'Carvalho da Serra', 'Zona Sul', TO_DATE('2020-12-07', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (96, 20, 'Alves de Nogueira', 'Zona Oeste', TO_DATE('2022-11-27', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (97, 20, 'da Rosa', 'Centro', TO_DATE('2022-07-04', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (98, 20, 'Viana da Serra', 'Zona Norte', TO_DATE('2021-08-15', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (99, 20, 'da Mota', 'Zona Oeste', TO_DATE('2022-09-12', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (100, 20, 'Porto', 'Zona Sul', TO_DATE('2022-08-03', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (101, 21, 'Nogueira Paulista', 'Zona Oeste', TO_DATE('2021-04-12', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (102, 21, 'Rodrigues', 'Centro', TO_DATE('2020-01-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (103, 21, 'Pinto', 'Zona Norte', TO_DATE('2023-04-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (104, 21, 'Jesus Paulista', 'Zona Oeste', TO_DATE('2020-01-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (105, 21, 'Pires', 'Zona Sul', TO_DATE('2022-09-07', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (106, 22, 'Cardoso', 'Zona Oeste', TO_DATE('2023-11-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (107, 22, 'Melo', 'Centro', TO_DATE('2023-10-18', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (108, 22, 'Porto', 'Zona Norte', TO_DATE('2022-10-14', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (109, 22, 'Moreira de Minas', 'Zona Oeste', TO_DATE('2022-05-23', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (110, 22, 'Pires do Galho', 'Zona Sul', TO_DATE('2023-10-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (111, 23, 'da Conceição', 'Zona Oeste', TO_DATE('2020-08-26', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (112, 23, 'da Luz Verde', 'Centro', TO_DATE('2020-01-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (113, 23, 'Nogueira', 'Zona Norte', TO_DATE('2020-05-29', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (114, 23, 'Moraes da Prata', 'Zona Oeste', TO_DATE('2020-08-31', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (115, 23, 'da Mota', 'Zona Sul', TO_DATE('2020-08-19', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (116, 24, 'Lima', 'Zona Oeste', TO_DATE('2023-04-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (117, 24, 'Barbosa de Aragão', 'Centro', TO_DATE('2021-06-04', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (118, 24, 'Cardoso', 'Zona Norte', TO_DATE('2020-05-26', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (119, 24, 'Moraes', 'Zona Oeste', TO_DATE('2023-01-02', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (120, 24, 'Oliveira', 'Zona Sul', TO_DATE('2021-12-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (121, 25, 'da Mata', 'Zona Oeste', TO_DATE('2021-11-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (122, 25, 'Almeida', 'Centro', TO_DATE('2020-04-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (123, 25, 'Aragão', 'Zona Norte', TO_DATE('2023-05-29', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (124, 25, 'da Costa', 'Zona Oeste', TO_DATE('2023-08-20', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (125, 25, 'Ramos de Rezende', 'Zona Sul', TO_DATE('2020-03-16', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (126, 26, 'Rezende Alegre', 'Zona Oeste', TO_DATE('2020-03-07', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (127, 26, 'da Mota Paulista', 'Centro', TO_DATE('2021-10-19', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (128, 26, 'Ribeiro Alegre', 'Zona Norte', TO_DATE('2021-07-15', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (129, 26, 'Pereira', 'Zona Oeste', TO_DATE('2023-08-13', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (130, 26, 'Almeida', 'Zona Sul', TO_DATE('2021-08-12', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (131, 27, 'da Conceição', 'Zona Oeste', TO_DATE('2023-03-10', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (132, 27, 'Gonçalves', 'Centro', TO_DATE('2022-10-15', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (133, 27, 'Viana', 'Zona Norte', TO_DATE('2020-05-17', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (134, 27, 'Lima de da Cruz', 'Zona Oeste', TO_DATE('2020-01-08', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (135, 27, 'Moraes da Praia', 'Zona Sul', TO_DATE('2023-02-01', 'YYYY-MM-DD'));
        
        -- inserindo os Logradouros 


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (1, 1, 'Jardim da Cruz', 53769514, TO_DATE('2023-04-12', 'YYYY-MM-DD'));
        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (2, 1, 'Jardim de da Paz', 43818474, TO_DATE('2020-08-26', 'YYYY-MM-DD'));
        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (3, 2, 'Setor de Fernandes', 10940608, TO_DATE('2023-02-10', 'YYYY-MM-DD'));
        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (4, 2, 'Recanto Valentina Ramos', 43150006, TO_DATE('2022-08-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (5, 2, 'Praia da Conceição', 51453929, TO_DATE('2021-10-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (6, 2, 'Vereda Melo', 19348888, TO_DATE('2022-04-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (7, 2, 'Trecho Farias', 70813646, TO_DATE('2023-04-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (8, 3, 'Quadra de Santos', 57644070, TO_DATE('2020-11-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (9, 3, 'Residencial Almeida', 39773173, TO_DATE('2021-06-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (10, 3, 'Via Laís Pinto', 55811094, TO_DATE('2020-06-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (11, 4, 'Praça João Miguel Castro', 41418134, TO_DATE('2021-08-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (12, 4, 'Travessa de da Rosa', 27592174, TO_DATE('2021-11-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (13, 4, 'Loteamento Nascimento', 57293811, TO_DATE('2023-07-11', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (14, 4, 'Setor Gomes', 33655788, TO_DATE('2021-05-20', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (15, 5, 'Setor de Castro', 99453939, TO_DATE('2022-04-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (16, 5, 'Lagoa Gomes', 87618925, TO_DATE('2021-01-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (17, 5, 'Jardim de Silveira', 83616453, TO_DATE('2021-08-03', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (18, 5, 'Conjunto de Araújo', 52212667, TO_DATE('2020-04-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (19, 5, 'Aeroporto Nunes', 36273436, TO_DATE('2021-09-25', 'YYYY-MM-DD'));


        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (25, 7, 'Condomínio de Gomes', 17803742, TO_DATE('2021-10-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (26, 7, 'Parque de Nunes', 74283192, TO_DATE('2023-09-20', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (27, 7, 'Feira Barros', 28767258, TO_DATE('2022-04-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (28, 8, 'Trecho Gustavo Henrique', 46221548, TO_DATE('2022-08-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (29, 8, 'Fazenda Evelyn Nunes', 95016912, TO_DATE('2022-08-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (30, 8, 'Campo Laura Dias', 85219067, TO_DATE('2022-10-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (31, 8, 'Campo de Pires', 38838569, TO_DATE('2023-06-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (32, 8, 'Distrito da Mata', 47774589, TO_DATE('2020-10-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (33, 9, 'Quadra Jesus', 92512870, TO_DATE('2021-09-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (34, 9, 'Lago Barbosa', 67043436, TO_DATE('2021-03-20', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (35, 9, 'Núcleo Gabrielly Lima', 91328534, TO_DATE('2021-10-10', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (36, 9, 'Residencial Nogueira', 19780467, TO_DATE('2023-06-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (37, 10, 'Fazenda Fernanda Farias', 5829687, TO_DATE('2022-03-24', 'YYYY-MM-DD'));


        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (43, 12, 'Alameda Pires', 93209298, TO_DATE('2020-02-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (44, 13, 'Pátio Maria Vitória Novaes', 66900573, TO_DATE('2022-11-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (45, 13, 'Trevo Julia Fernandes', 80968918, TO_DATE('2022-07-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (46, 13, 'Vereda Camila Ribeiro', 78908152, TO_DATE('2023-05-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (47, 13, 'Recanto da Conceição', 71757987, TO_DATE('2023-01-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (48, 14, 'Campo Castro', 29141606, TO_DATE('2021-02-05', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (49, 14, 'Estrada Laís Teixeira', 74920969, TO_DATE('2020-12-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (50, 14, 'Parque de Cavalcanti', 24651990, TO_DATE('2023-06-11', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (51, 14, 'Praia de Alves', 87197683, TO_DATE('2022-08-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (52, 14, 'Viaduto Ana Laura Fogaça', 6803732, TO_DATE('2020-11-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (53, 15, 'Viela Duarte', 71214846, TO_DATE('2020-07-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (54, 15, 'Viaduto Ramos', 34554473, TO_DATE('2021-08-21', 'YYYY-MM-DD'));


        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (56, 17, 'Sítio de Cavalcanti', 47239814, TO_DATE('2023-05-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (57, 17, 'Campo Camila Cardoso', 30049660, TO_DATE('2022-12-14', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (58, 18, 'Loteamento de Carvalho', 41313452, TO_DATE('2023-09-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (59, 18, 'Vila Pedro Lucas da Rosa', 6881502, TO_DATE('2021-01-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (60, 18, 'Vila Moura', 28628934, TO_DATE('2021-05-14', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (61, 19, 'Parque de Rodrigues', 48705426, TO_DATE('2021-05-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (62, 19, 'Pátio de Aragão', 87777436, TO_DATE('2022-05-05', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (63, 19, 'Vereda Luana Ramos', 21895184, TO_DATE('2023-06-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (64, 19, 'Fazenda Larissa Cardoso', 86410699, TO_DATE('2021-06-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (65, 19, 'Lagoa de Fernandes', 48555509, TO_DATE('2020-10-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (66, 20, 'Passarela de Silveira', 34625950, TO_DATE('2023-04-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (67, 20, 'Loteamento de Gonçalves', 69367132, TO_DATE('2022-10-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (68, 20, 'Passarela Correia', 67111780, TO_DATE('2023-09-22', 'YYYY-MM-DD'));


        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (70, 22, 'Feira de Viana', 14346188, TO_DATE('2023-03-03', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (71, 22, 'Avenida Sabrina da Mota', 65059640, TO_DATE('2021-11-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (72, 22, 'Chácara de Carvalho', 11075512, TO_DATE('2020-12-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (73, 23, 'Vereda Caroline da Rosa', 50247717, TO_DATE('2020-12-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (74, 23, 'Trecho Nogueira', 89682935, TO_DATE('2022-03-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (75, 23, 'Vereda de Fogaça', 43359677, TO_DATE('2021-11-04', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (76, 24, 'Chácara Pedro Lucas da Cruz', 76835975, TO_DATE('2021-09-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (77, 24, 'Via de Souza', 40448748, TO_DATE('2022-08-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (78, 25, 'Morro de Moura', 60146941, TO_DATE('2021-06-06', 'YYYY-MM-DD'));


       

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (84, 27, 'Parque da Rosa', 63921676, TO_DATE('2023-05-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (85, 28, 'Núcleo Costela', 1524410, TO_DATE('2021-06-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (86, 29, 'Vila Lucca Nunes', 88634569, TO_DATE('2021-08-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (87, 29, 'Loteamento Beatriz Rocha', 24797050, TO_DATE('2020-01-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (88, 30, 'Praia Correia', 54289853, TO_DATE('2020-08-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (89, 30, 'Residencial da Mata', 75178779, TO_DATE('2022-08-14', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (90, 31, 'Núcleo Castro', 55953547, TO_DATE('2022-07-07', 'YYYY-MM-DD'));


       
        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (94, 32, 'Ladeira da Mata', 40198264, TO_DATE('2020-08-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (95, 32, 'Ladeira Santos', 83819933, TO_DATE('2023-07-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (96, 32, 'Lago Viana', 99166344, TO_DATE('2023-09-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (97, 32, 'Distrito Marina Monteiro', 86295114, TO_DATE('2022-10-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (98, 32, 'Sítio Lorenzo Correia', 62907781, TO_DATE('2020-09-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (99, 33, 'Rua de Nascimento', 86911715, TO_DATE('2022-10-22', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (100, 33, 'Trecho de da Costa', 39157857, TO_DATE('2020-06-27', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (101, 34, 'Parque de da Cruz', 2364721, TO_DATE('2021-10-01', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (102, 34, 'Recanto da Cunha', 48025709, TO_DATE('2021-08-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (103, 34, 'Residencial Felipe Freitas', 76943777, TO_DATE('2022-06-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (104, 34, 'Vereda de Costa', 59477875, TO_DATE('2021-03-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (105, 34, 'Núcleo de Pinto', 8858614, TO_DATE('2021-02-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (106, 35, 'Ladeira Nunes', 73642364, TO_DATE('2021-03-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (107, 35, 'Lago Miguel Sales', 1473084, TO_DATE('2022-07-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (108, 35, 'Praia Alexia Mendes', 22905451, TO_DATE('2022-02-15', 'YYYY-MM-DD'));


       
        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (111, 37, 'Residencial Azevedo', 82276002, TO_DATE('2020-06-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (112, 38, 'Sítio Larissa Araújo', 37708716, TO_DATE('2020-04-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (113, 38, 'Vale Ana Beatriz da Paz', 21094393, TO_DATE('2022-01-31', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (114, 38, 'Largo Pedro Lucas Costela', 39068690, TO_DATE('2020-08-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (115, 39, 'Praia Laura Gomes', 97907761, TO_DATE('2020-01-27', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (116, 40, 'Condomínio Carvalho', 55849005, TO_DATE('2020-01-14', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (117, 40, 'Feira Matheus Mendes', 10198475, TO_DATE('2023-10-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (118, 40, 'Trecho de Moreira', 58052122, TO_DATE('2021-02-05', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (119, 40, 'Largo Fernanda Souza', 84820613, TO_DATE('2022-10-27', 'YYYY-MM-DD'));


        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (123, 42, 'Feira Duarte', 42677559, TO_DATE('2021-08-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (124, 42, 'Alameda João Gabriel Pinto', 30067113, TO_DATE('2021-04-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (125, 42, 'Loteamento Lopes', 42681508, TO_DATE('2020-03-10', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (126, 42, 'Feira de Farias', 58991086, TO_DATE('2022-08-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (127, 43, 'Pátio Porto', 88878490, TO_DATE('2020-03-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (128, 44, 'Travessa de Moraes', 88524874, TO_DATE('2021-05-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (129, 45, 'Travessa Camila Oliveira', 53029338, TO_DATE('2023-09-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (130, 45, 'Campo de Ribeiro', 25181467, TO_DATE('2022-08-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (131, 45, 'Praia Maria Eduarda Dias', 53675921, TO_DATE('2022-05-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (132, 45, 'Viaduto Cavalcanti', 76281355, TO_DATE('2023-05-11', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (133, 45, 'Morro da Mota', 92845506, TO_DATE('2023-01-18', 'YYYY-MM-DD'));



        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (139, 47, 'Alameda Araújo', 333469, TO_DATE('2020-10-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (140, 47, 'Feira de da Luz', 43083008, TO_DATE('2020-10-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (141, 47, 'Trecho Leandro Gomes', 33119516, TO_DATE('2021-02-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (142, 48, 'Residencial Maria Azevedo', 87920709, TO_DATE('2020-03-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (143, 48, 'Parque de Gomes', 12510697, TO_DATE('2022-04-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (144, 48, 'Trecho de Moraes', 45251134, TO_DATE('2023-11-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (145, 48, 'Favela de Melo', 34805140, TO_DATE('2020-05-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (146, 49, 'Vereda Maria Julia Melo', 74070588, TO_DATE('2022-04-03', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (147, 49, 'Rodovia Oliveira', 15457418, TO_DATE('2020-11-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (148, 49, 'Travessa de da Luz', 41536703, TO_DATE('2022-04-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (149, 49, 'Distrito Gomes', 1990002, TO_DATE('2023-07-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (150, 49, 'Ladeira Nicole Peixoto', 36810654, TO_DATE('2021-07-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (151, 50, 'Vale Sales', 47809209, TO_DATE('2021-05-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (152, 50, 'Trevo Julia Sales', 12383989, TO_DATE('2021-05-06', 'YYYY-MM-DD'));


       


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (154, 52, 'Via Milena Gomes', 49238397, TO_DATE('2023-11-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (155, 52, 'Ladeira Nicolas Costela', 1849809, TO_DATE('2020-03-01', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (156, 52, 'Loteamento de Moraes', 24778546, TO_DATE('2023-02-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (157, 52, 'Morro Júlia Monteiro', 81835221, TO_DATE('2020-11-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (158, 53, 'Estação Oliveira', 28278823, TO_DATE('2021-09-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (159, 53, 'Trecho Mendes', 90483903, TO_DATE('2020-06-10', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (160, 53, 'Ladeira Moura', 14996220, TO_DATE('2022-09-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (161, 54, 'Viaduto Pereira', 5179707, TO_DATE('2020-11-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (162, 55, 'Via da Mata', 43804668, TO_DATE('2023-02-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (163, 55, 'Lago Catarina Rocha', 26425050, TO_DATE('2020-08-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (164, 55, 'Praça Moreira', 7320784, TO_DATE('2021-10-18', 'YYYY-MM-DD'));


        


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (167, 57, 'Recanto de Moreira', 28127514, TO_DATE('2020-04-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (168, 57, 'Rua Barros', 3069073, TO_DATE('2022-08-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (169, 57, 'Praia das Neves', 28896791, TO_DATE('2022-06-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (170, 57, 'Lago Vieira', 10892033, TO_DATE('2023-02-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (171, 57, 'Vale Bryan Sales', 72844421, TO_DATE('2021-10-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (172, 58, 'Colônia Eloah Caldeira', 23478350, TO_DATE('2022-07-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (173, 58, 'Favela Yasmin Pinto', 65232936, TO_DATE('2022-01-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (174, 58, 'Quadra de Carvalho', 8480405, TO_DATE('2021-08-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (175, 59, 'Condomínio Enzo Pinto', 30717249, TO_DATE('2023-07-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (176, 60, 'Fazenda de Lopes', 41090940, TO_DATE('2020-12-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (177, 60, 'Rodovia de Moreira', 51144431, TO_DATE('2023-07-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (178, 60, 'Núcleo Lima', 45527055, TO_DATE('2020-09-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (179, 60, 'Jardim de Sales', 67562261, TO_DATE('2022-09-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (180, 60, 'Parque das Neves', 38387082, TO_DATE('2020-05-16', 'YYYY-MM-DD'));


        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (184, 62, 'Passarela de Nunes', 71738503, TO_DATE('2021-07-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (185, 62, 'Vale Novaes', 63869991, TO_DATE('2021-08-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (186, 63, 'Setor de Cardoso', 99603789, TO_DATE('2021-06-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (187, 63, 'Vila Cunha', 60065964, TO_DATE('2022-05-01', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (188, 63, 'Praia Fernandes', 14742470, TO_DATE('2020-02-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (189, 64, 'Conjunto de Vieira', 10266553, TO_DATE('2021-02-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (190, 64, 'Residencial de Jesus', 68526928, TO_DATE('2022-12-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (191, 64, 'Núcleo de Cunha', 77617310, TO_DATE('2021-12-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (192, 64, 'Morro da Luz', 12140698, TO_DATE('2020-01-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (193, 65, 'Via Enzo Gabriel Barros', 89141811, TO_DATE('2020-07-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (194, 65, 'Jardim de Oliveira', 77734167, TO_DATE('2022-11-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (195, 65, 'Setor de Cavalcanti', 55032568, TO_DATE('2021-04-17', 'YYYY-MM-DD'));


        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (199, 67, 'Colônia Alice Gonçalves', 54702033, TO_DATE('2021-10-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (200, 67, 'Travessa da Luz', 2929060, TO_DATE('2022-01-05', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (201, 68, 'Sítio Eduarda Rodrigues', 77221763, TO_DATE('2023-01-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (202, 68, 'Feira Pires', 71881815, TO_DATE('2021-08-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (203, 68, 'Avenida Nascimento', 97538512, TO_DATE('2020-09-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (204, 69, 'Distrito de da Cunha', 56731193, TO_DATE('2022-12-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (205, 69, 'Colônia de Souza', 18610624, TO_DATE('2023-05-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (206, 69, 'Lagoa das Neves', 21322681, TO_DATE('2020-01-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (207, 69, 'Viela Aragão', 38079808, TO_DATE('2023-09-22', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (208, 70, 'Rua Laura Castro', 91438362, TO_DATE('2021-08-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (209, 70, 'Colônia de Rezende', 625784, TO_DATE('2023-07-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (210, 70, 'Sítio Maria Costela', 91177282, TO_DATE('2022-04-08', 'YYYY-MM-DD'));


    


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (216, 72, 'Núcleo de Novaes', 28621620, TO_DATE('2022-09-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (217, 72, 'Campo de da Cruz', 48332143, TO_DATE('2020-01-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (218, 72, 'Praia Melissa Almeida', 64955137, TO_DATE('2023-07-10', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (219, 73, 'Vale de da Mota', 78285553, TO_DATE('2021-09-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (220, 73, 'Vila de Moreira', 22954599, TO_DATE('2020-10-03', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (221, 73, 'Campo Fogaça', 84333859, TO_DATE('2023-10-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (222, 73, 'Avenida de Castro', 87286784, TO_DATE('2020-11-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (223, 73, 'Lagoa Maria Cecília Rezende', 23987199, TO_DATE('2020-07-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (224, 74, 'Feira Theo Almeida', 20188688, TO_DATE('2023-03-03', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (225, 74, 'Praça Nascimento', 41707569, TO_DATE('2020-01-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (226, 74, 'Condomínio de Araújo', 40615387, TO_DATE('2023-04-01', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (227, 74, 'Morro de Fogaça', 48191343, TO_DATE('2021-11-22', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (228, 75, 'Vila Cardoso', 68442867, TO_DATE('2021-12-31', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (229, 75, 'Viela Ana Júlia Rodrigues', 41154470, TO_DATE('2023-06-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (230, 75, 'Parque de da Rosa', 733083, TO_DATE('2021-05-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (231, 77, 'Estação de Nogueira', 80028731, TO_DATE('2023-04-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (232, 77, 'Área de Rocha', 99112445, TO_DATE('2022-03-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (233, 78, 'Jardim Heitor Dias', 76436715, TO_DATE('2023-08-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (234, 78, 'Área Rodrigues', 92861851, TO_DATE('2023-02-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (235, 79, 'Viela de Santos', 42221350, TO_DATE('2021-12-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (236, 79, 'Fazenda Marcelo Dias', 68080526, TO_DATE('2020-04-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (237, 79, 'Travessa Cunha', 61053637, TO_DATE('2023-06-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (238, 80, 'Área de Correia', 46427281, TO_DATE('2022-11-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (239, 80, 'Campo de Fogaça', 80246945, TO_DATE('2023-03-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (240, 80, 'Via de da Cruz', 60375822, TO_DATE('2021-02-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (241, 80, 'Ladeira Alexia Novaes', 50491400, TO_DATE('2021-06-12', 'YYYY-MM-DD'));
        
          
          
          
          INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
         VALUES (1, 'Isabella Nunes', 67122920050, '511386395', TO_DATE('1982-12-28', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-07-12', 'YYYY-MM-DD'), 'davi-luiz52@example.net', 'zQa#E4HoV9');
    
        INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (2, 'Marcela da Mata', 64877341156, '258574258', TO_DATE('1990-05-23', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'pribeiro@example.net', 'ja8C1R#b)n');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (3, 'Srta. Laís Pereira', 1230254153, '942296991', TO_DATE('1989-12-12', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-10-24', 'YYYY-MM-DD'), 'scampos@example.net', 'H)8*SwrTJ&');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (4, 'Henrique da Luz', 50533475809, '174695393', TO_DATE('1945-11-27', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-11-02', 'YYYY-MM-DD'), 'freitasisaac@example.net', '+fs1EzQxrQ');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (5, 'Murilo Cardoso', 89796515665, '828367878', TO_DATE('1945-07-11', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-03-07', 'YYYY-MM-DD'), 'ana-livia00@example.org', 'AU$1zRwbxQ');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (6, 'Leandro Lopes', 48381424490, '5672846', TO_DATE('1955-05-19', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-10-20', 'YYYY-MM-DD'), 'carvalhoevelyn@example.com', 'k68f9Bwl#1');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (7, 'Arthur Caldeira', 88713372008, '39515305', TO_DATE('1967-05-23', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'fpinto@example.net', '(9d&PBlm8#');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (8, 'Larissa Nunes', 74468185043, '543103211', TO_DATE('1950-01-09', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-04-25', 'YYYY-MM-DD'), 'correialorena@example.org', 'a^F!5O4tXy');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (9, 'Sr. Vitor Carvalho', 85224566982, '747057680', TO_DATE('2003-06-28', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-10-14', 'YYYY-MM-DD'), 'da-luzbeatriz@example.com', 'o4+SAGi*)f');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (10, 'Sophie Rodrigues', 41155212251, '312656695', TO_DATE('1980-01-04', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-10-09', 'YYYY-MM-DD'), 'luiz-fernando94@example.net', '((45iRPoxO');

           Commit;
    
    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (1, 1, 1, 4158, 'Quae provident dolorum sed.', 'Eligendi assumenda sequi.',
            TO_DATE('2022-10-12', 'YYYY-MM-DD'), TO_DATE('2024-10-02', 'YYYY-MM-DD'), TO_DATE('2020-07-28', 'YYYY-MM-DD'));
    

    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (2, 2, 2, 4910, 'Culpa quas neque molestias.', 'Rerum animi sequi animi.',
            TO_DATE('2023-01-06', 'YYYY-MM-DD'), TO_DATE('2024-01-09', 'YYYY-MM-DD'), TO_DATE('2022-02-01', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (3, 3, 3, 8576, 'Omnis et non et.', 'Aut dicta qui iusto.',
            TO_DATE('2023-03-11', 'YYYY-MM-DD'), TO_DATE('2024-07-05', 'YYYY-MM-DD'), TO_DATE('2022-07-13', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (4, 4, 4, 8000, 'Neque tempora cum corrupti.', 'Labore atque id.',
            TO_DATE('2023-11-13', 'YYYY-MM-DD'), TO_DATE('2024-06-09', 'YYYY-MM-DD'), TO_DATE('2023-03-03', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (5, 5, 5, 3649, 'Possimus magni qui voluptas.', 'Vel eos quibusdam tempore.',
            TO_DATE('2023-10-25', 'YYYY-MM-DD'), TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2021-10-28', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (6, 6, 6, 2197, 'Libero optio optio error.', 'Necessitatibus quia vero.',
            TO_DATE('2021-11-05', 'YYYY-MM-DD'), TO_DATE('2024-05-28', 'YYYY-MM-DD'), TO_DATE('2022-02-14', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (7, 7, 7, 1419, 'Minima laudantium cumque.', 'Ipsum dolorem reprehenderit.',
            TO_DATE('2020-03-08', 'YYYY-MM-DD'), TO_DATE('2024-01-29', 'YYYY-MM-DD'), TO_DATE('2020-04-28', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (8, 8, 8, 990, 'Quae quibusdam assumenda.', 'Aliquam eos laboriosam quia.',
            TO_DATE('2022-04-07', 'YYYY-MM-DD'), TO_DATE('2024-08-04', 'YYYY-MM-DD'), TO_DATE('2021-07-31', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (9, 9, 9, 1359, 'Unde inventore tenetur harum.', 'Vel mollitia iste inventore.',
            TO_DATE('2020-02-11', 'YYYY-MM-DD'), TO_DATE('2024-08-13', 'YYYY-MM-DD'), TO_DATE('2020-01-16', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (10, 10, 10, 9107, 'Qui dolorum hic maiores.', 'Enim soluta itaque excepturi.',
            TO_DATE('2021-07-31', 'YYYY-MM-DD'), TO_DATE('2024-01-04', 'YYYY-MM-DD'), TO_DATE('2020-04-22', 'YYYY-MM-DD'));
 COMMIT;
 -- telefone


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (1, 1, 675, 27, 652353409, 'Celular', 'A', TO_DATE('2020-08-03', 'YYYY-MM-DD'));
    

    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (2, 2, 307, 58, 475680253, 'Comercial', 'A', TO_DATE('2023-05-30', 'YYYY-MM-DD'));
    

    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (3, 3, 497, 22, 918077506, 'Comercial', 'A', TO_DATE('2020-09-25', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (4, 4, 911, 83, 210049347, 'Comercial', 'I', TO_DATE('2021-08-24', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (5, 5, 230, 77, 956251838, 'Comercial', 'A', TO_DATE('2023-10-09', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (6, 6, 396, 94, 904289180, 'Celular', 'I', TO_DATE('2023-08-07', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (7, 7, 298, 68, 69583931, 'Comercial', 'I', TO_DATE('2021-02-08', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (8, 8, 280, 94, 348672596, 'Celular', 'A', TO_DATE('2021-01-25', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (9, 9, 734, 29, 215553899, 'Celular', 'A', TO_DATE('2021-11-02', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (10, 10, 977, 96, 3295688, 'Residencial', 'I', TO_DATE('2023-08-19', 'YYYY-MM-DD'));
    COMMIT;
    
     -- inserindo o tipo de contato 


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (1, 'Residencia', TO_DATE('2021-07-04', 'YYYY-MM-DD'), TO_DATE('2024-04-04', 'YYYY-MM-DD'), TO_DATE('2022-09-25', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (2, 'Celular', TO_DATE('2023-04-04', 'YYYY-MM-DD'), TO_DATE('2024-04-13', 'YYYY-MM-DD'), TO_DATE('2022-08-05', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (3, 'E-mail P', TO_DATE('2021-07-18', 'YYYY-MM-DD'), TO_DATE('2022-05-31', 'YYYY-MM-DD'), TO_DATE('2021-05-05', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (4, 'E-mail Pro', TO_DATE('2022-04-18', 'YYYY-MM-DD'), TO_DATE('2023-04-17', 'YYYY-MM-DD'), TO_DATE('2021-02-28', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (5, 'WhatsApp', TO_DATE('2020-04-05', 'YYYY-MM-DD'), TO_DATE('2022-07-21', 'YYYY-MM-DD'), TO_DATE('2023-05-12', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (6, 'Skype', TO_DATE('2020-09-22', 'YYYY-MM-DD'), TO_DATE('2022-05-19', 'YYYY-MM-DD'), TO_DATE('2022-07-16', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (7, 'Telegram', TO_DATE('2021-05-03', 'YYYY-MM-DD'), TO_DATE('2023-05-25', 'YYYY-MM-DD'), TO_DATE('2023-09-24', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (8, 'fax', TO_DATE('2023-02-26', 'YYYY-MM-DD'), TO_DATE('2023-09-28', 'YYYY-MM-DD'), TO_DATE('2020-06-28', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (9, 'Linkedin', TO_DATE('2020-06-09', 'YYYY-MM-DD'), TO_DATE('2023-09-23', 'YYYY-MM-DD'), TO_DATE('2021-11-06', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (10, 'Twitter', TO_DATE('2020-10-19', 'YYYY-MM-DD'), TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-07-07', 'YYYY-MM-DD'));
    
    -- tipos de tg_contato_usuario




INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
VALUES (1, 1, 1, 'pariatur', 776, 307, 1091466318, TO_DATE('2022-12-17', 'YYYY-MM-DD'));


INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
VALUES (2, 2, 2, 'labore', 396, 282, 6330743183, TO_DATE('2021-04-10', 'YYYY-MM-DD'));


INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
 VALUES (3, 3, 3, 'mãe', 702, 576, 7591999049, TO_DATE('2020-03-19', 'YYYY-MM-DD'));


INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
VALUES (4, 4, 4, 'ullam', 944, 731, 4001771743, TO_DATE('2022-09-09', 'YYYY-MM-DD'));

INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
VALUES (5, 5, 5, 'optio', 617, 426, 5416416940, TO_DATE('2021-01-10', 'YYYY-MM-DD'));


INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
VALUES (6, 6, 6, 'aperiam', 243, 271, 1750714313, TO_DATE('2023-02-16', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (7, 7, 7, 'asperiores', 782, 466, 6329430296, TO_DATE('2020-11-17', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (8, 8, 8, 'in', 606, 978, 5114840316, TO_DATE('2023-05-26', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (9, 9, 9, 'iste', 361, 822, 2920283648, TO_DATE('2023-02-09', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (10, 10, 10, 'omnis', 211, 799, 6776773068, TO_DATE('2023-05-28', 'YYYY-MM-DD'));
    COMMIT; 
    
    
    -- Fornecedor
    
    
    
    
    INSERT INTO tg_fornecedor (id_fornecedor, nm_fornecedor, nm_localizacao, nr_fornecedor, id_usuario)
VALUES (1, 'Cleiton Xavier Ramalho', 'Diadema', 1234567890, 1);

INSERT INTO tg_fornecedor (id_fornecedor, nm_fornecedor, nm_localizacao, nr_fornecedor, id_usuario)
VALUES (2, 'Chico Moedas', 'Bangu', 2345678901, 2);

INSERT INTO tg_fornecedor (id_fornecedor, nm_fornecedor, nm_localizacao, nr_fornecedor, id_usuario)
VALUES (3, 'Renato Oliveira Augustin', 'Grajaú', 3456789012, 3);

INSERT INTO tg_fornecedor (id_fornecedor, nm_fornecedor, nm_localizacao, nr_fornecedor, id_usuario)
VALUES (4, 'Roberto Carlos de Andrade', 'São Paulo ', 4567890123, 4);

INSERT INTO tg_fornecedor (id_fornecedor, nm_fornecedor, nm_localizacao, nr_fornecedor, id_usuario)
VALUES (5, 'Thalisson Jefferson', 'Bahia', 5678901234, 5);

INSERT INTO tg_fornecedor (id_fornecedor, nm_fornecedor, nm_localizacao, nr_fornecedor, id_usuario)
VALUES (6, 'Dorival Junior Santos', 'Mato Grosso', 6789012345, 6);

INSERT INTO tg_fornecedor (id_fornecedor, nm_fornecedor, nm_localizacao, nr_fornecedor, id_usuario)
VALUES (7, 'Severino Almeida', 'Maringá', 7890123456, 7);

INSERT INTO tg_fornecedor (id_fornecedor, nm_fornecedor, nm_localizacao, nr_fornecedor, id_usuario)
VALUES (8, 'Cristiano Lionel ', 'Botafogo', 8901234567, 8);

INSERT INTO tg_fornecedor (id_fornecedor, nm_fornecedor, nm_localizacao, nr_fornecedor, id_usuario)
VALUES (9, 'Ibson Dias', 'Santos', 9012345678, 9);

INSERT INTO tg_fornecedor (id_fornecedor, nm_fornecedor, nm_localizacao, nr_fornecedor, id_usuario)
VALUES (10, 'Casimiro Angelo', 'Realengo', 1234567890, 10);
Commit;    


-- vegetais 



INSERT INTO tg_vegetais (id_vegetais, id_usuario, nm_vegetais, st_vegetal, lk_imagem, dt_imagem)
VALUES (1, 1, 'Tomate', 'F', 'tomate.jpg', TO_DATE('2024-04-14', 'YYYY-MM-DD'));


INSERT INTO tg_vegetais (id_vegetais, id_usuario, nm_vegetais, st_vegetal, lk_imagem, dt_imagem)
VALUES (2, 2, 'Alface', 'F', 'alface.jpg', TO_DATE('2024-04-15', 'YYYY-MM-DD'));


INSERT INTO tg_vegetais (id_vegetais, id_usuario, nm_vegetais, st_vegetal, lk_imagem, dt_imagem)
VALUES (3, 3, 'Cenoura', 'F', 'cenoura.jpg', TO_DATE('2024-04-16', 'YYYY-MM-DD'));


INSERT INTO tg_vegetais (id_vegetais, id_usuario, nm_vegetais, st_vegetal, lk_imagem, dt_imagem)
VALUES (4, 4, 'Beterraba', 'F', 'beterraba.jpg', TO_DATE('2024-04-17', 'YYYY-MM-DD'));


INSERT INTO tg_vegetais (id_vegetais, id_usuario, nm_vegetais, st_vegetal, lk_imagem, dt_imagem)
VALUES (5, 5, 'Pepino', 'F', 'pepino.jpg', TO_DATE('2024-04-18', 'YYYY-MM-DD'));


INSERT INTO tg_vegetais (id_vegetais, id_usuario, nm_vegetais, st_vegetal, lk_imagem, dt_imagem)
VALUES (6, 1, 'Abóbora', 'F', 'abobora.jpg', TO_DATE('2024-04-19', 'YYYY-MM-DD'));


INSERT INTO tg_vegetais (id_vegetais, id_usuario, nm_vegetais, st_vegetal, lk_imagem, dt_imagem)
VALUES (7, 2, 'Brócolis', 'F', 'brocolis.jpg', TO_DATE('2024-04-20', 'YYYY-MM-DD'));


INSERT INTO tg_vegetais (id_vegetais, id_usuario, nm_vegetais, st_vegetal, lk_imagem, dt_imagem)
VALUES (8, 3, 'Batata', 'F', 'batata.jpg', TO_DATE('2024-04-21', 'YYYY-MM-DD'));


INSERT INTO tg_vegetais (id_vegetais, id_usuario, nm_vegetais, st_vegetal, lk_imagem, dt_imagem)
VALUES (9, 4, 'Repolho', 'F', 'repolho.jpg', TO_DATE('2024-04-22', 'YYYY-MM-DD'));


INSERT INTO tg_vegetais (id_vegetais, id_usuario, nm_vegetais, st_vegetal, lk_imagem, dt_imagem)
VALUES (10, 5, 'Cebola', 'F', 'cebola.jpg', TO_DATE('2024-04-23', 'YYYY-MM-DD'));


-- transação



INSERT INTO tg_transacao (id_transacao, id_fornecedor, id_vegetais, qnt_vegetais, dt_transacao, nr_preco_unitario, nr_total_transacao)
VALUES (1, 1, 1, 10, TO_DATE('2024-04-14', 'YYYY-MM-DD'), 5.99, 59.90);


INSERT INTO tg_transacao (id_transacao, id_fornecedor, id_vegetais, qnt_vegetais, dt_transacao, nr_preco_unitario, nr_total_transacao)
VALUES (2, 2, 2, 8, TO_DATE('2024-04-15', 'YYYY-MM-DD'), 3.50, 28.00);


INSERT INTO tg_transacao (id_transacao, id_fornecedor, id_vegetais, qnt_vegetais, dt_transacao, nr_preco_unitario, nr_total_transacao)
VALUES (3, 3, 3, 15, TO_DATE('2024-04-16', 'YYYY-MM-DD'), 2.75, 41.25);


INSERT INTO tg_transacao (id_transacao, id_fornecedor, id_vegetais, qnt_vegetais, dt_transacao, nr_preco_unitario, nr_total_transacao)
VALUES (4, 4, 4, 20, TO_DATE('2024-04-17', 'YYYY-MM-DD'), 4.25, 85.00);


INSERT INTO tg_transacao (id_transacao, id_fornecedor, id_vegetais, qnt_vegetais, dt_transacao, nr_preco_unitario, nr_total_transacao)
VALUES (5, 5, 5, 12, TO_DATE('2024-04-18', 'YYYY-MM-DD'), 6.99, 83.88);

    
-- Bloco Anônimo 1: Consultas com junções
SET SERVEROUTPUT ON;

DECLARE
    v_id_vegetais tg_vegetais.id_vegetais%TYPE;
    v_nm_vegetais tg_vegetais.nm_vegetais%TYPE;
    v_id_fornecedor tg_fornecedor.id_fornecedor%TYPE;
    v_nm_fornecedor tg_fornecedor.nm_fornecedor%TYPE;
    v_qnt_vegetais tg_transacao.qnt_vegetais%TYPE;
BEGIN
    -- Consulta 1: Lista os vegetais comprados com seus fornecedores e quantidades
    FOR veg IN (
        SELECT v.id_vegetais, v.nm_vegetais, f.nm_fornecedor, t.qnt_vegetais
        FROM tg_vegetais v
        INNER JOIN tg_transacao t ON v.id_vegetais = t.id_vegetais
        INNER JOIN tg_fornecedor f ON t.id_fornecedor = f.id_fornecedor
        ORDER BY v.nm_vegetais
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Vegetal: ' || veg.nm_vegetais || ', Fornecedor: ' || veg.nm_fornecedor || ', Quantidade: ' || veg.qnt_vegetais);
    END LOOP;

    -- Consulta 2: Lista os vegetais comprados ordenados por quantidade
    FOR veg_qnt IN (
        SELECT v.nm_vegetais, SUM(t.qnt_vegetais) AS total_qnt
        FROM tg_vegetais v
        INNER JOIN tg_transacao t ON v.id_vegetais = t.id_vegetais
        GROUP BY v.nm_vegetais
        ORDER BY total_qnt DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Vegetal: ' || veg_qnt.nm_vegetais || ', Total Quantidade: ' || veg_qnt.total_qnt);
    END LOOP;

    -- Consulta 3: Lista fornecedores com o número total de transações realizadas
    FOR forn_trans IN (
        SELECT f.nm_fornecedor, COUNT(t.id_transacao) AS total_transacoes
        FROM tg_fornecedor f
        INNER JOIN tg_transacao t ON f.id_fornecedor = t.id_fornecedor
        GROUP BY f.nm_fornecedor
        ORDER BY total_transacoes DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Fornecedor: ' || forn_trans.nm_fornecedor || ', Total Transações: ' || forn_trans.total_transacoes);
    END LOOP;
END;
/

SET SERVEROUTPUT ON;

DECLARE
    v_id_endereco tg_endereco_usuario.id_endereco%TYPE;
    v_nm_usuario tg_usuario.nm_usuario%TYPE;
    v_nm_logradouro tg_logradouro.nm_logradouro%TYPE;
    v_nr_cep tg_logradouro.nr_cep%TYPE;
BEGIN
    -- Consulta 1: Listar os usuários com seus endereços completos (logradouro, número, complemento)
    DBMS_OUTPUT.PUT_LINE('Consulta 1: Listando os usuários com seus endereços completos...');
    FOR usuario_endereco IN (
        SELECT u.nm_usuario, l.nm_logradouro, eu.nr_logradouro, eu.ds_complemento
        FROM tg_usuario u
        INNER JOIN tg_endereco_usuario eu ON u.id_usuario = eu.id_usuario
        INNER JOIN tg_logradouro l ON eu.id_logradouro = l.id_logradouro
        ORDER BY u.nm_usuario
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Usuário: ' || usuario_endereco.nm_usuario || ', Endereço: ' || usuario_endereco.nm_logradouro || ', Número: ' || usuario_endereco.nr_logradouro || ', Complemento: ' || usuario_endereco.ds_complemento);
    END LOOP;

    -- Consulta 2: Listar a contagem de usuários por logradouro
    DBMS_OUTPUT.PUT_LINE('Consulta 2: Listando a contagem de usuários por logradouro...');
    FOR logradouro_usuarios IN (
        SELECT l.nm_logradouro, COUNT(DISTINCT eu.id_usuario) AS total_usuarios
        FROM tg_logradouro l
        INNER JOIN tg_endereco_usuario eu ON l.id_logradouro = eu.id_logradouro
        GROUP BY l.nm_logradouro
        ORDER BY total_usuarios DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Logradouro: ' || logradouro_usuarios.nm_logradouro || ', Total Usuários: ' || logradouro_usuarios.total_usuarios);
    END LOOP;

    -- Consulta 3: Listar os usuários com mais de um endereço cadastrado
    DBMS_OUTPUT.PUT_LINE('Consulta 3: Listando os usuários com mais de um endereço cadastrado...');
    FOR usuario_mult_endereco IN (
        SELECT u.nm_usuario, COUNT(eu.id_endereco) AS total_enderecos
        FROM tg_usuario u
        INNER JOIN tg_endereco_usuario eu ON u.id_usuario = eu.id_usuario
        GROUP BY u.nm_usuario
        HAVING COUNT(eu.id_endereco) > 1
        ORDER BY total_enderecos DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Usuário: ' || usuario_mult_endereco.nm_usuario || ', Total Endereços: ' || usuario_mult_endereco.total_enderecos);
    END LOOP;
END;
/










        