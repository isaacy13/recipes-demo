import SwiftUI
import CachedAsyncImage

struct RecipeImageView: View {
    let recipe: Recipe
    let orientation: Axis
    let onImageClick: () -> Void
    
    var body: some View {
        VStack {
            if orientation == .vertical {
                verticalRecipeView
            } else {
                horizontalRecipeView
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding([.leading, .trailing], 15)
        .padding([.top, .bottom], 5)
    }
    
    var verticalRecipeView: some View {
        VStack {
            title
            imagePreview
                .padding([.bottom], 10)
            links
        }
    }
    
    var horizontalRecipeView: some View {
        VStack {
            HStack {
                imagePreview
                title
            }
            .padding([.bottom], 10)
            links
        }
    }
    
    var title: some View {
        let name = Text(recipe.name)
            .font(.title)
            .bold()
            .multilineTextAlignment((orientation == .vertical) ? .leading : .center)
            .frame(maxWidth: .infinity, alignment: (orientation == .vertical) ? .leading : .center)
        
        let cuisine = Text(recipe.cuisine)
            .font(.title2)
            .frame(alignment: (orientation == .vertical) ? .trailing : .leading)
        
        return VStack {
            if orientation == .vertical {
                HStack {
                    name
                    Spacer()
                    cuisine
                }
            }
            else {
                name
                cuisine
            }
        }
    }
    
    var imagePreview: some View {
        VStack {
            if let smallImage = URL(string: recipe.photo_small) {
                Button() {
                    onImageClick()
                } label: {
                    CachedAsyncImage(url: smallImage,
                                     urlCache: .imageCache) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
            } else {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundStyle(.yellow)
                Text("Error loading image preview")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var links: some View {
        HStack {
            if let source_url = recipe.source_url,
               let url = URL(string: source_url)
            {
                Link(destination: url) {
                    HStack {
                        Image(systemName: "link")
                        Text("Source")
                    }
                    .font(.callout)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
            
            Spacer()
                .frame(width: 10)
            
            if let youtube_url = recipe.youtube_url,
               let url = URL(string: youtube_url) {
                Link(destination: url) {
                    HStack {
                        Image(systemName: "video")
                        Text("Video")
                    }
                    .font(.callout)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
        }
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
            ScrollView {
                LazyVStack {
                    RecipeImageView(recipe: recipe, orientation: .vertical) {
                        
                    }
                    RecipeImageView(recipe: recipe, orientation: .horizontal) {
                        
                    }
                    RecipeImageView(recipe: recipe, orientation: .vertical) {
                        
                    }
                    RecipeImageView(recipe: recipe, orientation: .horizontal) {
                        
                    }
                    RecipeImageView(recipe: recipe, orientation: .vertical) {
                        
                    }
                    RecipeImageView(recipe: recipe, orientation: .horizontal) {
                        
                    }
                }
            }
            .background(Color(UIColor.secondarySystemBackground))
        }
    }
}
