import SwiftUICore
import SwiftUI

struct GameDetailView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var viewModel: GameDetailViewModel
    
    var onGameDeleted: (() -> Void)?
    
    init(viewModel: GameDetailViewModel, onGameDeleted: (() -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onGameDeleted = onGameDeleted
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let game = viewModel.game {
                AsyncImage(url: URL(string: game.thumbnail)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .cornerRadius(10)
                
                Text(game.title)
                    .font(.largeTitle)
                    .bold()
                
                Text(game.shortDescription)
                    .font(.body)
                
                Text("Genre: \(game.genre)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Platform: \(game.platform)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Publisher: \(game.publisher)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Developer: \(game.developer)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Release Date: \(game.releaseDate)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Link("More Info", destination: URL(string: game.freetogameProfileUrl)!)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.top, 10)
                
                Spacer()
                
                Button(action: {
                    viewModel.deleteGame()
                    onGameDeleted?()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Delete Game")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                }
            } else {
                ProgressView()
            }
        }
        .padding()
        .onAppear {
            viewModel.loadGame()
        }
    }
}
