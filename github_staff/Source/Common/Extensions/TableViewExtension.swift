//
//  TableViewExtension.swift
//  github_staff

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        let className = type.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }

    func dequeueCell<T: UITableViewCell>(_ type: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className) as! T
    }

    func dequeueCell<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }

    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        let nib = UINib(nibName: type.className, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: type.className)
    }

    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: type.className) as! T
    }

    func cellAtIndex<T: UITableViewCell>(_ type: T.Type, row: Int = 0, section: Int = 0) -> T {
        return cellForRow(at: IndexPath(row: row, section: section)) as! T
    }
    
    func isLastCell(at indexPath: IndexPath) -> Bool {
           return indexPath.row == (numberOfRows(inSection: indexPath.section) - 1)
       }

       func isLastSectionAndLastRow(at indexPath: IndexPath) -> Bool {
           return indexPath.section == (numberOfSections - 1) && isLastCell(at: indexPath)
       }

}
