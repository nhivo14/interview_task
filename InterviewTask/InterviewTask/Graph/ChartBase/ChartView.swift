//
//  ChartView.swift
//  Chart
//
//  Created by NhiVHY on 3/14/24.
//


import Foundation
import UIKit

class ChartView: ChartBase {
    // MARK: - Variables
    private let fontSize: CGFloat = 15
    var columnWidth: CGFloat = 0
    let lineHeight: CGFloat = 1.0
    var paddingLeft: CGFloat = 0
    var paddingRight: CGFloat = 0
    var dataSource: ConsumptionResponse?
    var cellWidth: CGFloat = 0

    var focusDate: Date = Date()
    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawChart()
        drawHorizontalLines()
        drawColumn()
    }
    
    func drawChart() {
        // set background color for bottom chart
        ctx?.setFillColor(UIColor.white.cgColor)
        let y = chartHeight + 1 * space + paddingBottom
        ctx?.fill(CGRect(x: 0, y: y, width: bounds.width, height: bounds.height - y))
        
        // set backgroud color for top chart
        ctx?.setFillColor(UIColor.white.cgColor)
        ctx?.fill(CGRect(x: 0, y: 0, width: bounds.width, height: paddingBottom))
    }
    
    func drawHorizontalLines() {}
    func drawColumn() {}
}
