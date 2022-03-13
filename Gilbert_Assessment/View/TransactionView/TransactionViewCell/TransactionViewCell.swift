//
//  TransactionViewCell.swift
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
        lbl.textColor = .gray
        return lbl
    }()
    
    let labelFund: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
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
//        self.backgroundColor = .clear
        
        contentView.addSubview(labelName)
        labelName.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 10, paddingLeft: 20)
        
        contentView.addSubview(labelID)
        labelID.anchor(top: labelName.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10)
        
        contentView.addSubview(labelFund)
        labelFund.anchor(top: labelName.topAnchor, right: contentView.rightAnchor, paddingTop: 15, paddingRight: 15)
    }
    
    func configureContent(data: TranData) {
        if data.transactionType == TransactionType.transfer.rawValue {
            if let receipient = data.receipient {
                labelName.text = receipient.accountHolder
                labelID.text = receipient.accountNo
            }
        } else {
            if let sender = data.sender {
                labelName.text = sender.accountHolder
                labelID.text = sender.accountNo
            }
        }

        labelFund.text = (data.transactionType == TransactionType.transfer.rawValue ? "- " : "") + "SGD \(data.amount)"
        labelFund.textColor = data.transactionType == TransactionType.transfer.rawValue ? .red : .systemGreen
    }
}
