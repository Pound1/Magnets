//
//  ManagePlayerDetailView.swift
//  Matchday
//
//  Created by Lachy Pound on 14/11/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class ManagePlayerDetailView: UICollectionViewCell {
    
    var player: Player? {
        didSet {
            guard let player = player else {return}
            playerName.text = player.name
            playerNumber.text = String(player.number)
        }
    }
    
    var playerNumberSize: CGFloat = 28
    
    let playerName: UILabel = {
        let label = UILabel()
        label.text = "Player"
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playerNumber: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = String(99)
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        label.backgroundColor = .black
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
        layer.cornerRadius = 12
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(playerName)
        addSubview(playerNumber)
        
        NSLayoutConstraint.activate([
            
            playerNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            playerNumber.centerYAnchor.constraint(equalTo: centerYAnchor),
            playerNumber.widthAnchor.constraint(equalToConstant: playerNumberSize),
            playerNumber.heightAnchor.constraint(equalToConstant: playerNumberSize),
            
            playerName.leadingAnchor.constraint(equalTo: playerNumber.trailingAnchor, constant: 4),
            playerName.centerYAnchor.constraint(equalTo: centerYAnchor),
            playerName.bottomAnchor.constraint(equalTo: playerNumber.bottomAnchor),
            playerName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            
            ])
    }
    
    //MARK:- Selection functions
    
    
}
