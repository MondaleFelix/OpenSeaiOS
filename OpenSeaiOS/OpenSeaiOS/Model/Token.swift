//
//  Token.swift
//  OpenSeaiOS
//
//  Created by Mondale on 7/29/21.
//

import Foundation

struct AssetContract: Codable {
    var address: String
    var asset_contract_type: String
    var name: String

}

struct Username: Codable {
    var username: String
}

struct User: Codable {
    var user: Username
}

struct Token: Codable {
    var num_sales: Int
    var image_url: String
    var name: String
    var owner: User
    var asset_contract: AssetContract
}

struct TokenList: Codable {
    var assets: [Token]
}
