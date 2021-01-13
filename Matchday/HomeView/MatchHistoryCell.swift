//
//  MatchCell.swift
//  Matchday
//
//  Created by Lachy Pound on 23/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class MatchHistoryCell: UITableViewCell {
    
    var match = Match() {
        didSet {
            statusLabel.text = match.status
            statusLabel.applyColourScheme()
            titleLabel.text = "\(match.homeTeam ?? "Home ") v \(match.awayTeam ?? "Away")"
            locationLabel.text = match.location
            
            
            resultLabel.text = match.result
            if statusLabel.text != matchStatus.complete.rawValue {
                resultLabel.removeFromSuperview()
                homeResult.label.text = ""
                homeResult.value.text = ""
                awayResult.label.text = ""
                awayResult.value.text = ""
            }
            // display date
            if let date = match.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM, dd, yyyy"
                let dateString = dateFormatter.string(from: date)
                dateLabel.text = dateString
            }
        }
    }
    
    let statusLabel: StatusLabel = {
        let label = StatusLabel()
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GEFC v AFC"
//        label.backgroundColor = .purple
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "at ground location"
//        label.backgroundColor = .brown
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "7/8/20"
//        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.PaletteColour.Green.darkGreen
        label.text = "Result"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.PaletteColour.Green.darkGreen.cgColor
        label.layer.borderWidth = 2
        label.layer.masksToBounds = true
        return label
    }()
    
    let homeResult: MatchValues = {
        let detail = MatchValues()
        detail.label.text = "7.6 (42)"
        detail.value.text = "AFC"
        detail.setColorLayoutToDark()
        detail.shrinkLabelSizesTo(labelSize: 10, valueSize: 12)
        return detail
    }()
    
    let awayResult: MatchValues = {
        let detail = MatchValues()
        detail.label.text = "8.8 (50)"
        detail.value.text = "GEFC"
        detail.setColorLayoutToDark()
        detail.shrinkLabelSizesTo(labelSize: 10, valueSize: 12)
        detail.label.font = UIFont.boldSystemFont(ofSize: 12)
        return detail
    }()
    
    lazy var scoreStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [homeResult, awayResult])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, locationLabel, dateLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.backgroundColor = .cyan
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.setCustomSpacing(0, after: titleLabel)
        stack.setCustomSpacing(0, after: locationLabel)
        stack.setCustomSpacing(2, after: dateLabel)
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setUpCellElements()
    }
    
    private func setUpCellElements(){
        backgroundColor = provideBackgroundColour()
        
        addSubview(statusLabel)
        addSubview(infoStack)
        addSubview(scoreStack)
        
        let thirdScreenWidth = frame.width/3
        NSLayoutConstraint.activate([
            
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statusLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
            statusLabel.widthAnchor.constraint(equalToConstant: 60),
            
            infoStack.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: scoreStack.leadingAnchor),
            infoStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                        
            scoreStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            scoreStack.widthAnchor.constraint(equalToConstant: thirdScreenWidth),
            scoreStack.heightAnchor.constraint(equalToConstant: 100),
            scoreStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
        showResultLabel()
    }
    
    private func showResultLabel() {
        if resultLabel.text != nil {
            infoStack.addArrangedSubview(resultLabel)
            NSLayoutConstraint.activate([
                resultLabel.widthAnchor.constraint(equalToConstant: 66),
                resultLabel.heightAnchor.constraint(equalToConstant: 20),
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
