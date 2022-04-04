SELECT t_outer.motivo FROM Transfere t_outer WHERE t_outer.valor IN (
    SELECT MIN(t_inner.valor) FROM Transfere t_inner)
