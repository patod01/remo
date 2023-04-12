CREATE VIEW IF NOT EXISTS v_list AS
SELECT
	'u' || substr('0' || user_ID, -2) AS item_ID,
	trim(nombre1 || ' ' || appelido1) AS nombre,
	status_name AS estado
FROM users INNER JOIN status ON users.status_ID = status.status_ID AND vigente = 1
	UNION
SELECT
	'w0' || alert_ID AS item_ID,
	alert_name AS nombre,
	status_name AS estado
FROM alerts LEFT JOIN status ON alerts.status_ID = status.status_ID
ORDER BY nombre;
