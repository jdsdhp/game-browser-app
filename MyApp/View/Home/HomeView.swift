import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @State private var searchText: String = ""
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Games")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .onChange(of: searchText) { newValue in
                        viewModel.searchGames(query: newValue)
                    }
                
                List {
                    ForEach(viewModel.filteredGames) { game in
                        NavigationLink(destination: GameDetailView(
                            viewModel: viewModel.createGameDetailViewModel(gameId: game.id),
                            onGameDeleted:  {
                                viewModel.deleteGame(byIds: [game.id])
                            }
                        )
                        ) {
                            VStack(alignment: .leading) {
                                Text(game.title)
                                    .font(.headline)
                                Text(game.genre)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        let gameIds = indexSet.map { viewModel.filteredGames[$0].id }
                        viewModel.deleteGame(byIds: gameIds)
                    }
                }
                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: viewModel.fetchGamesFromAPI) {
                        Label("Fetch Games", systemImage: "arrow.clockwise")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: viewModel.deleteAllGames) {
                        Label("Delete All", systemImage: "trash")
                    }
                }
            }
            .refreshable {
                viewModel.refreshGames()
            }
        }
        .onAppear {
            viewModel.fetchGamesFromAPI()
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search games...", text: $text)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Spacer()
                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
        }
    }
}
