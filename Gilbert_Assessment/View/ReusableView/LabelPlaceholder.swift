//
//  LabelPlaceholder.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 13/03/22.
//

import UIKit

class LabelPlaceholder: UILabel {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.font = UIFont.boldSystemFont(ofSize: 18)
        self.text = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
