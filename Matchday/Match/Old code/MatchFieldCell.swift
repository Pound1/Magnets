//
//  MatchFieldCell.swift
//  Matchday
//
//  Created by Lachy Pound on 5/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class MatchFieldCell: UICollectionViewCell {
    
    // pass in a playing group, provide it to the collevtion view
    var players = [Player]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMatchFieldCell()
    }
    
    func configureView(with players: [Player]) {
        self.players = players
        setUpMatchFieldCell()
    }
    
    private func setUpMatchFieldCell(){
        // initialise the new controller here
        let layout = UICollectionViewFlowLayout()
        let matchView = MatchView(frame: .zero, collectionViewLayout: layout)
        matchView.playersOnField = players
        addSubview(matchView)
        
        NSLayoutConstraint.activate([
            matchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            matchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            matchView.topAnchor.constraint(equalTo: topAnchor),
            matchView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
