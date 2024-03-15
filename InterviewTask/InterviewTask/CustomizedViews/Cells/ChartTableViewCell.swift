//
//  ChartTableViewCell.swift
//  InterviewTask
//
//  Created by NhiVHY on 14/03/2024.
//

import UIKit

class ChartTableViewCell: UITableViewCell {

    @IBOutlet weak var chartView: DetailDailyUsageEnergyChart!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .systemGray5
        chartView.clipsToBounds = true
        chartView.layer.cornerRadius = 5
    }

    func configData(data: ConsumptionResponse?, 
                    avgUsage: Double,
                    avgConsumption: Double,
                    firstDate: Date,
                    lastDate: Date) {
        guard let data = data else { return }
        chartView.setContentData(data, height: 250, row: 6, focusDate: data.usageHistories.last?.dateValue ?? Date())
        chartView.configLabels(avgUsage: avgUsage, 
                               avgConsumption: avgConsumption,
                               firstDate: firstDate,
                               lastDate: lastDate)
    }
    
}
