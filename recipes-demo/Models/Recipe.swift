import Foundation

struct Recipe: Decodable {
    let cuisine: String
    let name: String
    let photo_large: String
    let photo_small: String
    let source_url: String?
    let uuid: UUID
    let youtube_url: String?
    
    private enum CodingKeys: String, CodingKey {
        case cuisine, name, photo_large = "photo_url_large", photo_small = "photo_url_small", source_url, uuid, youtube_url
    }
}
