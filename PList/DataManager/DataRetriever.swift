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
    
    static func fetchList(limit:Int, offset:Int, completionHandler:@escaping (PokemonList)->()) {
        if let listUrl = URL(string: "\(baseurl)/pokemon?limit=\(limit)&offset=\(offset)"){
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
    
    static func getImageDataForItem(id:Int, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if let imageURL = URL(string: "\(imageBaseUrl)\(id).png"){
            URLSession.shared.dataTask(with: imageURL, completionHandler: completion).resume()}
    }
    
    static func fetchItem(id:Int, completionHandler:@escaping ([String: Any])->()) {
        do {
            if let cached = try loadJSON(withFilename: "\(id)") {
                print("LOADED FROM CACHE")
                completionHandler(cached as! [String: Any])
                return
            }
        } catch {
            debugPrint("\(id) not cached")
        }
        
        
        
        if let itemUrl = URL(string: "\(baseurl)/pokemon/\(id)"){
            let session = URLSession.shared
            session.dataTask(with: itemUrl) { (data, resp, err) in
                if err == nil, data != nil{
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                            print(json)
                            let saved = try save(jsonObject: json, toFilename: "\(id)")
                            if saved { print("SAVED") }
                            completionHandler(json)
                        }
                    } catch {
                        debugPrint("Error Parsiong JSON")
                    }
                }
            }.resume()
        }
    }

    static func loadJSON(withFilename filename: String) throws -> Any? {
            let fm = FileManager.default
            let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
            if let url = urls.first {
                var fileURL = url.appendingPathComponent(filename)
                fileURL = fileURL.appendingPathExtension("json")
                let data = try Data(contentsOf: fileURL)
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])
                return jsonObject
            }
            return nil
        }
        
        static func save(jsonObject: Any, toFilename filename: String) throws -> Bool{
            let fm = FileManager.default
            let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
            if let url = urls.first {
                var fileURL = url.appendingPathComponent(filename)
                fileURL = fileURL.appendingPathExtension("json")
                print(fileURL)
                let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
                try data.write(to: fileURL, options: [.atomicWrite])
                return true
            }
            
            return false
        }

}
