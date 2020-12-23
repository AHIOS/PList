//
//  PokeDeckViewController.swift
//  PList
//
//  Created by Giuseppe Valenti on 22/12/20.
//

import UIKit

class PokeDeckViewController: UIViewController {
    
    var pokeVM : PokemonDetails?
    
    private var mainView: PokeDeckView {
        return self.view as! PokeDeckView
    }
    
    //Navigation
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        view = PokeDeckView()
        
        mainView.configure(pokes: [
            Poke(name: "Bulbasaur 1234567890 1234567890", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil),
            Poke(name: "Bulbasaur", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil),
            Poke(name: "Bulbasaur", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil),
            Poke(name: "Bulbasaur", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil),
            Poke(name: "Bulbasaur", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil),
            Poke(name: "Bulbasaur", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil),
            Poke(name: "Bulbasaur", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil),
            Poke(name: "Bulbasaur", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil),
            Poke(name: "Bulbasaur", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil),
            Poke(name: "Bulbasaur", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil),
            Poke(name: "Bulbasaur", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil),
            Poke(name: "Bulbasaur", url: "https://pokeres.bastionbot.org/images/pokemon/1", details: nil)
        ])
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

}
