import XCTest
@testable import UpdateKit

final class VersionTests: XCTestCase {
    func test_init() {

        // MARK: Valid version strings

        XCTAssertNoThrow(try Version(string: "1.2.3"), "\"1.2.3\" is a valid version string")
        XCTAssertNoThrow(try Version(string: "1.2"), "\"1.2\" is a valid version string")
        XCTAssertNoThrow(try Version(string: "1"), "\"1\" is a valid version string")

        // MARK: Invalid version strings

        XCTAssertThrowsError(try Version(string: "asdf"), "\"asdf\" is an unexpected char")
        XCTAssertThrowsError(try Version(string: "a.s.d"), "\"a.s.d\" is an unexpected char")
        XCTAssertThrowsError(try Version(string: "1.2.3.4"), "\"1.2.3.4\" has too many components")
    }

    func test_equality() {
        let version123 = Version(major: 1, minor: 2, patch: 3)

        XCTAssertEqual(version123, Version(major: 1, minor: 2, patch: 3))

        XCTAssertNotEqual(version123, Version(major: 1, minor: 2, patch: 2))
        XCTAssertNotEqual(version123, Version(major: 2, minor: 2, patch: 3))
        XCTAssertNotEqual(version123, Version(major: 3, minor: 2, patch: 3))
    }

    func test_comparability() {
        let version123 = Version(major: 1, minor: 2, patch: 3)

        // MARK: Lesser versions

        let version023 = Version(major: 0, minor: 2, patch: 3)
        let version113 = Version(major: 1, minor: 1, patch: 3)
        let version122 = Version(major: 1, minor: 2, patch: 2)

        XCTAssertGreaterThan(version123, version023)
        XCTAssertGreaterThan(version123, version113)
        XCTAssertGreaterThan(version123, version122)

        // MARK: Greater versions

        let version124 = Version(major: 1, minor: 2, patch: 4)
        let version133 = Version(major: 1, minor: 3, patch: 3)
        let version223 = Version(major: 2, minor: 2, patch: 3)

        XCTAssertLessThan(version123, version124)
        XCTAssertLessThan(version123, version133)
        XCTAssertLessThan(version123, version223)
    }
}
