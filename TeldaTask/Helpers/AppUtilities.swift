//
//  AppUtilities.swift
//  Helpers
//
//  Created by Sharaf on 6/21/24.
//

import Foundation
import UIKit

internal final class AppUtilities {
    static func changeRoot(root: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil )  {
        let coordinator = (UIApplication.shared.delegate as! AppDelegate).coordinator
        guard animated else {
            coordinator.setRoot(root)
            return
        }
        
        UIView.transition(with: coordinator.window, duration: 0.7, options: .transitionCrossDissolve, animations: {
            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            coordinator.setRoot(root)
            UIView.setAnimationsEnabled(oldState)
        }, completion: { (finished: Bool) -> () in
            if (completion != nil) {
                completion!()
            }
        })
    }
}
