import Combine
import Foundation
import HTTPClient

final class AppStoreClient: HTTPClient {
    var session: URLSession
    var baseURL: URL

    init(baseURL: URL = URL(string: "https://itunes.apple.com/us/lookup?bundleId=")!,
         session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
}

extension AppStoreClient {
    func getAppMetadata(bundleId: String) -> AnyPublisher<HTTPOutput, HTTPError> {
        get(bundleId)
            .eraseToAnyPublisher()
    }
}
