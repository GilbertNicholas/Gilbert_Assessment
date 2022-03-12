//
//  MenuViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit

class MenuViewController: UIViewController {
    
    var delegate: MenuViewControllerDelegate?
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .lightGray
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let userLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(userLabel)
        if let username = UserDefaults.standard.string(forKey: UserDefaultsType.username.rawValue) {
            userLabel.text = username
        }
        userLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20)
        
        view.addSubview(tableView)
        tableView.anchor(top: userLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10)
        
        view.backgroundColor = .gray
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = MenuOptions.allCases[indexPath.row].rawValue
        content.textProperties.color = .white
        content.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        content.imageProperties.tintColor = .white

        cell.contentConfiguration = content
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let option = MenuOptions.allCases[indexPath.row]
        delegate?.didSelectOption(menuOption: option)
    }
}
