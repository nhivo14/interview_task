//
//  ConsumptionResponse.swift
//  InterviewTask
//
//  Created by NhiVHY on 14/03/2024.
//

import Foundation

struct ConsumptionResponse: Codable {
    let address: String
    let from: String
    let to: String
    let usageHistories: [DailyConsumption]
    let approxTotalCost: Double
    let approxTotalElectricity: Double
    let currentTotalCost: Double
    let currentTotalElectricity: Double
}
