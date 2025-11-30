// -- Consulta que devuelva los partidos que terminaron en empate, mostrando la liga y los nombres de los equipos que jugaron.
List<Document> query1(MongoDatabase db) {
    List<Document> results = db.getCollection("matches").aggregate(Arrays.asList(
        new Document("$match", new Document("winner", "DRAW")),
        new Document("$lookup", new Document("from", "teams")
            .append("localField", "homeTeamId")
            .append("foreignField", "teamId")
            .append("as", "homeTeam")),
        new Document("$unwind", "$homeTeam"),
        new Document("$lookup", new Document("from", "teams")
            .append("localField", "awayTeamId")
            .append("foreignField", "teamId")
            .append("as", "awayTeam")),
        new Document("$unwind", "$awayTeam"),
        new Document("$lookup", new Document("from", "leagues")
            .append("localField", "leagueId")
            .append("foreignField", "leagueId")
            .append("as", "league")),
        new Document("$unwind", "$league"),
        new Document("$project", new Document("matchId", 1)
            .append("League", "$league.name")
            .append("Home", "$homeTeam.name")
            .append("Away", "$awayTeam.name")
            .append("winner", 1))
    )).into(new ArrayList<>());
    return results;
}

// Consulta que devuelva los partidos que terminaron en victoria del local, mostrando el nombre del equipo local, en los que este ganó por diferencia de 2 goles
List<Document> query(MongoDatabase db) {
    List<Document> pipeline = Arrays.asList(
        new Document("$lookup", new Document("from", "scores")
            .append("localField", "matchId")
            .append("foreignField", "matchId")
            .append("as", "scores")),
        new Document("$unwind", "$scores"),
        new Document("$lookup", new Document("from", "teams")
            .append("localField", "homeTeamId")
            .append("foreignField", "teamId")
            .append("as", "homeTeam")),
        new Document("$unwind", "$homeTeam"),
        new Document("$lookup", new Document("from", "teams")
            .append("localField", "awayTeamId")
            .append("foreignField", "teamId")
            .append("as", "awayTeam")),
        new Document("$unwind", "$awayTeam"),
        new Document("$match", new Document("scores.fullTimeHome", new Document("$ne", null))
            .append("scores.fullTimeAway", new Document("$ne", null))
            .append("$expr", new Document("$eq", Arrays.asList(
                new Document("$subtract", Arrays.asList("$scores.fullTimeHome", "$scores.fullTimeAway")), 2)))),
        new Document("$project", new Document("matchId", 1)
            .append("Home", "$homeTeam.name")
            .append("Away", "$awayTeam.name")
            .append("fullTimeHome", "$scores.fullTimeHome")
            .append("fullTimeAway", "$scores.fullTimeAway")
            .append("winner", "$winner"))
    );

    return db.getCollection("matches").aggregate(pipeline).into(new ArrayList<>());
}