//
//  CollectionView+Extension.swift
//  TeldaTask
//
//  Created by Sharaf on 12/5/24.
//

import Foundation
import UIKit

extension UICollectionView {
    @discardableResult
    func register<Cell: UICollectionViewCell> (nib cell: Cell.Type)-> Self {
        self.register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
        return self
    }
    
    @discardableResult
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath)-> Cell {
        let id = Cell.identifier
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? Cell else {
            fatalError("Cannot dequeue cell with identifier '\(id)'")
        }
        return cell
    }
}
