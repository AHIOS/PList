//
//  PokemonDetailViewController.swift
//  PList
//
//  Created by Giuseppe Valenti on 18/12/20.
//

import UIKit

class PokemonDetailViewController: UIViewController, Storyboarded {
    var pokemon: Pokemon?
    
    //Navigation
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pokemon!.name
        navigationItem.largeTitleDisplayMode = .never
        loadData()

        // Do any additional setup after loading the view.
    }
    
    private func loadData(){
        if let itemId = pokemon?.id{
            DataRetriever.fetchItem(id: itemId) { pokemon in
                DispatchQueue.main.async() {
                    let textLbl = UILabel(frame: self.view.frame)
                    textLbl.numberOfLines = 0
                    textLbl.text = "\(pokemon["name"] as! String)\n\(String(describing: pokemon["abilities"]))"
                    self.view.addSubview(textLbl)
                    textLbl.sizeToFit()
                    textLbl.center = self.view.center
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
