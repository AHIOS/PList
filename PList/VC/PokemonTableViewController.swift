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
        
        cell.imageView?.tag = -1
        cell.imageView?.image = UIImage(named: "placeholder")
        let imageURL = URL(string: "https://pokeres.bastionbot.org/images/pokemon/\(item.id).png")
        
        getImageData(from: imageURL!) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    let img = UIImage(data: data)
                    if let thisCell = tableView.cellForRow(at: indexPath),
                       thisCell.imageView?.tag == -1 {
                        thisCell.imageView?.image = img
                        thisCell.imageView?.tag = -1
                        thisCell.setNeedsLayout()
                    }
                }
            }
        return cell
    }
    
    private func loadData(){
        DataRetriever.fetchList { pList in
            let fetched = pList.results
            self.pokemons.append(contentsOf: fetched)
            self.refreshUI()
        }
    }
    
    func refreshUI(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}
