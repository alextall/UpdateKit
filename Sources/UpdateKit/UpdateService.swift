import Foundation
import HTTPClient

/// Checks for updates from the AppStore.
public final class UpdateService {

    /// Most recent available update status
    @Published
    public private(set) var status: UpdateStatus = .upToDate

    public enum Error: Swift.Error {
        case missingBundleIdentifier
        case bundleIdNotFoundInAppStore
        case missingCFBundleShortVersionString
    }

    public convenience init(bundleId: String? = Bundle.main.bundleIdentifier) throws {
        try self.init(bundleId: bundleId, httpClient: .init())
    }

    init(bundleId: String?, httpClient: AppStoreClient) throws {
        guard let bundleId = bundleId else {
            throw UpdateService.Error.missingBundleIdentifier
        }

        self.httpClient = httpClient
        self.bundleId = bundleId

        check()
    }

    var currentVersionProvider: () throws -> String = {
        guard let versionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            throw Error.missingCFBundleShortVersionString
        }
        return versionString
    }

    private let httpClient: AppStoreClient
    private let bundleId: String
}

public extension UpdateService {
    func check() {
        httpClient.getAppMetadata(bundleId: bundleId)
            .map(\.data)
            .decode(type: AppMetadataResults.self, decoder: JSONDecoder())
            .tryCompactMap { results -> AppMetadata? in
                guard results.resultCount == 1,
                    let result = results.results.first else {
                    throw Error.bundleIdNotFoundInAppStore
                }

                return result
            }
            .tryMap(updateStatus(for:))
            .assertNoFailure()
            .assign(to: &$status)
    }
}

private extension UpdateService {
    func updateStatus(for metadata: AppMetadata) throws -> UpdateStatus {
        let currentVersion = try currentVersionProvider()

        switch currentVersion.compare(metadata.version) {
        case .orderedSame, .orderedDescending:
            return .upToDate
        case .orderedAscending:
            return .updateAvailable(version: metadata.version, storeURL: metadata.trackViewURL)
        }
    }
}