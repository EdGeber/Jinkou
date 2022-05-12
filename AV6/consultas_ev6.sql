-- SELECT DEREF
-- Retorna os cpfs e as contas da tabela tb_movimenta
SELECT DEREF(m.cliente).cpf AS CPF_CLIENTE, m.conta.numero_conta AS NUMERO_CONTA, m.conta.numero_agencia AS NUMERO_AGENCIA FROM tb_movimenta m;

-- CONSULTA A VARRAY
-- Retorna as ocupações do cliente com cpf 001
SELECT O.* FROM tb_cliente c, TABLE(c.ocupacoes) O WHERE c.cpf = '001';

-- CONSULTA A NESTED TABLE
-- Retorna os dependentes da pessoa com cpf 462
SELECT dep.* FROM TB_RELAC_DEPENDENTE_PESSOA rdp, TABLE(rdp.dependentes) dep WHERE rdp.cpf = '462';

-- CONSULTA À TABELA tb_transfere
SELECT data, horario, valor, status, motivo, t.conta_orig.numero_agencia AS numero_agencia_orig, t.conta_orig.numero_conta AS numero_conta_orig, t.conta_dest.numero_agencia AS numero_agencia_dest, t.conta_dest.numero_conta AS numero_conta_dest, DEREF(t.auditor).cpf AS cpf_auditor FROM tb_transfere t;

-- BLOCO ANÔNIMO PARA PRINTAR AS INFORMAÇÕES DAS CONTAS DO CLIENTE QUE TEM O CPF 001 USANDO UM CURSOR
DECLARE
    CURSOR contas_cpf_movimenta IS SELECT DEREF(m.conta), DEREF(m.cliente) FROM tb_movimenta m WHERE m.cliente.cpf = '001';
    cnt tp_conta;
    cli tp_cliente;
    BEGIN
        OPEN contas_cpf_movimenta;
        LOOP
            FETCH contas_cpf_movimenta INTO cnt, cli;
            EXIT WHEN contas_cpf_movimenta%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Proprietário da conta: '||cli.primeiro_nome||' '||cli.sobrenomes_centrais||' '||cli.ultimo_nome);
            cnt.exibirDetalhesConta();
            DBMS_OUTPUT.PUT_LINE(CHR(10));
        END LOOP;
        CLOSE contas_cpf_movimenta;
    END;

-- CONSULTA PARA RETORNAR O NÚMERO TOTAL DE TRANSFERÊNCIAS QUE AS CONTAS DE UM DETERMINADO CLIENTE FIZERAM
DECLARE
    CURSOR contas_clientes_movimenta IS SELECT DEREF(m.conta), DEREF(m.cliente) FROM tb_movimenta m WHERE m.cliente.cpf = '001';
    cnt tp_conta;
    cli tp_cliente;
    num_transferencias_cliente NUMBER;
    total_transf_cliente NUMBER := 0;
    BEGIN
        OPEN contas_clientes_movimenta;
        LOOP
            FETCH contas_clientes_movimenta INTO cnt, cli;
            EXIT WHEN contas_clientes_movimenta%NOTFOUND;
            SELECT COUNT(*) INTO num_transferencias_cliente FROM tb_transfere t WHERE t.conta_orig.numero_agencia = cnt.numero_agencia AND t.conta_orig.numero_conta = cnt.numero_conta;
            total_transf_cliente := total_transf_cliente + num_transferencias_cliente;
        END LOOP;
        CLOSE contas_clientes_movimenta;
        DBMS_OUTPUT.PUT_LINE('Número de transferências feitas pelo cliente com o cpf 001: '||TO_CHAR(total_transf_cliente));
    END;
    
-- CONSULTA PARA QUE, DADO UM CPF, RETORNAR QUAIS AUXÍLIOS ESSA PESSOA RECEBE, QUAIS INSTITUICOES OFERECEM ESSE AUXÍLIO A ELA, O CPF E O PRIMEIRO_NOME DA PESSOA, O VALOR MENSAL DO AUXÍLIO E A DATA DO INÍCIO DO RECEBIMENTO
SELECT o.auxilio.nome_auxilio, o.instituicao.nome, o.movimenta.cliente.cpf, o.movimenta.cliente.primeiro_nome, o.valor_mensal, o.data_inicio FROM tb_oferece_auxilio o WHERE o.movimenta.cliente.cpf = '001';
