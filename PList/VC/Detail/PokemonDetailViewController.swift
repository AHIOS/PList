//
//  PokemonDetailViewController.swift
//  PList
//
//  Created by Giuseppe Valenti on 18/12/20.
//

import UIKit
import PinLayout

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
        self.view.backgroundColor = .systemBackground
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
                
//                //if still transitioning delay the UI update
//                if (self.appeared){
//                    self.pokemonVM = PokemonDetailViewModel(with: pokemonDict)
//                }else{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        self.pokemonVM = PokemonDetailViewModel(with: pokemonDict)
//                    }
//                }
                self.pokemonVM = PokemonDetailViewModel(with: pokemonDict)
            }
            DataRetriever.getImageDataForItem(id: itemId, completion: { data in
                guard let data = data else { return }
                self.refreshAvatar(with: data)
            })
        }
    }
    
    private func refreshUI(){
        DispatchQueue.main.async {
            self.title = self.pokemonVM?.name
            let color = self.pokemonVM?.color
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color!]
            (self.view as! PokemonDetailView).setPrimaryColor(color: color!)
            (self.view as! PokemonDetailView).set(name:self.pokemonVM!.name)
            let type = self.pokemonVM?.types[0]
            (self.view as! PokemonDetailView).set(type:type!)
            (self.view as! PokemonDetailView).set(stats: self.pokemonVM!.stats)
            
//            (self.view as! PokemonDetailView).set(image:type!)
            
//            self.view.backgroundColor = color?.withAlphaComponent(0.75)
//            let textLbl = UILabel(frame: self.view.frame)
//            textLbl.numberOfLines = 0
//            textLbl.text = "\(String(describing: self.pokemonVM))"
//            self.view.addSubview(textLbl)
//            textLbl.sizeToFit()
//            textLbl.center = self.view.center
        }
    }
    
    func refreshAvatar(with data:Data) {
        DispatchQueue.main.async {
            (self.view as! PokemonDetailView).imageView.image = UIImage(data: data)
        }
    }
    
    // MARK: - PinLayout
    private var mainView: PokemonDetailView {
        return self.view as! PokemonDetailView
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = PokemonDetailView()
    }

}
