import Foundation

public struct Version {
    /// The major version according to the semantic versioning standard.
    let major: Int
    /// The minor version according to the semantic versioning standard.
    let minor: Int
    /// The patch version according to the semantic versioning standard.
    let patch: Int
}

extension Version {
    public enum Error: Swift.Error {
        case unableToParseString
    }

    init(string: String) throws {
        let components = string.components(separatedBy: ".")

        guard components.count <= 3 else { throw Error.unableToParseString }

        if let majorString = components.first, let majorInt = Int(majorString) {
            self.major = majorInt
        } else { throw Error.unableToParseString }

        if let minorString = components.dropFirst().first, let minorInt = Int(minorString) {
            self.minor = minorInt
        } else { self.minor = 0 }

        if let patchString = components.dropFirst(2).first, let patchInt = Int(patchString) {
            self.patch = patchInt
        } else { self.patch = 0 }
    }
}

extension Version: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.major == rhs.major
        && lhs.minor == rhs.minor
        && lhs.patch == rhs.patch
    }
}

extension Version: Comparable {
    // FIXME probably
    public static func < (lhs: Version, rhs: Version) -> Bool {
        lhs.major < rhs.major
        || lhs.minor < rhs.minor
        || lhs.patch < rhs.patch
    }
}
