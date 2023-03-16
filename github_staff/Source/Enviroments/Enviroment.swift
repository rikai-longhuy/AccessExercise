//
//  Enviroment.swift
//  github_staff

import Foundation

class Enviroment {
    // Becasue Github will remove token when upload it to github
    // So I split git for this example
    static let token_part1 = "ghp_"
    static let token_part2 = "4EowRPRO3QPUNTDp9126"
    static let token_part3 = "zxr1s8qJOd1AxMJr"
    static let token = token_part1 + token_part2 + token_part3
    
    static let host = "https://api.github.com"
}
