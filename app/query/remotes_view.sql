CREATE VIEW IF NOT EXISTS v_remotos AS
SELECT
	"index",
	alias,
	ip,
	uso,
	nombre,
	estado
FROM remotos INNER JOIN v_list ON list_view_ID = item_ID AND privacy = 0
ORDER BY "index";
