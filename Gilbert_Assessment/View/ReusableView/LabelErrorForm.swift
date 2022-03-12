//
//  LabelErrorForm.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import UIKit

class LabelErrorForm: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = .red
        self.font = UIFont.systemFont(ofSize: 14)
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
