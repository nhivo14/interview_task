//
//  ResultViewModel.swift
//  InterviewTask
//
//  Created by NhiVHY on 14/03/2024.
//

import Foundation

class UsageViewModel {
    var usageData: ConsumptionResponse?
    var avgUsage: Double = 0.0
    var avgConsumption: Double = 0.0
    
    func fetchData(completion: () -> Void, failHandler: () -> Void) {
        if let url = Bundle.main.url(forResource: "MockData", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(ConsumptionResponse.self, from: data)
                    usageData = jsonData
                    calculateAvg()
                    completion()
                } catch {
                    print("error:\(error)")
                    failHandler()
                }
            }
        }
    
    func calculateAvg() {
        guard let usageData = usageData else { return }
        let costs : [Double] = usageData.usageHistories.compactMap { $0.cost }
        let totalCost = costs.reduce(0.0, +)
        avgUsage = totalCost/Double(usageData.usageHistories.count)
        
        let consumptions: [Double] = usageData.usageHistories.compactMap { $0.consumption}
        let totalConsumption = consumptions.reduce(0.0, +)
        avgConsumption = totalConsumption/Double(usageData.usageHistories.count)
        
        
    }
}
