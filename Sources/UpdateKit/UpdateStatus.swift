import Foundation

public enum UpdateStatus {
    /// There are no updates available.
    case upToDate
    /// There is an update available at the given URL.
    case updateAvailable(version: Version, storeURL: URL)
    /// An error occured when checking
    case error(Error)
}
