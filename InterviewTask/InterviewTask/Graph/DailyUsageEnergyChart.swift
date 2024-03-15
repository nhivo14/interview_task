//
//  DailyUsageEnergyChart.swift
//  Chart
//
//  Created by NhiVHY on 3/14/24.
//

import UIKit

class DailyUsageEnergyChart: ChartView {
    weak var scrollView: UIScrollView!
    var attribute : [NSAttributedString.Key: Any]!
    // MARK: - Init
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func drawHorizontalLines() {
        let chartWidth: CGFloat = bounds.size.width
        let p1 = CGPoint(x: paddingLeft, y: chartHeight)
        let p2 = CGPoint(x: chartWidth - paddingRight, y: chartHeight)
        drawLine(point1: p1, point2: p2, lineColor: .black, lineWidth: lineHeight)
    }
    
    override func drawColumn() {
        setDrawColumn(data: dataSource)
    }
    
    private func setDrawColumn(data: ConsumptionResponse?) {
        guard let data = data else {
            return
        }
        let chartWidth: CGFloat = bounds.size.width
        for (index, item) in data.usageHistories.enumerated() {
            let x = paddingLeft + (CGFloat(index) * columnWidth)
            let stringDay = item.dateValue?.stringDay()
            let dayPoint = CGPoint(x: x + 15, y: chartHeight + 15)
            let stringMonth = item.dateValue?.monthName()
            let monthPoint = CGPoint(x: x + 15, y: chartHeight + space + 18)
            if let cost = item.cost, cost != 0 {
                let y = convertValueToY(value: item.cost ?? cost)
                let p1  = CGPoint(x: x, y: chartHeight - 15)
                let p2  = CGPoint(x: x, y: y)
                let p3  = CGPoint(x: x + 30, y: y)
                let p4  = CGPoint(x: x + 30, y: chartHeight - 15)
                drawFill(point1: p1,
                         point2: p2,
                         point3: p3, point4: p4, color: item.dateValue?.isEqual(to: focusDate) ?? false ? .red : .blue)
            }
         
            
            // draw day
            _ = drawTextAt(point: dayPoint, text: stringDay as! NSString, textColor: .black, font: .systemFont(ofSize: 14))
            // draw month
            _ = drawTextAt(point: monthPoint, text: stringMonth as! NSString, textColor: .black, font: .systemFont(ofSize: 14))
        }
    }
}

extension DailyUsageEnergyChart {
    func setData(data: ConsumptionResponse, width: CGFloat) {
        dataSource = data
        columnWidth = width
    }
    
    func getIndex(date: Date) -> Int? {
        return nil
    }
}
