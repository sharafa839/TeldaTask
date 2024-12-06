//
//  TableView+Extension.swift
//  Helpers
//
//  Created by Sharaf on 6/21/24.
//

import Foundation
import UIKit

extension UITableView {
    @discardableResult
    func register<Cell: UITableViewCell> (nib cell: Cell.Type)-> Self {
        self.register(cell.nib, forCellReuseIdentifier: cell.identifier)
        return self
    }
    
    @discardableResult
    func dequeue<Cell: UITableViewCell>()-> Cell {
        let id = Cell.identifier
        guard let cell = self.dequeueReusableCell(withIdentifier: id) as? Cell else { 
            fatalError("Cannot dequeue cell with identifier '\(id)'")
        }
        return cell
    }
}

extension UIView {
    static var identifier: String {
        String(describing: self)
    }
    
    static var nib: UINib {
        UINib(nibName: "\(self)", bundle: nil)
    }
}
