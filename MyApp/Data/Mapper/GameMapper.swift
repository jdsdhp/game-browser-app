final class GameMapper {
    static func mapAPIToDomain(_ apiModel: GameAPIModel) -> GameDomainModel {
        return GameDomainModel(
            id: apiModel.id, title: apiModel.title, thumbnail: apiModel.thumbnail,
            shortDescription: apiModel.short_description, gameUrl: apiModel.game_url,
            genre: apiModel.genre, platform: apiModel.platform, publisher: apiModel.publisher,
            developer: apiModel.developer, releaseDate: apiModel.release_date,
            freetogameProfileUrl: apiModel.freetogame_profile_url
        )
    }

    static func mapDomainToDB(_ domainModel: GameDomainModel) -> GameDBModel {
        return GameDBModel(
            id: domainModel.id, title: domainModel.title, thumbnail: domainModel.thumbnail,
            shortDescription: domainModel.shortDescription, gameUrl: domainModel.gameUrl,
            genre: domainModel.genre, platform: domainModel.platform, publisher: domainModel.publisher,
            developer: domainModel.developer, releaseDate: domainModel.releaseDate,
            freetogameProfileUrl: domainModel.freetogameProfileUrl
        )
    }

    static func mapDBToDomain(_ dbModel: GameDBModel) -> GameDomainModel {
        return GameDomainModel(
            id: dbModel.id, title: dbModel.title, thumbnail: dbModel.thumbnail,
            shortDescription: dbModel.shortDescription, gameUrl: dbModel.gameUrl,
            genre: dbModel.genre, platform: dbModel.platform, publisher: dbModel.publisher,
            developer: dbModel.developer, releaseDate: dbModel.releaseDate,
            freetogameProfileUrl: dbModel.freetogameProfileUrl
        )
    }
}
