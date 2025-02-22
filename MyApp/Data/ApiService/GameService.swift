import Foundation

final class GameService: GameServiceProtocol {
    func fetchGames(completion: @escaping (Result<[GameAPIModel], Error>) -> Void) {
        guard let url = URL(string: "https://www.freetogame.com/api/games") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            
            do {
                let decodedGames = try JSONDecoder().decode([GameAPIModel].self, from: data)
                completion(.success(decodedGames))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
