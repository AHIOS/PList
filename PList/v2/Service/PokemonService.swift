//
//  File.swift
//  PList
//
//  Created by Giuseppe Valenti on 02/01/21.
//

import Foundation

protocol PokemonServiceProtocol : class {
    func fetchPokemons(_ completion: @escaping ((Result<PokemonList, ErrorResult>) -> Void))
}

final class PokemonService : RequestHandler, PokemonServiceProtocol {
    
    static let shared = PokemonService()
    
    let endpoint = "https://pokeapi.co/api/v2"
    var task : URLSessionTask?
    
    func fetchPokemons(_ completion: @escaping ((Result<PokemonList, ErrorResult>) -> Void)) {
        
        // cancel previous request if already in progress
        cancelFetchPokemons()
        let url = endpoint.appending("/pokemon")
        
        task = RequestService().loadData(urlString: url, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchPokemons() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
