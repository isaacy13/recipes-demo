import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            currentView
                .navigationTitle("Recipe Rush")
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Picker("", selection: $viewModel.viewType) {
                            Image(systemName: "list.bullet")
                            Image(systemName: "square.grid.2x2.fill")
                        }
                        .pickerStyle(.segmented)
                    }
                }
                .refreshable {
                    Task { await viewModel.loadRecipes() }
                }
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                    .progressViewStyle(.circular)
            }
        }
    }
    
    @ViewBuilder
    var currentView: some View {
        switch viewModel.viewType {
        case .grid:
            gridView
        case .list:
            listView
        }
    }
    
    var listView: some View {
        List {
            // identify by UUID given by server
            ForEach(viewModel.recipes, id: \.self.uuid) { recipe in
                Text(recipe.name)
            }
        }
    }
    
    var gridView: some View {
        Grid {
            // identify by UUID given by server
            ForEach(viewModel.recipes, id: \.self.uuid) { recipe in
                Text(recipe.name)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static let recipes = [
        Recipe(cuisine: "Malaysian",
           name: "Apam Balik",
           photo_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
           photo_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
           source_url: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
               uuid: UUID(),
           youtube_url: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    ]
    
    static var previews: some View {
        NavigationStack {
            HomeView(viewModel: HomeViewModel(recipes: recipes))
        }
    }
}
