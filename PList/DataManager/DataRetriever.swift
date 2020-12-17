//
//  DataRetriever.swift
//  PList
//
//  Created by Giuseppe Valenti on 17/12/20.
//

import Foundation

struct DataRetriever {
    static var baseurl = "https://pokeapi.co/api/v2"
    static var imageBaseUrl = "https://pokeres.bastionbot.org/images/pokemon/"
//    static var imageBaseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny"
    
    static func fetchList(completionHandler:@escaping (PokemonList)->()) {
        if let listUrl = URL(string: "\(baseurl)/pokemon"){
            let session = URLSession.shared
            session.dataTask(with: listUrl) { (data, resp, err) in
                if err == nil, data != nil{
                    let decoder = JSONDecoder()
                    do {
                        let itemsList = try decoder.decode(PokemonList.self, from: data!)
                        completionHandler(itemsList)
                    } catch {
                        debugPrint("Error Parsiong JSON")
                    }
                    
                }
            }.resume()
        }
    }
    
}