-- Bloco An�nimo 1: Consultas com jun��es
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

    -- Consulta 3: Lista fornecedores com o n�mero total de transa��es realizadas
    FOR forn_trans IN (
        SELECT f.nm_fornecedor, COUNT(t.id_transacao) AS total_transacoes
        FROM tg_fornecedor f
        INNER JOIN tg_transacao t ON f.id_fornecedor = t.id_fornecedor
        GROUP BY f.nm_fornecedor
        ORDER BY total_transacoes DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Fornecedor: ' || forn_trans.nm_fornecedor || ', Total Transa��es: ' || forn_trans.total_transacoes);
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
    -- Consulta 1: Listar os usu�rios com seus endere�os completos (logradouro, n�mero, complemento)
    DBMS_OUTPUT.PUT_LINE('Consulta 1: Listando os usu�rios com seus endere�os completos...');
    FOR usuario_endereco IN (
        SELECT u.nm_usuario, l.nm_logradouro, eu.nr_logradouro, eu.ds_complemento
        FROM tg_usuario u
        INNER JOIN tg_endereco_usuario eu ON u.id_usuario = eu.id_usuario
        INNER JOIN tg_logradouro l ON eu.id_logradouro = l.id_logradouro
        ORDER BY u.nm_usuario
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Usu�rio: ' || usuario_endereco.nm_usuario || ', Endere�o: ' || usuario_endereco.nm_logradouro || ', N�mero: ' || usuario_endereco.nr_logradouro || ', Complemento: ' || usuario_endereco.ds_complemento);
    END LOOP;

    -- Consulta 2: Listar a contagem de usu�rios por logradouro
    DBMS_OUTPUT.PUT_LINE('Consulta 2: Listando a contagem de usu�rios por logradouro...');
    FOR logradouro_usuarios IN (
        SELECT l.nm_logradouro, COUNT(DISTINCT eu.id_usuario) AS total_usuarios
        FROM tg_logradouro l
        INNER JOIN tg_endereco_usuario eu ON l.id_logradouro = eu.id_logradouro
        GROUP BY l.nm_logradouro
        ORDER BY total_usuarios DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Logradouro: ' || logradouro_usuarios.nm_logradouro || ', Total Usu�rios: ' || logradouro_usuarios.total_usuarios);
    END LOOP;

    -- Consulta 3: Listar os usu�rios com mais de um endere�o cadastrado
    DBMS_OUTPUT.PUT_LINE('Consulta 3: Listando os usu�rios com mais de um endere�o cadastrado...');
    FOR usuario_mult_endereco IN (
        SELECT u.nm_usuario, COUNT(eu.id_endereco) AS total_enderecos
        FROM tg_usuario u
        INNER JOIN tg_endereco_usuario eu ON u.id_usuario = eu.id_usuario
        GROUP BY u.nm_usuario
        HAVING COUNT(eu.id_endereco) > 1
        ORDER BY total_enderecos DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Usu�rio: ' || usuario_mult_endereco.nm_usuario || ', Total Endere�os: ' || usuario_mult_endereco.total_enderecos);
    END LOOP;
END;
/

