//
//  UserModel.swift
//  github_staff


import Foundation

struct UserModel: Codable {
    var id: Int?
    var login: String?
    var avatarUrl: String?
    var siteAdmin: Bool?
    var bio: String?
    var location: String?
    var blog: String?
}
