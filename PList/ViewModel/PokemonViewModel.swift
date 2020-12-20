//
//  PokemonViewModel.swift
//  PList
//
//  Created by Giuseppe Valenti on 19/12/20.
//

import Foundation

struct PokemonViewModel {
    let id: Int
    let idLblStr: String
    let name: String
    var model: Pokemon
//    let type: String?
//    let abilities: [Ability]
    
    struct Ability{
        let name: String
        let value: Int
    }
    
    init(with pokemon:Pokemon) {
        self.name = pokemon.name
        self.idLblStr = "#\(pokemon.id)"
        self.id = pokemon.id
        self.model = pokemon
//        self.type = pokemon.details.json
    }
}



