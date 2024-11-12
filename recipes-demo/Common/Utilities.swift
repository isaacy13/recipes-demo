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
