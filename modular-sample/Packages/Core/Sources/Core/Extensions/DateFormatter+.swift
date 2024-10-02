//
//  DateFormatter+.swift
//  Core
//
//  Created by Maria Casanova on 10/2/24.
//

import Foundation

extension DateFormatter {
    public static let standardT: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()

    public static let standard: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()

    public static let yearMonthDay: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    public static let monthDayYearLong: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter
    }()

    public static let monthDayLong: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter
    }()
}

public extension Date {
    func formatted(_ formatter: DateFormatter) -> String {
        formatter.string(from: self)
    }
}
