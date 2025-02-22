import SwiftData

@Model
final class GameDBModel: Identifiable {
    var id: Int
    var title: String
    var thumbnail: String
    var shortDescription: String
    var gameUrl: String
    var genre: String
    var platform: String
    var publisher: String
    var developer: String
    var releaseDate: String
    var freetogameProfileUrl: String
    var wasEdited: Bool = false
    
    init(id: Int,
         title: String,
         thumbnail: String,
         shortDescription: String,
         gameUrl: String,
         genre: String,
         platform: String,
         publisher: String,
         developer: String,
         releaseDate: String,
         freetogameProfileUrl: String) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.shortDescription = shortDescription
        self.gameUrl = gameUrl
        self.genre = genre
        self.platform = platform
        self.publisher = publisher
        self.developer = developer
        self.releaseDate = releaseDate
        self.freetogameProfileUrl = freetogameProfileUrl
    }
}
