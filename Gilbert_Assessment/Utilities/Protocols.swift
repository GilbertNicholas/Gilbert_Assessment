//
//  Protocols.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import Foundation

protocol DashboardViewControllerDelegate {
    func didTapMenu()
}

protocol MenuViewControllerDelegate {
    func didSelectOption(menuOption: MenuOptions)
}

protocol TextFieldDelegate {
    func setupText(text: String)
}

protocol ContentCoordinatorDelegate {
    func didChangeContent()
}

protocol PayeesViewControllerDelegate {
    func didSelectPayee(selectedPayee: PayeesData)
}

protocol MockAPIDataSource {
    func login(username: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}
