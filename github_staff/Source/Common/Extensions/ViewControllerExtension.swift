//
//  ViewControllerExtension.swift
//  github_staff

import Foundation
import UIKit

extension UIViewController {
    class func loadFromStoryboard<T: UIViewController>(name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: T.className) as! T
        return viewController
    }
}
