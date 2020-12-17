//
//  Pokemon.swift
//  PList
//
//  Created by Giuseppe Valenti on 17/12/20.
//

import Foundation

struct Pokemon : Codable{
    var name: String
    var url: String
    var id: Int {
        return Int((url as NSString).lastPathComponent)!
        }
}
