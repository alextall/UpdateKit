import Foundation

public enum UpdateStatus {
    /// There are no updates available.
    case upToDate
    /// There is an update available at the given URL.
    case updateAvailable(version: String, storeURL: URL)
}
