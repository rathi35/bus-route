//
//  DateExtension.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//

import UIKit

extension Date {
    static let dateFormatter = DateFormatter()
    
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func dateByAddingMin(_ min: Int) -> Date? {
        guard let date = Calendar.current.date(byAdding: .minute, value: min, to: self) else {
            return nil
        }
        return date
    }
    
    func dateString(with dateFormat: String) -> String {
        Date.dateFormatter.dateFormat = dateFormat
        return Date.dateFormatter.string(from: self)
    }
    
    func getTodayForTime(_ time: String) -> Date {
        let timeString = time.components(separatedBy: ":")
        guard timeString.count == 2 else {
            return Date()
        }
        let date = Calendar.current.date(bySettingHour: Int(timeString[0])!, minute: Int(timeString[1])!, second: 0, of: self) ?? Date()
        return date
    }
}
