protocol GameServiceProtocol {
    func fetchGames(completion: @escaping (Result<[GameAPIModel], Error>) -> Void)
}
