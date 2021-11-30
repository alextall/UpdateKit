import Foundation

struct AppMetadata: Codable {
    let trackViewURL: URL
    let version: String
}

struct AppMetadataResults: Codable {
    let resultCount: Int
    let results: [AppMetadata]
}
