//
//  PositionOnFieldCell.swift
//  Matchday
//
//  Created by Lachy Pound on 5/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

// The base position cell contains the field position.
class BasePositionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpPositionCell()
    }
    
    let fieldPositionLabel: UILabel = {
        let label = UILabel()
        var fieldPositionText = "Flank"
        label.textAlignment = .center
        label.textColor = .gray
        label.text = fieldPositionText.uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setUpPositionCell(){
        layer.cornerRadius = 5
        addSubview(fieldPositionLabel)
                
        NSLayoutConstraint.activate([
            
            fieldPositionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            fieldPositionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            fieldPositionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            fieldPositionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- MatchPlayerDetailView View
class MatchPlayerDetailView: UIView {
    
    var player: Player? {
        didSet {
            guard let player = player else {return}
            playerName.text = player.name
            playerNumber.text = String(player.number)
            playerName.layer.slideInLabelAnimation(duration: 0.7)
        }
    }
    
    var playerNumberSize: CGFloat = 34
    
    let playerName: UILabel = {
        let label = UILabel()
        label.text = "Player"
        if #available(iOS 13, *){
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 1
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    let playerNumber: UILabel = {
        let label = UILabel()
        if #available(iOS 13, *){
            label.textColor = .secondaryLabel // TESTING
        } else {
            label.textColor = .white
        }
        label.textAlignment = .center
        label.text = String(99)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
//        label.layer.cornerRadius = 18
        if #available(iOS 13, *){
            label.backgroundColor = .systemGray3
        } else {
         label.backgroundColor = .black
        }
        return label
    }()
    
    let separator: UIView = {
        let view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .separator
        } else {
            view.backgroundColor = .gray
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMatchPlayerDetailView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpMatchPlayerDetailView() {
        if #available(iOS 13, *){
            backgroundColor = .systemGray3
        } else {
            backgroundColor = .white
        }
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(playerName)
        addSubview(playerNumber)
        addSubview(separator)
        
        NSLayoutConstraint.activate([
            
            playerNumber.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerNumber.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            playerNumber.widthAnchor.constraint(equalToConstant: playerNumberSize),
            playerNumber.heightAnchor.constraint(equalToConstant: playerNumberSize),
            
            playerName.leadingAnchor.constraint(equalTo: playerNumber.trailingAnchor, constant: 4),
            playerName.topAnchor.constraint(equalTo: topAnchor),
            playerName.bottomAnchor.constraint(equalTo: playerNumber.bottomAnchor),
//            playerName.centerYAnchor.constraint(equalTo: centerYAnchor),
            playerName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            
            separator.widthAnchor.constraint(equalToConstant: 1),
            separator.heightAnchor.constraint(equalToConstant: 24),
            separator.trailingAnchor.constraint(equalTo: playerNumber.trailingAnchor, constant: -2),
            separator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}
