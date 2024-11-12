import SwiftUI

struct RecipeImageView: View {
    let recipe: Recipe
    
    var body: some View {
        Text("123")
    }
}

struct RecipeImageView_Previews: PreviewProvider {
    static let recipe = Recipe(
        cuisine: "Malaysian",
        name: "Apam Balik",
        photo_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
        photo_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        source_url: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
        uuid: UUID(),
        youtube_url: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
    
    static var previews: some View {
        NavigationStack {
            RecipeImageView(recipe: recipe)
        }
    }
}
