//
//  ObjectExtension.swift
//  github_staff

import Foundation

import Foundation

extension NSObject {
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    var className: String {
        return String(describing: type(of: self))
    }
}
