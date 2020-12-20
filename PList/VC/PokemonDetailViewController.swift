//
//  PokemonDetailViewController.swift
//  PList
//
//  Created by Giuseppe Valenti on 18/12/20.
//

import UIKit

class PokemonDetailViewController: UIViewController, Storyboarded {
    var pokemonId: Int?
    var pokemonVM: PokemonDetailViewModel?{
        didSet {
            refreshUI()
        }
    }
    var appeared = false
    
    //Navigation
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        appeared = false
    }
    override func viewDidAppear(_ animated: Bool) {
        appeared = true
    }
    
    private func loadData(){
        if let itemId = pokemonId{
            DataRetriever.fetchItem(id: itemId) { pokemonDict in
                //if still transitioning delay the UI update
                if (self.appeared){
                    self.pokemonVM = PokemonDetailViewModel(with: pokemonDict)
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.pokemonVM = PokemonDetailViewModel(with: pokemonDict)
                    }
                }
            }
        }
    }
    
    private func refreshUI(){
        DispatchQueue.main.async {
            self.title = self.pokemonVM?.name
            let color = self.pokemonVM?.color
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color!]
            self.view.backgroundColor = color?.withAlphaComponent(0.75)
            let textLbl = UILabel(frame: self.view.frame)
            textLbl.numberOfLines = 0
            textLbl.text = "\(String(describing: self.pokemonVM))"
            self.view.addSubview(textLbl)
            textLbl.sizeToFit()
            textLbl.center = self.view.center
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
