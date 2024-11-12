enum ApiError: Error, AlertError {
    case FailedToFormUrl(url: String)
    case BadStatus(code: Int)
    case Unexpected(description: String)
    
    var title: String {
        switch self {
        case .FailedToFormUrl: 
            return "Invalid URL, please try again later"
        case .BadStatus: 
            return "Invalid response"
        case .Unexpected:
            return "An unexpected error occurred"
        }
    }
    
    var description: String {
        switch self {
        case .FailedToFormUrl(let url):
            return url
        case .BadStatus(let code): 
            return "Received invalid response code \(code)"
        case .Unexpected(let description):
            return description
        }
    }
}
