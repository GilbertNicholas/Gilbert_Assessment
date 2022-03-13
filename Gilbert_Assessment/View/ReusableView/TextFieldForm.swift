//
//  FormTextField.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit

class TextFieldForm: UITextField {
    
    let inset: UIEdgeInsets
    
    override init(frame: CGRect) {
        self.inset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        super.init(frame: frame)
        layer.cornerRadius = 8
//        layer.borderWidth = 1.5
        layer.backgroundColor = UIColor.white.cgColor
//        layer.borderColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
}


