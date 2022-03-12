//
//  ChoosePayeesUIView.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import UIKit

class ChoosePayeesUIView: UIView {

    var labelName: UILabel = {
        let lblName = UILabel()
        lblName.text = "Choose Receipient"
        lblName.font = UIFont.boldSystemFont(ofSize: 18)
        return lblName
    }()
    
    var labelAccNum: UILabel = {
        let lblAccNum = UILabel()
        lblAccNum.text = "-"
        lblAccNum.textColor = .gray
        return lblAccNum
    }()
    
    let image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "chevron.forward.circle")
        img.tintColor = .black
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(labelName)
        labelName.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 15, paddingLeft: 20)
        
        self.addSubview(labelAccNum)
        labelAccNum.anchor(left: labelName.leftAnchor, bottom: self.bottomAnchor, paddingBottom: 15)
        
        self.addSubview(image)
        image.anchor(width: 30, height: 30)
        image.centerY(inView: self, rightAnchor: self.rightAnchor, paddingRight: 20)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 8
    }
}
