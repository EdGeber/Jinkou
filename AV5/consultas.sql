
-- VALUE -- 
DECLARE
cnt tp_conta;
BEGIN
SELECT VALUE(c) INTO cnt FROM tb_conta_corrente c WHERE c.numero_agencia = '001' AND c.numero_conta = '891756213';
cnt.exibirDetalhesConta();

END;