//
//  BaseNibView.swift
//  Chart
//
//  Created by NhiVHY on 3/14/24.
//

import UIKit

class BaseNibView: UIView, NibLoadable {
    private var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func loadNibFile(nibName: String) -> UIView {
        let bundle: Bundle = Bundle(for: type(of: self))
        guard let contentView: UIView = bundle.loadNibNamed(nibName,
                                                            owner: self,
                                                            options: nil)!.first as? UIView else {
            return UIView(frame: frame)
        }
        return contentView
    }
}

// MARK: - Public function
extension BaseNibView {
    func loadViewFromNibFile(_ nibName: String) {
        backgroundColor = .clear
        if contentView == nil {
            contentView = loadNibFile(nibName: nibName)
            contentView?.frame = bounds
            contentView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(contentView!)
        }
    }
}
