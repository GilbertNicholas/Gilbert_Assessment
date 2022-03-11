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
