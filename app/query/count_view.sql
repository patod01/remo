CREATE VIEW IF NOT EXISTS v_counter AS
SELECT count("index") AS cantidad FROM v_remotos
UNION
SELECT count(estado) AS cantidad FROM v_remotos WHERE estado = 'libre';
