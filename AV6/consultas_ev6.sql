-- SELECT DEREF
-- Retorna os cpfs e as contas da tabela tb_movimenta
SELECT DEREF(m.cliente).cpf AS CPF_CLIENTE, m.conta.numero_conta AS NUMERO_CONTA, m.conta.numero_agencia AS NUMERO_AGENCIA FROM tb_movimenta m;

-- CONSULTA A VARRAY
-- Retorna as ocupações do cliente com cpf 001
SELECT O.* FROM tb_cliente c, TABLE(c.ocupacoes) O WHERE c.cpf = '001';

-- CONSULTA A NESTED TABLE
-- Retorna os dependentes da pessoa com cpf 462
SELECT dep.* FROM TB_RELAC_DEPENDENTE_PESSOA rdp, TABLE(rdp.dependentes) dep WHERE rdp.cpf = '462';