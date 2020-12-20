//
//  PokemonDetailViewController.swift
//  PList
//
//  Created by Giuseppe Valenti on 18/12/20.
//

import UIKit

class PokemonDetailViewController: UIViewController, Storyboarded {
    var pokemon: PokemonViewModel?
    
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
            DataRetriever.fetchItem(id: itemId) { pokemonDict, pokeStr in
                DispatchQueue.main.async() {
                    self.pokemon?.model.details?.json = pokeStr
                    let textLbl = UILabel(frame: self.view.frame)
                    textLbl.numberOfLines = 0
                    print(pokeStr)
                    textLbl.text = "\(pokemonDict["name"] as! String)\n\(pokeStr.substring(to: 100))..."
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

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
