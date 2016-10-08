-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
DROP database IF EXISTS tournament;

create database tournament;
\c tournament;

create table PLAYERS(
P_ID	SERIAL	PRIMARY KEY	NOT NULL,
P_NAME	TEXT	NOT NULL		
);

CREATE TABLE MATCHES(
M_ID	SERIAL	PRIMARY KEY NOT NULL,
WINNER_ID	INTEGER,
LOSSER_ID	INTEGER,
FOREIGN KEY (WINNER_ID)	REFERENCES PLAYERS(P_ID),
FOREIGN KEY (LOSSER_ID)	REFERENCES PLAYERS(P_ID)
);

CREATE VIEW standings AS
SELECT PLAYERS.P_ID, PLAYERS.P_NAME,
(SELECT count(MATCHES.WINNER_ID)
    FROM MATCHES
    WHERE PLAYERS.P_ID = MATCHES.WINNER_ID)
    AS total_wins,
(SELECT count(MATCHES.M_ID)
    FROM MATCHES
    WHERE PLAYERS.P_ID = MATCHES.WINNER_ID
    OR PLAYERS.P_ID = MATCHES.LOSSER_ID)
    AS total_matches
FROM PLAYERS
ORDER BY total_wins DESC, total_matches DESC;