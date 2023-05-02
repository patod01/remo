-- BEGIN TRANSACTION;
INSERT INTO "status"
	("status_ID", "status_name", "status_type")
VALUES
	(0, 'libre',	NULL),
	(1, 'ocupado',	NULL),
	(2, 'alerta',	NULL);

INSERT INTO "remotos"
	("index", "alias", "IP", "uso", "list_view_ID", "privacy")
VALUES
	(1,	'C2YQBXR1', '100.XX.XXX.31', 'P&C', 'u00', 0),
	(2,	'C4J8GKS1', '100.XX.XXX.35', 'P&C', 'u00', 0),
	(3,	'C2YRCXR1', '100.XX.XXX.34', 'P&C', 'u00', 0),
	(4,	'C2YPBXR1', '100.XX.XXX.38', 'P&C', 'u00', 0),
	(5,	'C4J9DKS1', '100.XX.XXX.37', 'P&C', 'u00', 0),
	(6,	'CDP548V1', '100.XX.XXX.44', 'P&C', 'u00', 0),
	(7,	'CJ88QXQ1', '100.XX.XXX.50', 'P&C', 'u00', 0),
	(8,	'C7B9GYR1', '100.XX.XXX.58', 'P&C', 'u00', 0),
	(9,	'WKSTSTAD', '100.XX.XXX.12', 'P&C', 'u00', 0),
	(10,	'C6PZVKS1', '100.XX.XXX.41', 'P&C', 'u00', 0),
	(11,	'WKSTHCKC', '100.XX.XXX.37', 'P&C', 'u00', 0);

INSERT INTO "alerts"
	("alert_ID", "alert_name", "status_ID")
VALUES
	(1, '- no disponible -',			2),
	(2, '- sin acceso a la App -',	2);

INSERT INTO "users"
	("user_ID", "nombre1", "nombre2", "appelido1", "appelido2", "vigente", "status_ID")
VALUES
	(0,	' ',		NULL, ' ',		NULL, 1, 0),
	(1,	'name 1',	NULL, 'apelido',	NULL, 1, 1),
	(2,	'name 2',	NULL, 'apelido x',	NULL, 1, 1),
	(3,	'name 2',	NULL, 'apelido x',	NULL, 1, 1),
	(4,	'name 2',	NULL, 'apelido x',	NULL, 1, 1),
	(5,	'name 2',	NULL, 'apelido x',	NULL, 1, 1);
-- COMMIT;
