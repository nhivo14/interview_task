//
//  TotalTableViewCell.swift
//  InterviewTask
//
//  Created by NhiVHY on 14/03/2024.
//

import UIKit

class TotalTableViewCell: UITableViewCell {

    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var costValueLabel: UILabel!
    @IBOutlet weak var electricityLabel: UILabel!
    @IBOutlet weak var electricityValueLabel: UILabel!
    @IBOutlet weak var outsideView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .systemGray5
        outsideView.clipsToBounds = true
        outsideView.layer.cornerRadius = 5
        costValueLabel.textColor = .systemBlue
        electricityValueLabel.textColor = .systemBlue
    }
    
    func configData(approxCost: Double, approxElectricity: Double) {
        let roundedCost = String(format: "%.2f", approxCost)
        let roundedElectricity = String(format: "%.2f", approxElectricity)

        costValueLabel.text = "$" + roundedCost
        electricityValueLabel.text = roundedElectricity + " kWh"
    }

   
    
}
