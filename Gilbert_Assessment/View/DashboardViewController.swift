//
//  DashboardViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    var delegate: DashboardViewControllerDelegate?
    
    let labelName: UILabel = {
        let label = UILabel()
        label.text = """
            Hello,
            Gilbert Nicholas
        """
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
//    let textField = FormTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Dashboard"
        
        configureUI()
    }
    
    private func configureUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuBtn))
        
        view.addSubview(labelName)
        labelName.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30)
        
//        view.addSubview(textField)
//        textField.setupTextField(type: .text, title: "Email:", placeholder: "Tulis disini..")
//        textField.anchor(top: labelName.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20)
    }
    
    @objc func didTapMenuBtn() {
        delegate?.didTapMenu()
    }
}
