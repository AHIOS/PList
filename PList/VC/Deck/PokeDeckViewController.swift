//
//  PokeDeckViewController.swift
//  PList
//
//  Created by Giuseppe Valenti on 22/12/20.
//

import UIKit

class PokeDeckViewController: UIViewController {
    
    var pokeVMs = [PokemonViewModel]()
    var pokeDetailVMs = [PokemonDetailViewModel]()
    
    private var mainView: PokeDeckView {
        let pDeckView = self.view as! PokeDeckView
        pDeckView.coordinator = self.coordinator
        return pDeckView
    }
    
    //Navigation
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let rightButton = UIBarButtonItem(title:"switch", style: .plain, target: self, action: nil)
        self.navigationController!.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    override func loadView() {
        view = PokeDeckView()
        
        loadData()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        mainView.viewOrientationDidChange()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func reloadUI() {
        if (self.pokeDetailVMs.count == 50){
            DispatchQueue.main.async {
                self.mainView.configure(pokes: self.pokeDetailVMs)
            }
        }
    }
    
    private func loadData(){
        DataRetriever.fetchList(limit: 50, offset:0){ pList in
            let fetched = pList.results
            let vms = fetched.map { model -> PokemonViewModel in
                DataRetriever.fetchItem(id: model.id) { pokemonDict in
                    let pokeDetVM = PokemonDetailViewModel(with: pokemonDict)
                        self.pokeDetailVMs.append(pokeDetVM)
                    self.reloadUI()
//                    })
                }
                return PokemonViewModel(with: model)
            }
            self.pokeVMs.append(contentsOf: vms)
            
        }
    }

}
