-- VALUE -- 
-- Teste do exibirDetalhesConta
DECLARE
cnt tp_conta;
BEGIN
SELECT VALUE(c) INTO cnt FROM tb_conta_corrente c WHERE c.numero_agencia = '001' AND c.numero_conta = '891756213';
cnt.exibirDetalhesConta();
END;

-- Teste do Comparadependente
declare
    dep1 tp_dependente;
    dep2 tp_dependente;
begin
    dep1 := tp_dependente('a', 'b', 'c', 'Filha', to_date('05/11/2020','DD/MM/YYYY'));
    dep2 := tp_dependente('a', 'a', 'a', 'Irmão', to_date('12/12/1985','DD/MM/YYYY'));
    dbms_output.put_line(dep2.Comparadependente(dep1));
end;
/

-- Teste do getparente
select d.getParente() from table(select relac.dependentes from tb_relac_dependente_pessoa relac where relac.cpf = '001') d 
    where d.parentesco = 'Pai';