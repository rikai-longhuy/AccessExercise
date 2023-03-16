//
//  ViewExtension.swift
//  github_staff


import Foundation
import UIKit

extension UIView {
    class func loadViewFromNib<T: UIView>(type: T.Type) -> T {
        return Bundle.main.loadNibNamed(T.className, owner: nil)!.first as! T
    }
}
