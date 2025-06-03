//
//  String+Extensions.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Foundation

extension String {
    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX") // Best for fixed format parsing
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
