import Foundation

// normally, Info.plist would not exist in repository and be built in pipeline
struct Constants {
    static let RECIPE_HOST_URL = Bundle.main.object(forInfoDictionaryKey: "RECIPE_HOST_URL") as! String
}
