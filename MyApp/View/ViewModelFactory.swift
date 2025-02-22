import Foundation

final class ViewModelFactory: ObservableObject {
    private let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func createHomeViewModel() -> HomeViewModel {
        return HomeViewModel(repository: repository)
    }
    
    func createGameDetailViewModel(gameId: Int) -> GameDetailViewModel {
        return GameDetailViewModel(gameId: gameId, repository: repository)
    }
}
