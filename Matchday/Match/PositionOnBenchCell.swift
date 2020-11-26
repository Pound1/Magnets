//
//  PositionOnBenchCell.swift
//  Matchday
//
//  Created by Lachy Pound on 23/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit
//I DONT THINK THIS IS USED
class PositionOnBenchCell: UICollectionViewCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setUpPositionCell()
        }
        
        override var isSelected: Bool {
            didSet{
                if self.isSelected {
                    matchPlayerDetailView.backgroundColor = .gray
                } else {
                    matchPlayerDetailView.backgroundColor = .white
                }
            }
        }
        
        let matchPlayerDetailView: BaseMatchPlayerView = {
            let detailView = BaseMatchPlayerView()
            detailView.clipsToBounds = true
            detailView.layer.cornerRadius = 20
            return detailView
        }()
        
        private func setUpPositionCell(){
            layer.cornerRadius = 5
            addSubview(matchPlayerDetailView)
            
            NSLayoutConstraint.activate([
                matchPlayerDetailView.leadingAnchor.constraint(equalTo: leadingAnchor),
                matchPlayerDetailView.trailingAnchor.constraint(equalTo: trailingAnchor),
                matchPlayerDetailView.heightAnchor.constraint(equalToConstant: 44),
                matchPlayerDetailView.topAnchor.constraint(equalTo: topAnchor),
                ])
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

// The below class is similar to MatchPlayerView - but lacks the player number. 
class BaseMatchPlayerView: UIView {
    
    var player: Player? {
        didSet {
            guard let player = player else {return}
            playerName.text = player.name
        }
    }
    
    let playerName: UILabel = {
        let label = UILabel()
        label.text = "Player"
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMatchPlayerDetailView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpMatchPlayerDetailView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(playerName)
        
        NSLayoutConstraint.activate([
            playerName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            playerName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            playerName.topAnchor.constraint(equalTo: topAnchor),
            playerName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            ])
    }
}
