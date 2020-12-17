//
//  PokemonTableViewController.swift
//  PList
//
//  Created by Giuseppe Valenti on 17/12/20.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    var pokemons: Array<Pokemon> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokémon list"
        navigationController?.navigationBar.prefersLargeTitles = true
        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        let item = pokemons[indexPath.row]
        cell.textLabel?.text = "\(item.id) - \(item.name.capitalized)"
        let imageURL = URL(string: "https://pokeres.bastionbot.org/images/pokemon/\(item.id).png")
        getImageData(from: imageURL!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    let img = UIImage(data: data)
                    cell.imageView?.image = img
                    cell.setNeedsLayout()
                }
            }
        return cell
    }
    
    private func loadData(){
        let pk = Pokemon(name: "Ditto", url: "https://pokeapi.co/api/v2/pokemon/132")
        pokemons.append(pk)
        self.refreshUI()
    }
    
    func refreshUI(){
        self.tableView.reloadData()
    }
    
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}
