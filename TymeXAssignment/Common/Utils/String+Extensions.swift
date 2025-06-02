//
//  String+Extensions.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Foundation

extension String {
    /// Converts a string to a Date using the provided date format
    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX") // Best for fixed format parsing
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
