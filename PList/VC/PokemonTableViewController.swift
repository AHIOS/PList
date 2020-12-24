//
//  PokemonTableViewController.swift
//  PList
//
//  Created by Giuseppe Valenti on 17/12/20.
//

import UIKit

class PokemonTableViewController: UITableViewController, Storyboarded {
    //Datasource
//    var pokemons: Array<Pokemon> = []
    var pokemonVMs: Array<PokemonViewModel> = []
    
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
        tableView.register(UINib(nibName: "PokemonTableCellView", bundle: .main), forCellReuseIdentifier: "pokemonCell")
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = nil
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonVMs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableCellView
        let item = pokemonVMs[indexPath.row]
        
//        cell.textLabel?.text = "\(item.id) - \(item.name.capitalized)"
        cell.nameLbl?.text = "\(item.name.capitalized)"
        
        cell.avatar?.tag = -1
        cell.avatar?.image = UIImage(named: "placeholder")
        cell.idLbl?.text = "\(item.idLblStr)"
        
//        cell.avatar?.layer.borderWidth = 2
//        cell.avatar?.layer.borderColor = UIColor.red.cgColor
        
        DataRetriever.getImageDataForItem(id: item.id, completion: { data in
            guard let data = data else { return }
            self.refreshAvatar(at: indexPath.row, with: data)
        })
        
        //load new data
        if !isFetching, indexPath.row == pokemonVMs.count-5{
            loadData()
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    private func loadData(){
        if isFullyLoaded { return }
        isFetching = true
        DataRetriever.fetchList(limit: limit, offset:offset){ pList in
            let fetched = pList.results
            let vms = fetched.map { model -> PokemonViewModel in
                return PokemonViewModel(with: model)
            }
            self.pokemonVMs.append(contentsOf: vms)
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
            if let thisCell = self.tableView.cellForRow(at: IndexPath(row: rowIndex, section: 0)) as? PokemonTableCellView,
               thisCell.avatar?.tag == -1 {
                thisCell.avatar?.image = img
                thisCell.avatar?.tag = -1
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
        let pokemonVM = pokemonVMs[indexPath.row]
        coordinator?.showDetail(itemID: pokemonVM.id)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

