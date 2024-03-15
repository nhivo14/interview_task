//
//  DailyConsumtion.swift
//  InterviewTask
//
//  Created by NhiVHY on 14/03/2024.
//

import Foundation

struct DailyConsumption: Codable {
    var dateValue: Date?
    let cost: Double?
    let consumption: Double?
    
    private enum CodingKeys: String, CodingKey {
        case dateValue = "date"
        case cost
        case consumption
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cost = try? container.decode(Double.self, forKey: .cost)
        consumption = try? container.decode(Double.self, forKey: .consumption)
        
        if let stringDate = try? container.decode(String.self, forKey: .dateValue) {
            self.dateValue = getDate(string: stringDate)
        }
    }
    
    // Convert dateString to Date
    func getDate(string: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: string)
        return date
    }
    
    
}
