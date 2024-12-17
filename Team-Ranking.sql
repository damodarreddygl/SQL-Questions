DROP TABLE IF EXISTS teams;
CREATE TABLE teams (
    team_id       INT PRIMARY KEY,
    team_name     VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS matches;
CREATE TABLE matches (
    match_id 	INT PRIMARY KEY,
    host_team 	INT,
    guest_team 	INT,
    host_goals 	INT,
    guest_goals 	INT
);

INSERT INTO teams VALUES(10, 'Team-A');
INSERT INTO teams VALUES(20, 'Team-B');
INSERT INTO teams VALUES(30, 'Team-C');
INSERT INTO teams VALUES(40, 'Team-D');
INSERT INTO teams VALUES(50, 'Team-E');

INSERT INTO matches VALUES(1, 30, 20, 1, 0);
INSERT INTO matches VALUES(2, 10, 20, 1, 2);
INSERT INTO matches VALUES(3, 20, 50, 2, 2);
INSERT INTO matches VALUES(4, 10, 30, 1, 0);
INSERT INTO matches VALUES(5, 30, 50, 0, 1);

SELECT * FROM teams;
+---------+-----------+
| team_id | team_name |
+---------+-----------+
|      10 | Team-A    |
|      20 | Team-B    |
|      30 | Team-C    |
|      40 | Team-D    |
|      50 | Team-E    |
+---------+-----------+

SELECT * FROM matches;
+----------+-----------+------------+------------+-------------+
| match_id | host_team | guest_team | host_goals | guest_goals |
+----------+-----------+------------+------------+-------------+
|        1 |        30 |         20 |          1 |           0 |
|        2 |        10 |         20 |          1 |           2 |
|        3 |        20 |         50 |          2 |           2 |
|        4 |        10 |         30 |          1 |           0 |
|        5 |        30 |         50 |          0 |           1 |
+----------+-----------+------------+------------+-------------+

Problem Description:

We have two tables:
1. Teams: Each record in the "teams" table represents a football team, identified by a team_id and a team_name.
2. Matches: Each record in the "matches" table represents a finished match between two teams, storing details such as host_team, guest_team, and the respective host_goals and guest_goals.

The task is to compute the total points for each team based on the following rules:
 
Win: A team that scores more goals than the other team earns 3 points.
Draw: If both teams score the same number of goals, each team earns 1 point.
Loss: A team that scores fewer goals than the opponent earns 0 points.

We need to generate a ranking of all teams, showing their name and the total points they've accumulated from all the matches, ordered by:

1. Total points in descending order.
2. In case of a tie in points, teams should be ordered by their team_id in ascending order.
	
SELECT 
    T.team_id,
    T.team_name,
    COALESCE(SUM (CASE 
	WHEN M.host_team = T.team_id AND M.host_goals > M.guest_goals THEN 3
        WHEN M.guest_team = T.team_id AND M.guest_goals > M.host_goals THEN 3
        WHEN M.host_team = T.team_id AND M.host_goals = M.guest_goals THEN 1
        WHEN M.guest_team = T.team_id AND M.guest_goals = M.host_goals THEN 1
        ELSE 0
    END), 0) AS num_points
FROM teams T LEFT JOIN matches M
ON M.host_team = T.team_id OR M.guest_team = T.team_id
GROUP BY T.team_id, T.team_name
ORDER BY num_points DESC, T.team_id ASC;
+---------+-----------+------------+
| team_id | team_name | num_points |
+---------+-----------+------------+
|      20 | Team-B    |          4 |
|      50 | Team-E    |          4 |
|      10 | Team-A    |          3 |
|      30 | Team-C    |          3 |
|      40 | Team-D    |          0 |
+---------+-----------+------------+
