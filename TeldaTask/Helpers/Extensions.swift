//
//  Extensions.swift
//  Helpers
//
//  Created by Sharaf on 5/1/24.
//  Copyright © 2561 Hardik Kothari. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
}

extension UIViewController {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
