//
//  BenchCell.swift
//  Matchday
//
//  Created by Lachy Pound on 6/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class BenchCell: UICollectionViewCell {
    
    var player: Player? {
        didSet{
            if let name = player?.name{
                playerName.text = name
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpBenchCell()
    }
    
    let playerName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Player"
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    
//    let timeOnBench: UILabel = {
//        let label = UILabel()
//        label.text = "2m 20s"
////        let benchTime = Int()
////        label.text = "\(String(benchTime)):\(benchTime)"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .white
//        return label
//    }()
    
    func setUpBenchCell() {
        layer.cornerRadius = 5
        addSubview(playerName)
//        addSubview(timeOnBench)
        
        NSLayoutConstraint.activate([
            playerName.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerName.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerName.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            playerName.heightAnchor.constraint(equalTo: heightAnchor),
            
//            timeOnBench.centerXAnchor.constraint(equalTo: centerXAnchor),
//            timeOnBench.topAnchor.constraint(equalTo: playerName.bottomAnchor, constant: 2),
//            timeOnBench.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
