import Foundation

final class HomeViewModel: ObservableObject {
    @Published var games: [GameDomainModel] = []
    @Published var filteredGames: [GameDomainModel] = []
    private let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
        self.filteredGames = games
    }
    
    func fetchGamesFromAPI() {
        repository.fetchGamesFromAPI { result in
            DispatchQueue.main.async {
                if case .success(let fetchedGames) = result {
                    self.games = fetchedGames
                    self.filteredGames = fetchedGames
                }
            }
        }
    }
    
    func refreshGames() {
        fetchGamesFromAPI()
    }
    
    func deleteGame(byIds ids: [Int]) {
        repository.deleteGame(byIds: ids)
        games = repository.fetchGames()
        filteredGames = games
    }
    
    func deleteAllGames() {
        repository.deleteAllGames()
        games = repository.fetchGames()
        filteredGames = games
    }
    
    func searchGames(query: String) {
        if query.isEmpty {
            filteredGames = games
        } else {
            filteredGames = games.filter {
                $0.title.localizedCaseInsensitiveContains(query) ||
                $0.genre.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
    func createGameDetailViewModel(gameId: Int) -> GameDetailViewModel {
        return GameDetailViewModel(gameId: gameId, repository: repository)
    }
}
