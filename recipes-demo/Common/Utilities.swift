import Foundation
struct Utilities {
    static let jsonDecoder = JSONDecoder()
    
    static func log(message: String) {
#if DEBUG
        print(message)
#else
        // log to Splunk, DataDog, etc.
#endif
    }
}

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
