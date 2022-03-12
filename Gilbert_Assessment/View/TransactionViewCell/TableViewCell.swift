//
//  TableViewCell.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit

class TransactionViewCell: UITableViewCell {
    static let id = "tranCell"
    
    let labelName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()
    
    let labelID: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    let labelFund: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = .gray
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(labelName)
        labelName.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 10, paddingLeft: 10)
        
        contentView.addSubview(labelID)
        labelID.anchor(top: labelName.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, paddingTop: 10, paddingLeft: 10)
        
        contentView.addSubview(labelFund)
        labelFund.anchor(top: labelName.topAnchor, right: contentView.rightAnchor, paddingTop: 30, paddingRight: 10)
    }
    
    func configureContent(data: TranData) {
        labelName.text = data.receipient.accountHolder
        labelID.text = data.receipient.accountNo
        labelFund.text = "SGD \(data.amount)"
    }
}
