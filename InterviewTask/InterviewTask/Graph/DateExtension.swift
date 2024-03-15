//
//  DateExtension.swift
//  Chart
//
//  Created by NhiVHY on 3/14/24.
//

import Foundation

let ddMMYYYY = "dd/MM/yyyy HH/mm/ss"

extension Date {
    func isEqual(to date: Date, withFormat format: String = "yyyy/MM/dd") -> Bool {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           
           let dateString1 = dateFormatter.string(from: self)
           let dateString2 = dateFormatter.string(from: date)
           
           return dateString1 == dateString2
       }
    
    func extractDateTime(with format: String = ddMMYYYY) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
    func stringDay() -> String {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let day = calendar.component(.day, from: self)
        let dayString = String(day)
        return dayString
    }
    
    func stringMonth() -> String {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let month = calendar.component(.month, from: self)
        let monthString = String(month)
        return monthString
    }
    
    func monthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}

extension Date {
    func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self) ?? self
    }
}
