//
//  ContentPlaceholderViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation
import UIKit

class MainPlaceholderViewController: UIViewController {
    
    static let singleton = MainPlaceholderViewController()
    private var currVC: UIViewController?
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        didChangeContent()
    }
}

extension MainPlaceholderViewController: ContentCoordinatorDelegate {
    func didChangeContent() {
        if UserDefaults.standard.string(forKey: "token") == nil {
            let authVC = AuthViewController()
            authVC.delegate = self
            addVC(vc: authVC)
        } else {
            let mainVC = ContentContainerViewController()
            mainVC.delegate = self
            addVC(vc: mainVC)
        }
    }
    
    private func addVC(vc: UIViewController) {
        removeCurrVC()
        
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: self.currVC)
        self.currVC = vc
        
    }
    
    private func removeCurrVC() {
        if let currVC = currVC {
            currVC.dismiss(animated: true, completion: nil)
            currVC.view.removeFromSuperview()
            currVC.didMove(toParent: nil)
            self.currVC = self
        }
    }
}
