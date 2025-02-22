import SwiftUI
import SwiftData

@main
struct MyAppApp: App {
    @StateObject private var viewModelFactory: ViewModelFactory
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([GameDBModel.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        let repository = GameRepository(modelContext: sharedModelContainer.mainContext)
        _viewModelFactory = StateObject(wrappedValue: ViewModelFactory(repository: repository))
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModelFactory.createHomeViewModel())
        }
        .modelContainer(sharedModelContainer)
    }
}
