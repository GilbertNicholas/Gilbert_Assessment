//
//  ViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 11/03/22.
//

import UIKit

class ContentContainerViewController: UIViewController {
    
    private var stateMenu: StateMenu = .closed
    private var currVC: UIViewController?
    
    var delegate: ContentCoordinatorDelegate?
    let menuVC = SideMenuViewController()
    let dashVC = DashboardViewController()
    
    var navVC: UINavigationController?
    
    let viewOpac = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currVC = dashVC
        addChildVC()
        viewOpac.backgroundColor = .black
        viewOpac.layer.opacity = 0.8
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMenuTap))
        viewOpac.addGestureRecognizer(tap)
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
    
    @objc func dismissMenuTap() {
        didTapMenu()
    }
}

extension ContentContainerViewController: DashboardViewControllerDelegate {
    func didTapMenu() {
        switch stateMenu {
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
                self.viewOpac.removeFromSuperview()
            } completion: { [weak self] done in
                if done {
                    self?.stateMenu = .closed
                }
            }
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                if let navVC = self.navVC {
                    navVC.view.frame.origin.x = self.dashVC.view.frame.size.width - 100
                    navVC.view.insertSubview(self.viewOpac, at: 1)
                    self.viewOpac.addConstraintsToFillView(navVC.view, top: navVC.view.topAnchor)
                }
            } completion: { [weak self] done in
                if done {
                    self?.stateMenu = .opened
                }
            }
        }
    }
}

extension ContentContainerViewController: MenuViewControllerDelegate {
    func didSelectOption(menuOption: MenuOptions) {
        if stateMenu == .opened {
            didTapMenu()
        }
        switch menuOption {
        case .dashboard:
            self.resetToHome()
        case .transaction:
            let vc = TransactionViewController()
            self.addVC(vc: vc)
        case .transfer:
            let vc = TransferViewController()
            vc.delegate = self
            self.addVC(vc: vc)
        case .logout:
            self.logout()
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
        currVC?.viewDidLoad()
    }
    
    func removeCurrVC() {
        if currVC != dashVC {
            currVC?.dismiss(animated: false, completion: nil)
            currVC?.view.removeFromSuperview()
            currVC?.didMove(toParent: nil)
            currVC = dashVC
        }
    }
    
    func logout() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsType.token.rawValue)
        UserDefaults.standard.set(nil, forKey: UserDefaultsType.username.rawValue)
        UserDefaults.standard.set(nil, forKey: UserDefaultsType.accNumber.rawValue)
        delegate?.didChangeContent()
    }
}

