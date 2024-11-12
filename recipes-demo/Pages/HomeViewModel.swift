import Foundation

class HomeViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var viewType: ViewType = .list
    @Published var recipes: [Recipe] = []
    @Published var alertError: AlertError?
    
    init() {}
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
    
    func loadRecipes() async {
        // make sure main thread updates state
        DispatchQueue.main.async { self.isLoading = true }
        
        // allow all logic (except for state updates) to be executed in non-main threads
        do {
            let randomRecipeIndex = Int.random(in: 0..<10)
            let recipeType: RecipeType
            
            // 0-7 -> get all recipes (80% chance)
            // 8 -> get malformed recipe file (10% chance)
            // 9 -> get empty recipe file (10% chance)
            switch randomRecipeIndex {
            case 8:
                recipeType = .malformed
            case 9:
                recipeType = .empty
            default:
                recipeType = .all
            }
            
//            let recipeResponse = try await RecipeApi.getRecipes(type: recipeType)
//            DispatchQueue.main.async {
//                self.recipes = recipeResponse.recipes
//            }
        } catch {
            let alertError = error as? AlertError
            DispatchQueue.main.async {
                self.alertError = alertError ?? ApiError.Unexpected(description: error.localizedDescription)
            }
        }
        
        // make sure main thread updates state
        DispatchQueue.main.async { self.isLoading = false }
    }
}
