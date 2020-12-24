//
//  PokemonViewModel.swift
//  PList
//
//  Created by Giuseppe Valenti on 19/12/20.
//

import Foundation
import UIKit

struct PokemonViewModel {
    let id: Int
    var idLblStr: String{
        return "#\(id)"
    }
    let name: String
    
    init(with pokemon:Pokemon) {
        self.name = pokemon.name
        self.id = pokemon.id
    }
}

struct Stat{
    let name: String
    let value: Int
    var color: UIColor {
        switch name {
        case "hp":
            return UIColor(hex: "#58E810")
        case "attack":
            return UIColor(hex: "#EACA2F")
        case "defense":
            return UIColor(hex: "#E5721D")
        case "special-attack":
            return UIColor(hex: "#26BAE0")
        case "special-defense":
            return UIColor(hex: "#4C6CD4")
        case "speed":
            return UIColor(hex: "#EF8DEC")
        default:
            return .gray
        }
    }
    var nameTxt: String {
        switch name {
        case "hp":
            return "HP"
        case "attack":
            return "Attack"
        case "defense":
            return "Defense"
        case "special-attack":
            return "Sp. Attack"
        case "special-defense":
            return "Sp. Defense"
        case "speed":
            return "Speed"
        default:
            return name
        }
    }
    
    init(with dict:[String:Any]) {
        let subDict = dict["stat"] as! [String:Any]
        name = subDict["name"] as! String
        value = dict["base_stat"] as! Int
    }
}

struct PokemonDetailViewModel {
    let id: Int
    var idLblStr: String{
        return "\(id)"
    }
    let name: String
    var types = [String]()
    var stats = [Stat]()
    var abilities = [String]()
    let height: Int
    let weight: Int
    var image: UIImage?
    
    init(with pokemonDict:[String: Any]) {
        self.name = (pokemonDict["name"] as! String).capitalized
        self.id = pokemonDict["id"] as! Int
        
        for statDict in pokemonDict["stats"] as! [[String: Any]] {
            let newStat = Stat(with:statDict)
            self.stats.append(newStat)
        }
        
        for ability in pokemonDict["abilities"] as! [[String: Any]] {
            let newAbility = (ability["ability"] as! [String: Any])["name"] as! String
            self.abilities.append(newAbility)
        }
        
        for type in pokemonDict["types"] as! [[String: Any]] {
            let newType = (type["type"] as! [String: Any])["name"] as! String
            self.types.append(newType)
        }
        
        self.height = pokemonDict["height"] as! Int
        self.weight = pokemonDict["weight"] as! Int
    }
    
    var color : UIColor {
        switch self.types[0] {
        case "normal": return UIColor(hex:"#797964")
        case "fire": return UIColor(hex:"#d52100")
        case "water": return UIColor(hex:"#0080ff")
        case "electric": return UIColor(hex:"#c90")
        case "grass": return UIColor(hex:"#5cb737")
        case "ice": return UIColor(hex:"#0af")
        case "fighting": return UIColor(hex:"#a84d3d")
        case "poison": return UIColor(hex:"#88447a")
        case "ground": return UIColor(hex:"#bf9926")
        case "flying": return UIColor(hex:"#556dff")
        case "psychic": return UIColor(hex:"#ff227a")
        case "bug": return UIColor(hex:"#83901a")
        case "rock": return UIColor(hex:"#a59249")
        case "ghost": return UIColor(hex:"#5454b3")
        case "dragon": return UIColor(hex:"#4e38e9")
        case "dark": return UIColor(hex:"#573e31")
        case "steel": return UIColor(hex:"#8e8ea4")
        case "fairy": return UIColor(hex:"#e76de7")
        default:
            return .systemIndigo
        }
    }
}



