import SwiftUI

@main
struct recipes_demoApp: App {
    // don't re-initialize each time view is re-drawn
    @StateObject var viewModel = HomeViewModel(recipes: [
        Recipe(cuisine: "Malaysian",
           name: "Apam Balik",
           photo_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
           photo_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
           source_url: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
               uuid: UUID(),
           youtube_url: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    ])
    @State var initialized = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(viewModel: viewModel)
            }
            .onAppear {
                guard !initialized else { return }
                Task {
                    await viewModel.loadRecipes()
                    DispatchQueue.main.async {
                        Utilities.log(message: "Initialized recipes")
                        initialized = true
                    }
                }
            }
        }
    }
}
