//
//  PokeCardCell.swift
//  PList
//
//  Created by Giuseppe Valenti on 22/12/20.
//

import UIKit
import PinLayout

class PokeCardCell: UICollectionViewCell {
    static let reuseIdentifier = "PokeCardCell"
    
    private let nameLabel = UILabel()
    private let mainImage = UIImageView()
    private let typeLabel = UILabel()
    private var primaryColor = UIColor()
    
    let hardcodedtype = "fighting"
    
    private let margin: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        primaryColor = .systemGray

        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(nameLabel)
        
        mainImage.backgroundColor = .clear
        mainImage.contentMode = .scaleAspectFill
        mainImage.clipsToBounds = true
        mainImage.image = UIImage(named: "placeholder")
        contentView.addSubview(mainImage)
        
        typeLabel.font = UIFont.systemFont(ofSize: 18)
        typeLabel.textColor = .white
        typeLabel.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        contentView.addSubview(typeLabel)
        
        self.layer.cornerRadius = margin
        self.clipsToBounds = true
        
        setShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(poke: PokemonDetailViewModel) {
        nameLabel.text = poke.name
        nameLabel.sizeToFit()
        DataRetriever.getImageDataForItem(id: poke.id) { [self] data in
            DispatchQueue.main.async {
                mainImage.image = UIImage(data: data!)
            }
        }
        mainImage.contentMode = .scaleAspectFill
        mainImage.backgroundColor = .clear
        
        typeLabel.text = "  \(poke.types[0])  "
        typeLabel.layer.cornerRadius = typeLabel.frame.size.height/2
        typeLabel.sizeToFit()
        typeLabel.clipsToBounds = true
        
        primaryColor = poke.color
        backgroundColor = primaryColor
        self.layer.shadowColor = primaryColor.cgColor
        
        setNeedsLayout()
    }
    
//    func configure(pokeVM: PokemonDetailViewModel) {
//        nameLabel.text = pokeVM.name
//        nameLabel.sizeToFit()
//        DataRetriever.getImageDataForItem(id: pokeVM.id) { [self] data in
//            mainImage.image = UIImage(data: data!)
//        }
//        mainImage.contentMode = .scaleAspectFill
//        mainImage.backgroundColor = .clear
//
//        typeLabel.text = "  \(pokeVM.types[0] ?? hardcodedtype)  "
//        typeLabel.layer.cornerRadius = typeLabel.frame.size.height/2
//        typeLabel.sizeToFit()
//        typeLabel.clipsToBounds = true
//
//        backgroundColor = primaryColor
//        self.layer.shadowColor = primaryColor.cgColor
//
//        setNeedsLayout()
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        mainImage.pin.bottomRight(margin/2).height(60).aspectRatio()
        typeLabel.pin.left(margin*2).bottom(margin*3)
        nameLabel.pin.topLeft(margin).right()
        nameLabel.sizeToFit()
        
        contentView.pin.height(120)
        
        typeLabel.layer.cornerRadius = typeLabel.frame.size.height/2
        typeLabel.clipsToBounds = true
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }
    
    func setShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.75
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        mainImage.layer.shadowColor = UIColor.black.cgColor
        mainImage.layer.shadowOpacity = 0.3
        mainImage.layer.shadowOffset = .zero
        mainImage.layer.shadowRadius = 3

    }
}

