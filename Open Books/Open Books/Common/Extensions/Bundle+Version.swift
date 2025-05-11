import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var fullVersionNumber: String {
        let release = releaseVersionNumber ?? "1.0"
        let build = buildVersionNumber ?? "0"
        return "\(release) (\(build))"
    }
} 