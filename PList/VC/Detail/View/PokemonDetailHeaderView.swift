//
//  PokemonDetailHeaderView.swift
//  PList
//
//  Created by Giuseppe Valenti on 20/12/20.
//

import UIKit

class PokemonDetailHeaderView: UIView {
    private let nameLabel = UILabel(frame: .zero)
    private let typeLabel = UILabel(frame: .zero)
    var primaryColor: UIColor?

    init(){
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        
        nameLabel.textColor = .label
        typeLabel.textColor = .systemBackground
        self.addSubview(nameLabel)
        
        self.addSubview(typeLabel)
        
        self.layoutSubviews()
        
        self.pin.all(pin.safeArea)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.pin.top().hCenter()
        typeLabel.pin.topCenter(to:nameLabel.anchor.bottomCenter)
    }
    
    func set(name:String){
        nameLabel.text = name.capitalized
        nameLabel.font = .systemFont(ofSize: 27)
        nameLabel.sizeToFit()
        self.layoutSubviews()
        
    }
    
    func set(type:String){
        typeLabel.text = "   \(type)   "
        typeLabel.font = .systemFont(ofSize: 18)
        typeLabel.sizeToFit()
        typeLabel.backgroundColor = primaryColor
        typeLabel.layer.cornerRadius = typeLabel.frame.height / 2
        typeLabel.clipsToBounds = true
        self.layoutSubviews()
        
    }

}
