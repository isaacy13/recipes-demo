import Foundation

struct RecipeApi {
    private static func getRecipesUrl(type: RecipeType) -> String {
        switch type {
        case .all:
            return "\(Constants.RECIPE_HOST_URL)/recipes.json"
        case .malformed:
            return "\(Constants.RECIPE_HOST_URL)/recipes-malformed.json"
        case .empty:
            return "\(Constants.RECIPE_HOST_URL)/recipes-empty.json"
        }
    }
    
    static func getRecipes(type: RecipeType) async throws -> RecipesResponse {
        let urlString = getRecipesUrl(type: type)
        guard let url = URL(string: urlString) else {
            Utilities.log(message: "Failed to form url with string \(urlString)")
            throw ApiError.FailedToFormUrl(url: urlString)
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = urlResponse as? HTTPURLResponse,
           httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 {
            Utilities.log(message: "Received unsuccessful HTTP response code \(httpResponse.statusCode)")
            throw ApiError.BadStatus(code: httpResponse.statusCode)
        }
        
        let response = try Utilities.jsonDecoder.decode(RecipesResponse.self, from: data)
        Utilities.log(message: "Received response for \(urlString)\n\(response)")
        
        return response
    }
}
