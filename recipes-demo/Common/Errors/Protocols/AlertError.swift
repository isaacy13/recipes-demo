protocol AlertError: Error {
    var title: String { get }
    var description: String { get }
}
