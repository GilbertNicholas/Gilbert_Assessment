//
//  ContentPlaceholderViewController.swift
//  Gilbert_Assessment
//
//  Created by Gilbert Nicholas on 12/03/22.
//

import Foundation
import UIKit

class ContentPlaceholderViewController: UIViewController {
    
    static let singleton = ContentPlaceholderViewController()
    private var currVC: UIViewController?
    
    override func viewDidLoad() {
        didChangeContent()
    }
}

extension ContentPlaceholderViewController: ContentCoordinatorDelegate {
    func didChangeContent() {
        if UserDefaults.standard.string(forKey: "token") == nil {
            print("DEBUG1: \(self.currVC)")
            
            let authVC = AuthViewController()
            authVC.delegate = self
            addVC(vc: authVC)
        } else {
            print("DEBUG2: \(self.currVC)")
            
            let mainVC = ContainerViewController()
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
            currVC.view.removeFromSuperview()
            currVC.didMove(toParent: nil)
            self.currVC = nil
        }
    }
}
