//
//  ChartBase.swift
//  Chart
//
//  Created by NhiVHY on 3/14/24.
//


import UIKit

class ChartBase: UIView {
    var ctx = UIGraphicsGetCurrentContext()
    var targetUpper: CGFloat?
    var targetUnder: CGFloat?
    var maximumValue: CGFloat = 0
    var minimumValue: CGFloat = 0
    var chartHeight: CGFloat = 0
    var paddingBottom: CGFloat = 0
    var paddingTop: CGFloat = 0
    let space: CGFloat = 20
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(UIColor.white.cgColor)
        ctx?.fill(rect)
        chartHeight = bounds.size.height - (paddingBottom + paddingTop + 2 * space)
    }
}

extension ChartBase {
    func drawLine(point1: CGPoint, point2: CGPoint, lineColor: UIColor, lineWidth: CGFloat) {
        ctx?.setLineWidth(lineWidth)
        ctx?.setStrokeColor(lineColor.cgColor)
        ctx?.move(to: point1)
        ctx?.addLine(to: point2)
        ctx?.strokePath()
    }

    func attributeString(textColor: UIColor, fontSize: CGFloat, alignment: NSTextAlignment = .center) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        let font: UIFont = .systemFont(ofSize: 11)
        let attrs = [NSAttributedString.Key.font: font,
                     NSAttributedString.Key.paragraphStyle: paragraphStyle,
                     NSAttributedString.Key.foregroundColor: textColor]
        return attrs
    }
    
    func attributeString(textColor: UIColor, font: UIFont, alignment: NSTextAlignment = .center) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        let attrs = [NSAttributedString.Key.font: font,
                     NSAttributedString.Key.paragraphStyle: paragraphStyle,
                     NSAttributedString.Key.foregroundColor: textColor]
        return attrs
    }
    
    func convertValueToY(value: CGFloat) -> CGFloat {
        let unit = chartHeight / CGFloat(maximumValue - minimumValue)
        let y = chartHeight - (unit * (value - minimumValue))
        return y
    }
    
    func drawTextAt(point: CGPoint, text: NSString, textColor: UIColor, fontSize: CGFloat) -> CGRect {
        let attr = attributeString(textColor: textColor, fontSize: fontSize)
        let textSize = text.size(withAttributes: attr)
        let p = CGPoint(x: point.x - textSize.width * 0.5, y: point.y)
        let frame = CGRect(origin: p, size: textSize)
        text.draw(with: frame,
                  options: .usesLineFragmentOrigin,
                  attributes: attr,
                  context: nil)
        return frame
    }
    
    func drawTextAt(point: CGPoint, text: NSString, textColor: UIColor, font: UIFont) -> CGRect {
        let attr = attributeString(textColor: textColor, font: font, alignment: .center)
        let textSize = text.size(withAttributes: attr)
        let p = CGPoint(x: point.x - textSize.width * 0.5, y: point.y)
        let frame = CGRect(origin: p, size: textSize)
        text.draw(with: frame,
                  options: .usesLineFragmentOrigin,
                  attributes: attr,
                  context: nil)
        return frame
    }

    func drawFill(point1: CGPoint,
                  point2: CGPoint,
                  point3: CGPoint,
                  point4: CGPoint,
                  color: UIColor = .blue) {
        ctx?.setFillColor(color.cgColor)
        ctx?.move(to: point1)
        ctx?.addLine(to: point2)
        ctx?.addLine(to: point3)
        ctx?.addLine(to: point4)
        ctx?.addLine(to: point1)
        ctx?.fillPath()
    }
}
