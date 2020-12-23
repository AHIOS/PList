//
//  PokeDeckView.swift
//  PList
//
//  Created by Giuseppe Valenti on 22/12/20.
//

import UIKit

class PokeDeckView: UIView {

    private let collectionView: UICollectionView
    private let flowLayout = UICollectionViewFlowLayout()
    private let cellTemplate = PokeCardCell()
    
    private var pokes: [Poke] = []
    
    init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 0
        
        if #available(iOS 11.0, tvOS 11.0, *) {
            flowLayout.sectionInsetReference = .fromSafeArea
        }
        
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PokeCardCell.self, forCellWithReuseIdentifier: PokeCardCell.reuseIdentifier)
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(pokes: [Poke]) {
        self.pokes = pokes
        collectionView.reloadData()
    }

    func viewOrientationDidChange() {
        flowLayout.invalidateLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.pin.all(pin.safeArea).margin(flowLayout.minimumLineSpacing)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension PokeDeckView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCardCell.reuseIdentifier, for: indexPath) as! PokeCardCell
        cell.configure(poke: pokes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellTemplate.configure(poke: pokes[indexPath.row])
        return cellTemplate.sizeThatFits(CGSize(width: (collectionView.bounds.width / 2) - 5, height: .greatestFiniteMagnitude))
    }

}
