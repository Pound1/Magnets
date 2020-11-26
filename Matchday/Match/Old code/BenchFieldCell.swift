//
//  BenchFieldCell.swift
//  Matchday
//
//  Created by Lachy Pound on 5/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class BenchFieldCell: UICollectionViewCell {
    
    var players: [Player]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpBenchFieldCell()
    }
    
    func setUpBenchFieldCell(){
        let layout = UICollectionViewFlowLayout()
        let benchView = BenchView(frame: .zero, collectionViewLayout: layout)
        fetchBenchedPlayers(benchView: benchView)
        addSubview(benchView)
        
        NSLayoutConstraint.activate([
            benchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            benchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            benchView.topAnchor.constraint(equalTo: topAnchor),
            benchView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    func fetchBenchedPlayers(benchView: BenchView){
        guard let benchedPlayers = players else {return}
        benchView.players = benchedPlayers
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

