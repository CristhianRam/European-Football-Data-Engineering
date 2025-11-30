-- a) Dos consultas SQL usando sentencias INNER JOIN que involucren tres o más tablas.

-- Consulta que devuelva los partidos que terminaron en empate, mostrando la liga y los nombres de los equipos que jugaron.
SELECT m.match_id, l.name AS League, ht.name AS Home, vt.name AS Away, m.winner
FROM matches m
	INNER JOIN teams ht ON ht.team_id = m.home_team_id
	INNER JOIN teams vt ON vt.team_id = m.away_team_id
	INNER JOIN leagues l ON l.league_id = m.league_id
WHERE m.winner = 'DRAW';

-- Consulta que devuelva los partidos que terminaron en victoria del local, mostrando el nombre del equipo local, en los que este ganó por diferencia de 2 goles
SELECT m.match_id, ht.name AS Home, vt.name AS Away, s.full_time_home, s.full_time_away, m.winner
FROM matches m
	INNER JOIN  scores s ON m.match_id=s.match_id
	INNER JOIN teams ht ON ht.team_id = m.home_team_id
	INNER JOIN teams vt ON vt.team_id = m.away_team_id
WHERE s.full_time_home-s.full_time_away = 2;

-- b) Dos consultas SQL usando sentencias LEFT o RIGHT JOIN que involucren tres o más tablas. 

-- Consulta que devuelve el id del equipo, su nombre, y cuantos partidos jugaron de local con más de 3 goles anotados usando LEFT JOIN
SELECT t.team_id, t.name, COUNT(s.match_id) AS 'Partidos de local con más de 3 goles'
FROM teams t
  LEFT JOIN matches m ON t.team_id = m.home_team_id
  LEFT JOIN scores s ON m.match_id = s.match_id AND s.full_time_home > 3
GROUP BY t.team_id, t.name;

-- Consulta para mostrar todos los resultados (aunque no tengan partido asociado) con nombre del equipo visitante y fecha, usando RIGHT JOIN
SELECT s.match_id, m.utcdate AS fecha, vt.name AS equipo_visitante, s.full_time_home, s.full_time_away
FROM matches m
  RIGHT JOIN scores s ON m.match_id = s.match_id
  LEFT JOIN teams vt  ON m.away_team_id = vt.team_id;


-- c) Dos consultas SQL usando funciones de agregación (COUNT, AVG, MAX, etc.) 

-- Consulta para obtener el total de partidos jugados
SELECT COUNT(*) AS total_partidos FROM matches;

-- Consulta para obtener el promedio de goles del local
SELECT AVG(full_time_home) AS promedio_goles_local FROM scores;

-- d) Dos consultas que usen subconsultas considerando dos o más tablas.

-- Consulta para obtener el listado de equipos con entrenador español
SELECT team_id, name, coach_id FROM teams
WHERE coach_id IN (SELECT coach_id FROM coaches WHERE nationality LIKE 'Spain%');

-- Consulta para obtener el listado de jugadores mexicanos en equipos de la premier league (ID=1)
SELECT player_id, name, team_id, nationality FROM players
WHERE team_id in (SELECT team_id FROM teams WHERE league_id=1) AND nationality = 'Mexico';


-- e) Dos consultas que usen Grouping Sets (GROUP BY) con ROLLUPs. 

-- Consulta que muestra el total de goles por equipo para cada liga, y con rollup muestra el total de goles en cada liga y el total en las 5 ligas.
SELECT league_id, team_id, SUM(goals_for) AS 'Total de Goles' FROM standings
GROUP BY league_id, team_id WITH ROLLUP;

-- Consulta que muestra el desglose del conteo de partidos ganados por el local, por el visitante o empate
-- para cada una de las 5 ligas, con rollup para mostrar el total para cada tipo de resultado y el numero total de partidos.
SELECT winner, league_id, COUNT(winner) from matches
GROUP BY winner, league_id WITH ROLLUP