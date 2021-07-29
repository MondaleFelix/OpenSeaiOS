//
//  Token.swift
//  OpenSeaiOS
//
//  Created by Mondale on 7/29/21.
//

import Foundation

struct Token: Codable {
    var num_sales: Int
    var image_url: String
    var name: String
}

struct TokenList: Codable {
    var assets: [Token]
}
