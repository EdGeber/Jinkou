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
