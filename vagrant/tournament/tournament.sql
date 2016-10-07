-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
create database tournament;
\c tournament;

create table PLAYERS(
P_ID	PRIMARY KEY		 SERIAL	NOT NULL,
P_NAME			 TEXT	NOT NULL		
);

CREATE TABLE MATCHES(
M_ID	PRIMARY KEY	SERIAL	NOT NULL,
WINNER		TEXT,
LOOSER		TEXT
WINNER_ID INT REFERENCES PLAYERS(P_ID),
LOSSER_ID INT REFERENCES players(P_D)
);

CREATE VIEW standings AS
SELECT PLAYERS.P_ID, PLAYERS.P_NAME,
(SELECT count(MATCHES.WINNER)
    FROM MATCHES
    WHERE PLAYERS.P_NAME = MATCHES.WINNER)
    AS total_wins,
(SELECT count(MATCHES.M_ID)
    FROM MATCHES
    WHERE PLAYERS.P_NAME = MATCHES.WINNER
    OR PLAYERS.P_NAME = MATCHES.LOOSER)
    AS total_matches
FROM PLAYERS
ORDER BY total_wins DESC, total_matches DESC;