import Foundation
import SwiftData

final class GameDetailViewModel: ObservableObject {
    @Published var game: GameDomainModel?
    private let gameId: Int
    private let repository: GameRepositoryProtocol
    
    init(gameId: Int, repository: GameRepositoryProtocol) {
        self.gameId = gameId
        self.repository = repository
    }
    
    func loadGame() {
        game = repository.fetchGames().first { $0.id == gameId }
    }
    
    func deleteGame() {
        repository.deleteGame(byIds: [gameId])
    }
}
