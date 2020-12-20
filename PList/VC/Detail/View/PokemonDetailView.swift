//
//  PokemonDetailView.swift
//  PList
//
//  Created by Giuseppe Valenti on 20/12/20.
//

import UIKit
import PinLayout

class PokemonDetailView: UIView {
    private let spacerView = PokemonDetailSpacerView()
    private let headerView = PokemonDetailHeaderView()
    private let roundedView = UIView()
    var imageView = UIImageView()

    init(){
        super.init(frame: .zero)
        addSubview(spacerView)
        addSubview(headerView)
        addSubview(roundedView)
        addSubview(imageView)
        self.pin.all(pin.safeArea)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerView.pin.below(of: spacerView, aligned: .center).bottom().width(of:spacerView)
        roundedView.pin.bottomCenter(to:spacerView.anchor.bottomCenter).width(of:spacerView).height(30).width(of:spacerView)
        imageView.pin.bottomCenter(to:spacerView.anchor.bottomCenter).width(200).height(200)
    }
    
    func setPrimaryColor(color:UIColor){
        spacerView.setBackground(color: color)
        headerView.primaryColor = color
        roundedView.backgroundColor = headerView.backgroundColor
        roundedView.roundCorners([.topLeft, .topRight], radius: 15)
    }
    
    func set(name:String){
        headerView.set(name:name)
    }
    
    func set(type:String){
        headerView.set(type:type)
    }
    
    func set(image:UIImage){
        imageView.image = image
    }
}
