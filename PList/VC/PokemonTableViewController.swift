//
//  PokemonTableViewController.swift
//  PList
//
//  Created by Giuseppe Valenti on 17/12/20.
//

import UIKit

class PokemonTableViewController: UITableViewController, Storyboarded {
    //Datasource
    var pokemons: Array<Pokemon> = []
    
    //Navigation
    weak var coordinator: MainCoordinator?
    
    //Pagination
    var limit = 200
    var offset = 0
    var isFetching = true
    var isFullyLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokémon list"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
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
        DataRetriever.getImageDataForItem(id: item.id, completion: { data, response, error in
            guard let data = data, error == nil else { return }
            self.refreshAvatar(at: indexPath.row, with: data)
        })
        
        //load new data
        if !isFetching, indexPath.row == pokemons.count-5{
            loadData()
        }

        return cell
    }
    
    private func loadData(){
        if isFullyLoaded { return }
        isFetching = true
        DataRetriever.fetchList(limit: limit, offset:offset){ pList in
            let fetched = pList.results
            self.pokemons.append(contentsOf: fetched)
            self.refreshUI()
            self.offset += fetched.count
            self.isFetching = false
            if fetched.count < self.limit {
                self.isFullyLoaded = true
            }
        }
    }
    
    private func refreshAvatar(at rowIndex:Int, with data:Data){
        DispatchQueue.main.async() {
            let img = UIImage(data: data)
            if let thisCell = self.tableView.cellForRow(at: IndexPath(row: rowIndex, section: 0)),
               thisCell.imageView?.tag == -1 {
                thisCell.imageView?.image = img
                thisCell.imageView?.tag = -1
                thisCell.setNeedsLayout()
            }
        }
    }
    
    func refreshUI(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        coordinator?.showDetail(item: pokemon)
    }

}

