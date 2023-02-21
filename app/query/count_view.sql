CREATE VIEW IF NOT EXISTS v_counter AS
SELECT 'total' as [remotos], count([index]) AS cantidad
FROM v_remotos
	UNION
SELECT 'libre' as [remotos], count(estado) AS cantidad
FROM v_remotos WHERE estado = 'libre';
