//
//  MatchCell.swift
//  Matchday
//
//  Created by Lachy Pound on 23/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class MatchHistoryCell: UITableViewCell {
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Status"
        label.backgroundColor = UIColor.PaletteColour.Grey.midGrey
        label.layer.cornerRadius = 4
        label.layer.borderColor = UIColor.PaletteColour.Orange.orangeHighlight.cgColor
        label.layer.borderWidth = 2
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment = .center
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "7/8/20"
//        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 14)
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
        label.layer.cornerRadius = 4
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
    
    lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [homeResult, awayResult])
        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.backgroundColor = .cyan
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setUpCellElements()
    }
    
    private func setUpCellElements(){
        backgroundColor = provideBackgroundColour()
        
        addSubview(statusLabel)
        addSubview(titleLabel)
        addSubview(locationLabel)
        addSubview(dateLabel)
        addSubview(resultLabel)
        addSubview(labelStack)
        
        let thirdScreenWidth = frame.width/3
        NSLayoutConstraint.activate([
            
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statusLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
            statusLabel.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: labelStack.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            titleLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor),

            locationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: labelStack.leadingAnchor),
//            locationLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),

            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: labelStack.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),

            resultLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            resultLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 2),
            resultLabel.widthAnchor.constraint(equalToConstant: 60),
            resultLabel.heightAnchor.constraint(equalToConstant: 20),
            
            labelStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            labelStack.widthAnchor.constraint(equalToConstant: thirdScreenWidth),
            labelStack.heightAnchor.constraint(equalToConstant: 100),
//            labelStack.centerYAnchor.constraint(equalTo: centerYAnchor),
//            labelStack.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -quarterScreenWidth),
            
        ])
//        showResultLabel()
    }
    
    private func showResultLabel() {
        if resultLabel.text != nil {
            addSubview(resultLabel)
            NSLayoutConstraint.activate([
                resultLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                resultLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
