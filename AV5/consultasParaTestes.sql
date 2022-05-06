-- VALUE -- 
-- Teste do exibirDetalhesConta
DECLARE
cnt tp_conta;
BEGIN
SELECT VALUE(c) INTO cnt FROM tb_conta_corrente c WHERE c.numero_agencia = '163' AND c.numero_conta = '123432189';
cnt.exibirDetalhesConta();
END;
/

-- VALUE -- 
-- Teste do exibirDetalhesConta
DECLARE
cnt tp_conta;
BEGIN
SELECT VALUE(c) INTO cnt FROM tb_conta_poupanca c WHERE c.numero_agencia = '367' AND c.numero_conta = '891756213';
cnt.exibirDetalhesConta();
END;
/

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
/

--Adição de um telefone fora de ordem à tabela de telefones do cliente com cpf 001
DECLARE
n tb_cliente.telefones%TYPE;
i INTEGER;
BEGIN
    SELECT c.telefones INTO n FROM tb_cliente c WHERE c.cpf = '001';
    n.EXTEND;
    i := n.COUNT;
    n(i) := tp_telefone(9312345123);
    UPDATE tb_cliente c SET c.telefones = n WHERE c.cpf = '001';
END;
/

--Teste do telefoneToInt usando o ORDER BY
SELECT c.cpf, t.* FROM tb_cliente c, TABLE(c.telefones) t WHERE c.cpf = '001' ORDER BY t.telefoneToInt();
/

--Estado inicial da tabela tb_instituicao
SELECT * FROM tb_instituicao;
--Teste do set_DataAbertura()
DECLARE
inst tp_instituicao;
BEGIN
SELECT VALUE(i) INTO inst FROM tb_instituicao i WHERE i.cnpj = '00000993788450';
inst.set_DataAbertura('00000993788450', TO_DATE('17/11/1912', 'DD/MM/YYYY'));
END;
/

--Confirmação de que funcionou
SELECT * FROM tb_instituicao;
/

-- Teste valor_anula do oferece_auxilio
DECLARE
    of_aux_var tp_oferece_auxilio;
BEGIN
    SELECT VALUE(of_aux) INTO of_aux_var FROM tb_oferece_auxilio of_aux
        WHERE data_inicio = TO_DATE('17/09/2020', 'DD/MM/YYYY');
    DBMS_OUTPUT.PUT_LINE(of_aux_var.valor_anual());
END;
/
