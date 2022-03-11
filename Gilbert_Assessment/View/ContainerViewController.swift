//
//  ViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit

class ContainerViewController: UIViewController {
    
    private var stateMenu: StateMenu = .closed
    private var currVC: UIViewController?
    
    let menuVC = MenuViewController()
    let dashVC = DashboardViewController()
    
    lazy var transactionVC = TransactionViewController()
    lazy var transferVC = TransferViewController()
    
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currVC = dashVC
        addChildVC()
    }
    
    private func addChildVC() {
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        dashVC.delegate = self
        let navVC = UINavigationController(rootViewController: dashVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }

}

extension ContainerViewController: DashboardViewControllerDelegate {
    func didTapMenu() {
        toggleMenu()
    }
    
    func toggleMenu() {
        switch stateMenu {
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.stateMenu = .closed
                }
            }
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.dashVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.stateMenu = .opened
                }
            }
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelectOption(menuOption: MenuOptions) {
        toggleMenu()
        switch menuOption {
        case .dashboard:
            self.resetToHome()
        case .transaction:
            let vc = transactionVC
            self.addVC(vc: vc)
        case .transfer:
            let vc = transferVC
            self.addVC(vc: vc)
        case .logout:
            break
        }
    }
    
    func addVC(vc: UIViewController) {
        removeCurrVC()
        
        currVC?.addChild(vc)
        currVC?.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: currVC)
        currVC?.title = vc.title
        currVC = vc
    }
    
    func resetToHome() {
        removeCurrVC()
        
        currVC?.title = "Dashboard"
    }
    
    func removeCurrVC() {
        if currVC != dashVC {
            currVC?.view.removeFromSuperview()
            currVC?.didMove(toParent: nil)
            currVC = dashVC
        }
    }
}

