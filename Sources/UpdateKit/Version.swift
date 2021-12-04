import Foundation

public struct Version {
    /// The major version according to the semantic versioning standard.
    public let major: Int
    /// The minor version according to the semantic versioning standard.
    public let minor: Int
    /// The patch version according to the semantic versioning standard.
    public let patch: Int

    public init(major: Int, minor: Int, patch: Int) {
        precondition(major >= 0 && minor >= 0 && patch >= 0, "Negative versioning is invalid.")

        self.major = major
        self.minor = minor
        self.patch = patch
    }
}

extension Version {
    enum Error: Swift.Error {
        case unableToParseString
    }

    init(string: String) throws {
        guard !string.isEmpty else { throw Error.unableToParseString }

        let components = string.components(separatedBy: ".")

        guard components.count <= 3 else { throw Error.unableToParseString }

        let intComponents = components.compactMap(Int.init)

        guard let major = intComponents.first else { throw Error.unableToParseString }

        self.major = major
        self.minor = intComponents.dropFirst().first ?? 0
        self.patch = intComponents.dropFirst(2).first ?? 0
    }

    static var zero: Version { Version(major: 0, minor: 0, patch: 0) }
}

extension Version: Equatable {}

extension Version: Comparable {
    public static func < (lhs: Version, rhs: Version) -> Bool {
        [lhs.major, lhs.minor, lhs.patch].lexicographicallyPrecedes([rhs.major, rhs.minor, rhs.patch])
    }
}
