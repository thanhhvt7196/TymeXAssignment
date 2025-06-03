// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Blog
  internal static let blogTitle = L10n.tr("Localizable", "blog_title", fallback: "Blog")
  /// Người theo dõi
  internal static let followerTitle = L10n.tr("Localizable", "follower_title", fallback: "Người theo dõi")
  /// Đang theo dõi
  internal static let followingTitle = L10n.tr("Localizable", "following_title", fallback: "Đang theo dõi")
  /// Chi tiết người dùng
  internal static let userDetailScreenTitle = L10n.tr("Localizable", "user_detail_screen_title", fallback: "Chi tiết người dùng")
  /// Người dùng Github
  internal static let userListScreenTitle = L10n.tr("Localizable", "user_list_screen_title", fallback: "Người dùng Github")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
