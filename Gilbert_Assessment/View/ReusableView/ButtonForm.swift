//
//  ButtonForm.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import UIKit

class ButtonForm: UIButton {
    
    private var currTitle: String
    
    init(text: String) {
        currTitle = text
        super.init(frame: .zero)
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        setTitle(currTitle, for: .normal)
        setTitleColor(.black, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
