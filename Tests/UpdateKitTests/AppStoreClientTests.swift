import XCTest
@testable import UpdateKit

final class AppStoreClientTests: XCTestCase {

    func test_init() {
        let client = AppStoreClient()

        XCTAssertEqual(client.baseURL, URL(string: "https://itunes.apple.com/us/lookup?bundleId="))
        XCTAssertEqual(client.session, URLSession.shared)
    }
}
