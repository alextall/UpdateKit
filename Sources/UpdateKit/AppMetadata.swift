import Foundation

struct AppMetadata: Decodable {
    let trackViewURL: URL
    var version: Version? {
        try? Version(string: versionString)
    }
    private let versionString: String

    enum CodingKeys: String, CodingKey {
        case trackViewURL
        case versionString = "version"
    }
}

struct AppMetadataResults: Decodable {
    let resultCount: Int
    let results: [AppMetadata]
}
