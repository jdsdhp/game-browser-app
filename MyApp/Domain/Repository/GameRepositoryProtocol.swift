import Foundation

protocol GameRepositoryProtocol {
    func fetchGames() -> [GameDomainModel]
    func addGames(_ games: [GameDomainModel])
    func deleteGame(byIds ids: [Int])
    func deleteAllGames()
    func fetchGamesFromAPI(completion: @escaping (Result<[GameDomainModel], Error>) -> Void)
}
