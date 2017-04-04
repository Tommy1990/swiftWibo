CREATE TABLE IF NOT EXISTS "T_Home" (
"status" TEXT,
"statusid" INTEGER NOT NULL,
"userid" INTEGER NOT NULL,
"createtime" TEXT DEFAULT (datetime('now','localtime')),
PRIMARY KEY("statusid","userid")
)
