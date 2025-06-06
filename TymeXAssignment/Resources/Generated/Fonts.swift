// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum TTNormsPro {
    internal static let black = FontConvertible(name: "TTNormsPro-Black", family: "TT Norms Pro", path: "TT Norms Pro Black.otf")
    internal static let blackItalic = FontConvertible(name: "TTNormsPro-BlackItalic", family: "TT Norms Pro", path: "TT Norms Pro Black Italic.otf")
    internal static let bold = FontConvertible(name: "TTNormsPro-Bold", family: "TT Norms Pro", path: "TT Norms Pro Bold.otf")
    internal static let boldItalic = FontConvertible(name: "TTNormsPro-BoldItalic", family: "TT Norms Pro", path: "TT Norms Pro Bold Italic.otf")
    internal static let extraBlack = FontConvertible(name: "TTNormsPro-ExtraBlack", family: "TT Norms Pro", path: "TT Norms Pro ExtraBlack.otf")
    internal static let extraBlackItalic = FontConvertible(name: "TTNormsPro-ExtraBlackItalic", family: "TT Norms Pro", path: "TT Norms Pro ExtraBlack Italic.otf")
    internal static let extraBold = FontConvertible(name: "TTNormsPro-ExtraBold", family: "TT Norms Pro", path: "TT Norms Pro ExtraBold.otf")
    internal static let extraBoldItalic = FontConvertible(name: "TTNormsPro-ExtraBoldItalic", family: "TT Norms Pro", path: "TT Norms Pro ExtraBold Italic.otf")
    internal static let extraLight = FontConvertible(name: "TTNormsPro-ExtraLight", family: "TT Norms Pro", path: "TT Norms Pro ExtraLight.otf")
    internal static let extraLightItalic = FontConvertible(name: "TTNormsPro-ExtraLightItalic", family: "TT Norms Pro", path: "TT Norms Pro ExtraLight Italic.otf")
    internal static let italic = FontConvertible(name: "TTNormsPro-Italic", family: "TT Norms Pro", path: "TT Norms Pro Italic.otf")
    internal static let light = FontConvertible(name: "TTNormsPro-Light", family: "TT Norms Pro", path: "TT Norms Pro Light.otf")
    internal static let lightItalic = FontConvertible(name: "TTNormsPro-LightItalic", family: "TT Norms Pro", path: "TT Norms Pro Light Italic.otf")
    internal static let medium = FontConvertible(name: "TTNormsPro-Medium", family: "TT Norms Pro", path: "TT Norms Pro Medium.otf")
    internal static let mediumItalic = FontConvertible(name: "TTNormsPro-MediumItalic", family: "TT Norms Pro", path: "TT Norms Pro Medium Italic.otf")
    internal static let regular = FontConvertible(name: "TTNormsPro-Regular", family: "TT Norms Pro", path: "TT Norms Pro Regular.otf")
    internal static let thin = FontConvertible(name: "TTNormsPro-Thin", family: "TT Norms Pro", path: "TT Norms Pro Thin.otf")
    internal static let thinItalic = FontConvertible(name: "TTNormsPro-ThinItalic", family: "TT Norms Pro", path: "TT Norms Pro Thin Italic.otf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBlack, extraBlackItalic, extraBold, extraBoldItalic, extraLight, extraLightItalic, italic, light, lightItalic, medium, mediumItalic, regular, thin, thinItalic]
  }
  internal static let allCustomFonts: [FontConvertible] = [TTNormsPro.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(macOS)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(fixedSize: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, fixedSize: fixedSize)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(size: CGFloat, relativeTo textStyle: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size, relativeTo: textStyle)
  }
  #endif

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate func registerIfNeeded() {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: family).contains(name) {
      register()
    }
    #elseif os(macOS)
    if let url = url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      register()
    }
    #endif
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.registerIfNeeded()
    self.init(name: font.name, size: size)
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, size: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size)
  }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, fixedSize: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, fixedSize: fixedSize)
  }

  static func custom(
    _ font: FontConvertible,
    size: CGFloat,
    relativeTo textStyle: SwiftUI.Font.TextStyle
  ) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size, relativeTo: textStyle)
  }
}
#endif

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
