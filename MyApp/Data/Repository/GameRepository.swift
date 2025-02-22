import SwiftData
import Foundation

final class GameRepository: GameRepositoryProtocol {    
    private let modelContext: ModelContext
    private let service: GameServiceProtocol
    
    init(modelContext: ModelContext, service: GameServiceProtocol = GameService()) {
        self.modelContext = modelContext
        self.service = service
    }
    
    func fetchGames() -> [GameDomainModel] {
        let request = FetchDescriptor<GameDBModel>(sortBy: [SortDescriptor(\.title)])
        let dbGames = (try? modelContext.fetch(request)) ?? []
        return dbGames.map { GameMapper.mapDBToDomain($0) }
    }
    
    func addGames(_ games: [GameDomainModel]) {
        for game in games {
            let dbModel = GameMapper.mapDomainToDB(game)
            modelContext.insert(dbModel)
        }
        saveContext()
    }
    
    func deleteGame(byIds ids: [Int]) {
        let request = FetchDescriptor<GameDBModel>()
        if let games = try? modelContext.fetch(request) {
            for game in games where ids.contains(game.id) {
                modelContext.delete(game)
            }
        }
        saveContext()
    }
    
    func deleteAllGames() {
        let request = FetchDescriptor<GameDBModel>()
        let games = (try? modelContext.fetch(request)) ?? []
        for game in games {
            modelContext.delete(game)
        }
        saveContext()
    }
    
    func fetchGamesFromAPI(completion: @escaping (Result<[GameDomainModel], Error>) -> Void) {
        service.fetchGames { result in
            switch result {
            case .success(let apiGames):
                DispatchQueue.global(qos: .userInitiated).async {
                    let domainGames = apiGames.map { GameMapper.mapAPIToDomain($0) }

                    let request = FetchDescriptor<GameDBModel>()
                    if let localGames = try? self.modelContext.fetch(request) {
                        for game in localGames {
                            if !game.wasEdited {
                                self.modelContext.delete(game)
                            }
                        }
                    }

                    for game in domainGames {
                        if (try? self.modelContext.fetch(FetchDescriptor<GameDBModel>()).first(where: { $0.id == game.id })) == nil {
                            let dbModel = GameMapper.mapDomainToDB(game)
                            self.modelContext.insert(dbModel)
                        }
                    }
                    self.saveContext()
                    DispatchQueue.main.async {
                        completion(.success(self.fetchGames()))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
