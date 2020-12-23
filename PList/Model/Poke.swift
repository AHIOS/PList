//
//  Poke.swift
//  PList
//
//  Created by Giuseppe Valenti on 22/12/20.
//

import Foundation

struct Poke : Codable{
    var name: String
    var url: String
    var id: Int {
        return Int((url as NSString).lastPathComponent)!
    }
    var details: PokemonDetails?
}
