//
//  DetailDailyUsageEnergyChart.swift
//  Chart
//
//  Created by NhiVHY on 3/14/24.
//

import UIKit

class DetailDailyUsageEnergyChart: BaseNibView {
    // MARK: - IBOutlets
    @IBOutlet weak var dateRangeLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet weak var avgDailyUsageLabel: UILabel!
    @IBOutlet weak var avgDailyConsumptionLabel: UILabel!
    private var chartView = DailyUsageEnergyChart(frame: CGRect.zero)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        loadViewFromNibFile(DetailDailyUsageEnergyChart.getNibName())
        setupUI()
    }
    
    
    func setContentData(_ dataSource: ConsumptionResponse,
                        height: CGFloat,
                        row: Int,
                        focusDate: Date) {
        chartView.frame = scrollView.frame
        chartView.focusDate = focusDate
        let widthDay = (scrollView.frame.width - chartView.paddingLeft - chartView.paddingRight) / CGFloat(row)
        if !dataSource.usageHistories.isEmpty {
            // caculate content size and add chart view
            let contentWidth = CGFloat(dataSource.usageHistories.count) * widthDay + chartView.paddingLeft + chartView.paddingRight
            var contentSize = CGSize(width: contentWidth, height: height)
            if contentSize.width == scrollView.frame.width {
                contentSize.width = contentWidth + chartView.paddingLeft
            }
            chartView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: contentSize)
            scrollView.contentSize = contentSize
      
            scrollView.addSubview(chartView)
            chartView.setData(data: dataSource, width: widthDay)
            jumpToDate(chartView.focusDate)
            chartView.setNeedsDisplay()
        }
        
    }
    
    func configLabels(avgUsage: Double,
                      avgConsumption: Double,
                      firstDate: Date,
                      lastDate: Date) {
        let roundedAvgUsage = String(format: "%.2f", avgUsage)
        let roundedAvgConsumption = String(format: "%.2f", avgConsumption)
        avgDailyUsageLabel.text = "$" + roundedAvgUsage
        avgDailyConsumptionLabel.text = roundedAvgConsumption + " kWh"
        
        dateRangeLabel.text = "\(firstDate.monthName()) \(firstDate.stringDay()) - \(lastDate.monthName()) \(lastDate.stringDay())"
    }
}

extension DetailDailyUsageEnergyChart {
    func setupUI() {
        scrollView.delegate = self
        chartView.scrollView = scrollView
        chartView.paddingBottom = 20
        chartView.paddingLeft = 10
        chartView.paddingRight = 10
        avgDailyUsageLabel.textColor = .systemBlue
        avgDailyConsumptionLabel.textColor = .systemBlue
    }
    
    private func redrawWeightChart() {
        let limitValue = getMaxMinValue()
        chartView.maximumValue = limitValue.0
        chartView.minimumValue = limitValue.1
        chartView.targetUpper = limitValue.0
        chartView.targetUnder = limitValue.1
        chartView.setNeedsDisplay()
    }

    private func getMaxMinValue() -> DoubleLimitValue {
        let usageHistories = chartView.dataSource?.usageHistories
        guard let max = usageHistories?.max(by: { $0.cost ?? 0.1 < $1.cost ?? 0.1 } )?.cost?.rounded(.up) else {
            return (20, 0)
        }
        return (max, 0.0)
    }
    
    func jumpToDate(_ date: Date) {
        let index = 0
//        let offsetX = (CGFloat(index + 1) * chartView.columnWidth) - chartView.paddingLeft/2 - scrollView.frame.width/2
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        chartView.focusDate = date
        redrawWeightChart()
    }
}

extension DetailDailyUsageEnergyChart: UIScrollViewDelegate {
    // scrollViewDidEndDragging
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            handleStopScroll(scrollView)
        }
    }

    // scrollViewDidEndDecelerating
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        handleStopScroll(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }

    // check position and fire load more
    private func handleStopScroll(_ scrollView: UIScrollView) {
        // when stop scrolling then perform cal max, min of y axis and draw chart
//        redrawWeightChart()

        if scrollView.contentOffset.x == 0 {
          
        } else if scrollView.contentOffset.x + scrollView.frame.width == scrollView.contentSize.width {
           
        }
    }
}
