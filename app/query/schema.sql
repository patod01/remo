CREATE TABLE IF NOT EXISTS "historial" (
	"queue_ID"	INTEGER NOT NULL,
	"list_view_ID"	TEXT NOT NULL,
	"time"		INTEGER NOT NULL,
	PRIMARY KEY("queue_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "status" (
	"status_ID"	INTEGER NOT NULL,
	"status_name"	TEXT NOT NULL,
	"status_type"	TEXT,
	PRIMARY KEY("status_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "remotos" (
	"index"		INTEGER NOT NULL,
	"alias"		TEXT NOT NULL,
	"IP"			TEXT NOT NULL,
	"uso"		TEXT NOT NULL,
	"list_view_ID"	TEXT,
	"privacy"		INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY("index" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "alerts" (
	"alert_ID"	INTEGER NOT NULL,
	"alert_name"	TEXT NOT NULL,
	"status_ID"	INTEGER NOT NULL DEFAULT 2,
	FOREIGN KEY("status_ID") REFERENCES "status"("status_ID"),
	PRIMARY KEY("alert_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "users" (
	"user_ID"		INTEGER NOT NULL,
	"nombre1"		TEXT NOT NULL,
	"nombre2"		TEXT,
	"appelido1"	TEXT NOT NULL,
	"appelido2"	TEXT,
	"vigente"		INTEGER NOT NULL DEFAULT 1,
	"status_ID"	INTEGER NOT NULL DEFAULT 1,
	FOREIGN KEY("status_ID") REFERENCES "status"("status_ID"),
	PRIMARY KEY("user_ID" AUTOINCREMENT)
);
