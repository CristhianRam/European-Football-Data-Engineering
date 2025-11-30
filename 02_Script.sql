-- Crear base de datos
CREATE DATABASE IF NOT EXISTS top5leagues;
USE top5leagues;

-- Crear Tablas
CREATE TABLE IF NOT EXISTS leagues (
	league_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'ID de la liga',
    name VARCHAR(20) NOT NULL COMMENT 'Nombre de la liga',
    country VARCHAR(20) NOT NULL COMMENT 'País de la liga',
    icon_url VARCHAR(50) NOT NULL COMMENT 'URL del logo de la liga',
    cl_spot INT NOT NULL COMMENT 'Cupos que brinda para la Champions League',
    uel_spot INT NOT NULL COMMENT 'Cupos que brinda para la Europa League',
    relegation_spot INT NOT NULL COMMENT 'Posicición inicial de la zona de descenso en la liga'
);

CREATE TABLE IF NOT EXISTS stadiums (
	stadium_id INT PRIMARY KEY COMMENT 'ID del estadio',
    name VARCHAR(50) NOT NULL COMMENT 'Nombre del estadio',
    location VARCHAR(150) NOT NULL COMMENT 'Ubicación/Dirección del estadio',
    capacity INT COMMENT 'Capacidad del estadio'
);

CREATE TABLE IF NOT EXISTS coaches (
	coach_id INT PRIMARY KEY COMMENT 'ID del coach',
    name VARCHAR(50) COMMENT 'Nombre Completo del Coach',
    nationality VARCHAR(25) COMMENT 'País de donde proviene el Coach'
);

CREATE TABLE IF NOT EXISTS teams (
	team_id INT PRIMARY KEY COMMENT 'ID del equipo',
    name VARCHAR(50) NOT NULL COMMENT 'Nombre del equipo',
    founded_year INT COMMENT 'Año de fundación del equipo',
    stadium_id INT NOT NULL COMMENT 'Estadio en el que juega el equipo',
    league_id INT NOT NULL COMMENT 'Referencia a la liga',
    coach_id INT NOT NULL COMMENT 'Referencia al Coach del equipo',
    cresturl VARCHAR(50) NOT NULL COMMENT 'URL del logo del equipo',
    FOREIGN KEY (stadium_id) REFERENCES stadiums(stadium_id),
    FOREIGN KEY (league_id) REFERENCES leagues(league_id),
    FOREIGN KEY (coach_id) REFERENCES coaches(coach_id)
);

CREATE TABLE IF NOT EXISTS standings (
    standing_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Identificador único para cada registro de posición',
    league_id INT NOT NULL COMMENT 'Referencia a la liga',
    position INT NOT NULL COMMENT 'Posición actual en la tabla de la liga',
    team_id INT NOT NULL COMMENT 'Referencia al equipo',
    played_games INT NOT NULL DEFAULT 0 COMMENT 'Número de partidos jugados',
    won INT NOT NULL DEFAULT 0 COMMENT 'Número de partidos ganados',
    draw INT NOT NULL DEFAULT 0 COMMENT 'Número de partidos empatados',
    lost INT NOT NULL DEFAULT 0 COMMENT 'Número de partidos perdidos',
    points INT NOT NULL DEFAULT 0 COMMENT 'Total de puntos acumulados',
    goals_for INT NOT NULL DEFAULT 0 COMMENT 'Total de goles anotados',
    goals_against INT NOT NULL DEFAULT 0 COMMENT 'Total de goles recibidos',
    goal_difference INT NOT NULL DEFAULT 0 COMMENT 'Diferencia de goles',
    FOREIGN KEY (league_id) REFERENCES leagues(league_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE IF NOT EXISTS matches (
    match_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID del partido',
    league_id INT NOT NULL COMMENT 'Referencia a la liga',
    matchday INT NOT NULL COMMENT 'Número de jornada o fecha del partido',
    home_team_id INT NOT NULL COMMENT 'Referencia al equipo local',
    away_team_id INT NOT NULL COMMENT 'Referencia al equipo visitante',
    winner VARCHAR(10) DEFAULT NULL COMMENT 'HOME_TEAM si ganó el local, AWAY_WIN si ganó el visitante, DRAW si fue empate',
    utcdate DATE NOT NULL COMMENT 'Fecha del partido',
    FOREIGN KEY (league_id) REFERENCES leagues(league_id),
    FOREIGN KEY (home_team_id) REFERENCES teams(team_id),
    FOREIGN KEY (away_team_id) REFERENCES teams(team_id)
); 

CREATE TABLE IF NOT EXISTS scores (
    score_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID del marcador',
    match_id INT NOT NULL COMMENT 'ID del partido al que pertenece el marcador',
    full_time_home INT NOT NULL COMMENT 'Goles del equipo local al final del partido',
    full_time_away INT NOT NULL COMMENT 'Goles del equipo visitante al final del partido',
    half_time_home INT NOT NULL COMMENT 'Goles del equipo local al final del primer tiempo',
    half_time_away INT NOT NULL COMMENT 'Goles del equipo visitante al final del primer tiempo',
    FOREIGN KEY (match_id) REFERENCES matches(match_id)
);

CREATE TABLE IF NOT EXISTS players (
    player_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID del jugador',
    team_id INT NOT NULL COMMENT 'Referencia al equipo actual del jugador',
    name VARCHAR(100) NOT NULL COMMENT 'Nombre completo del jugador',
    position VARCHAR(50) DEFAULT NULL COMMENT 'Posición en la que juega el jugador (Defense, Midfield, Offence, Goalkeeper)',
    date_of_birth DATE NOT NULL COMMENT 'Fecha de nacimiento del jugador',
    nationality VARCHAR(100) DEFAULT NULL COMMENT 'Nacionalidad del jugador',
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE IF NOT EXISTS referees (
    referee_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID del arbitro',
    name VARCHAR(100) NOT NULL COMMENT 'Nombre completo del arbitro',
    nationality VARCHAR(100) DEFAULT NULL COMMENT 'Nacionalidad del arbitro'
);



