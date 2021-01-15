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
    var details: PokemonDetails?
}

struct PokemonList : Codable{
    var count : Int
    var next: String?
    var previous: String?
    var results : Array<Pokemon>
}

struct PokemonDetails : Codable {
    var json : String
}

//v2
extension PokemonList : Parsable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<PokemonList, ErrorResult> {
        if (dictionary["results"] as? [AnyObject]) != nil {
            do {
                let pokeList = try PokemonList(from: dictionary)
                return Result.success(pokeList)
            } catch {
                debugPrint("Error Parsiong JSON")
                return Result.failure(ErrorResult.parser(string: "Unable to parse pokemons"))
            }
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse json"))
        }
    }
}

extension Pokemon : Parsable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Pokemon, ErrorResult> {
        if let results = dictionary["results"] as? [AnyObject] {
            
            print(results)
            
            
            return Result.success(Pokemon(name: "Bulbasaur", url: "/1", details: nil))
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse pokemons"))
        }
    }
    
    
}
