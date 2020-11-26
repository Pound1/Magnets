//
//  QuarterCell.swift
//  Matchday
//
//  Created by Lachy Pound on 25/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class QuarterCell: UICollectionViewCell {
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cellTitle, scoreTeam, scoreOpponent, quarterLength])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    var cellTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Q1"
        label.textColor = label.provideLabelColour()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    let scoreTeam: CustomMatchDetailView = {
       let view = CustomMatchDetailView()
        view.detailLabel.text = "Team"
        view.valueLabel.text = "3.1(19)"
        view.adjustFontSize(size: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let scoreOpponent: CustomMatchDetailView = {
       let view = CustomMatchDetailView()
        view.detailLabel.text = "Opp."
        view.valueLabel.text = "2.3(15)"
        view.adjustFontSize(size: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let quarterLength: CustomMatchDetailView = {
       let view = CustomMatchDetailView()
        view.detailLabel.text = "Length"
        view.valueLabel.text = "28:15"
        view.adjustFontSize(size: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    
    private func setUpCell() {
        if #available(iOS 13.0, *) {
            backgroundColor = .systemGray4
        } else {
            backgroundColor = .gray
        }
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        let padding = CGFloat(8)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
