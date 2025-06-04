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
  /// An error occur!
  internal static let errorAlertTitle = L10n.tr("Localizable", "error_alert_title", fallback: "An error occur!")
  /// Followers
  internal static let followerTitle = L10n.tr("Localizable", "follower_title", fallback: "Followers")
  /// Following
  internal static let followingTitle = L10n.tr("Localizable", "following_title", fallback: "Following")
  /// OK
  internal static let okButton = L10n.tr("Localizable", "ok_button", fallback: "OK")
  /// User Details
  internal static let userDetailScreenTitle = L10n.tr("Localizable", "user_detail_screen_title", fallback: "User Details")
  /// Github Users
  internal static let userListScreenTitle = L10n.tr("Localizable", "user_list_screen_title", fallback: "Github Users")
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
