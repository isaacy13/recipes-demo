import SwiftUI
import CachedAsyncImage

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var popupRecipe: Recipe?
    @State var viewType: ViewType = .list
    
    var body: some View {
        ZStack {
            currentView
                .navigationTitle("Recipe Rush")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Picker("", selection: $viewType) {
                        Image(systemName: "list.bullet")
                            .tag(ViewType.list)
                        Image(systemName: "square.grid.2x2.fill")
                            .tag(ViewType.grid)
                    }
                    .pickerStyle(.segmented)
                    .padding([.leading, .trailing])
                }
                .refreshable {
                    Task { await viewModel.loadRecipes() }
                }
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .progressViewStyle(.circular)
            }
            
            if let recipe = popupRecipe {
                VStack {
                    if let largeImage = URL(string: recipe.photo_large) {
                        InspectableImageView(imageUrl: largeImage)
                    }
                    else if let smallImage = URL(string: recipe.photo_small) {
                        InspectableImageView(imageUrl: smallImage)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.7))
                .onTapGesture {
                    self.popupRecipe = nil
                }
            }
        }
        .background(Color(UIColor.secondarySystemBackground))
        .alert(isPresented: Binding(get: { viewModel.alertError != nil }, set: { if !$0 { viewModel.alertError = nil } })) {
            if let alertError = viewModel.alertError {
                Alert(title: Text(alertError.title),
                      message: Text(alertError.description))
            }
            else {
                Alert(title: Text("An unexpected error has occurred"), message: Text("Please try again"))
            }
        }
    }
    
    var currentView: some View {
        ScrollView {            
            switch viewType {
            case .grid:
                gridView
            case .list:
                listView
            }
        }
    }
    
    var listView: some View {
        LazyVStack {
            // identify by UUID given by server
            ForEach(viewModel.recipes, id: \.self.uuid) { recipe in
                RecipeImageView(recipe: recipe, orientation: .horizontal) {
                    popupRecipe = recipe
                }
            }
        }
    }
    
    var gridView: some View {
        Grid {
            // identify by UUID given by server
            ForEach(viewModel.recipes, id: \.self.uuid) { recipe in
                RecipeImageView(recipe: recipe, orientation: .vertical) {
                    popupRecipe = recipe
                }
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
