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
    
    static func getImageDataForItem(id:Int, completion: @escaping (Data?) -> ()) {
        do {
            if let cachedImg = try loadImage(named: "\(id)") {
                debugPrint("\(id) LOADED FROM CACHE")
                completion(cachedImg)
                return
            }
        } catch {
            debugPrint("\(id) not cached")
        }
        if let imageURL = URL(string: "\(imageBaseUrl)\(id).png"){
            URLSession.shared.dataTask(with: imageURL) { (data, res, err) in
                //missing image from api returns utf8 data and no errors, so look also into http response code
                if err == nil, data != nil, (res as? HTTPURLResponse)?.statusCode != 404{
                    do {
                        if (id == 412) {
                            print("Missing IMAGE")
                        }
                        let saved = try saveImage(imgData: data!, to: "\(id)")
                        if saved { debugPrint("SAVED image \(id)") }
                        completion(data)
                    } catch {
                        debugPrint("Error Parsiong JSON")
                    }
                }
                
                
            }.resume()
        }
    }
    
    static func fetchItem(id:Int, completionHandler:@escaping ([String: Any], String)->()) {
        do {
            if let cached = try loadJSON(withFilename: "\(id)") {
                debugPrint("LOADED FROM CACHE")
                let str = try loadJSONString(withFilename: "\(id)")
                completionHandler(cached as! [String: Any], str!)
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
                            let saved = try save(jsonObject: json, to: "\(id)")
                            if saved { debugPrint("SAVED") }
                            let jsonStr = String(decoding: data!, as: UTF8.self)
                            completionHandler(json, jsonStr)
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
    
    static func loadJSONString(withFilename filename: String) throws -> String? {
            let fm = FileManager.default
            let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
            if let url = urls.first {
                var fileURL = url.appendingPathComponent(filename)
                fileURL = fileURL.appendingPathExtension("json")
                let data = try Data(contentsOf: fileURL)
                let jsonStr = String(data: data, encoding: .utf8)
                return jsonStr
            }
            return nil
        }
        
        static func save(jsonObject: Any, to filename: String) throws -> Bool{
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
    
    static func saveImage(imgData:Data, to filename: String) throws ->Bool{
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("png")
            print(fileURL)
            try imgData.write(to: fileURL, options: [.atomicWrite])
            return true
        }
        return false
    }
    static func loadImage(named: String) throws -> Data?{
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(named)
            fileURL = fileURL.appendingPathExtension("png")
            let data = try Data(contentsOf: fileURL)
            return data
        }
        return nil
    }

}
