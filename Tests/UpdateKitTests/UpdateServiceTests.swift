import XCTest
@testable import UpdateKit

final class UpdateServiceTests: XCTestCase {

    var service: UpdateService!
    var appStoreClient: AppStoreClient!
    let bundleId = "com.alextall.test"

    override func setUpWithError() throws {
        appStoreClient = AppStoreClient()
        service = try UpdateService(bundleId: bundleId, httpClient: appStoreClient)
        service.currentVersionProvider = { "1.0.0" }
    }

    override func tearDownWithError() throws {
        service = nil
        appStoreClient = nil
    }

    func test_init() {
        XCTAssertNoThrow(try UpdateService(bundleId: bundleId))

        XCTAssertThrowsError(try UpdateService(bundleId: nil))
    }

    func test_updateAvailable() {
        
    }
}
