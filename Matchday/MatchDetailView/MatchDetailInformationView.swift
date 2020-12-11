//
//  MatchDetailInformationView.swift
//  Matchday
//
//  Created by Lachy Pound on 10/12/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

//MARK: TeamStatSheet Header
class MatchDetailInformationView: UIView {
    
    var record: Record? {
        didSet {
            guard let date = record?.created else {return}
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM, dd, yyyy"
            let dateString = dateFormatter.string(from: date)
            dateLabel.text = dateString
            
            homeTeamLabel.text = record?.teamRecord?.teamLabel
            opponentTeamLabel.text = record?.teamRecord?.opponentLabel
        }
    }
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some date"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        if #available(iOS 13.0, *) {
            label.textColor = .tertiaryLabel
        } else {
            label.textColor = .lightGray
        }
        label.textColor = .lightText
        return label
    }()
    
    let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some home team"
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.textAlignment = .left
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.textColor = .white
        return label
    }()
    
    let opponentTeamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some opponent"
        label.textAlignment = .right
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.textColor = .white
        return label
    }()
    
    let homeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My team"
        label.font = UIFont.systemFont(ofSize: 16)
        if #available(iOS 13.0, *) {
            label.textColor = .tertiaryLabel
        } else {
            label.textColor = .black
        }
        label.textColor = .lightText
        return label
    }()
    
    let opponentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Opponent"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        if #available(iOS 13.0, *) {
            label.textColor = .tertiaryLabel
        } else {
            label.textColor = .black
        }
        label.textColor = .lightText
        return label
    }()
    
    let versusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "v"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        if #available(iOS 13.0, *) {
            label.textColor = .secondaryLabel
        } else {
            label.textColor = .black
        }
        label.textColor = .lightText
        return label
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            view.backgroundColor = .separator
        } else {
            view.backgroundColor = .black
        }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    private func setConstraints(){
        print("configuring contents")
        backgroundColor = UIColor.PaletteColour.Green.primaryDarkColor
        
        addSubview(homeTeamLabel)
        addSubview(opponentTeamLabel)
        addSubview(homeLabel)
        addSubview(opponentLabel)
        addSubview(versusLabel)
//        addSubview(separator)
        addSubview(dateLabel)
        NSLayoutConstraint.activate([
        
        homeTeamLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
        homeTeamLabel.bottomAnchor.constraint(equalTo: homeLabel.topAnchor),
        homeTeamLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3, constant: 0),
        
        opponentTeamLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
        opponentTeamLabel.bottomAnchor.constraint(equalTo: opponentLabel.topAnchor),
        opponentTeamLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3, constant: 0),
        
        homeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
        homeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
        homeLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3, constant: 0),
        
        opponentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
        opponentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
        opponentLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3, constant: 0),
        
        versusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        versusLabel.bottomAnchor.constraint(equalTo: homeLabel.topAnchor),
        
//        separator.leadingAnchor.constraint(equalTo: leadingAnchor),
//        separator.trailingAnchor.constraint(equalTo: trailingAnchor),
//        separator.heightAnchor.constraint(equalToConstant: 1),
//        separator.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            dateLabel.topAnchor.constraint(equalTo: versusLabel.bottomAnchor, constant: 4),
        dateLabel.centerXAnchor.constraint(equalTo: versusLabel.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
