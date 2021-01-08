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
    
    //MARK: private methods
    
    private func setUpCell() {
        backgroundColor = UIColor.PaletteColour.Green.monochromaticGreen
        applyLightShadow()
        layer.cornerRadius = 10
//        layer.masksToBounds = true
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
    func showSelectedCell() {
        if #available(iOS 13.0, *) {
            backgroundColor = UIColor.systemBackground
        } else {
            backgroundColor = .white
        }
        applyHeavyShadow()
    }
    
    func hideSelectedCell() {
        backgroundColor = UIColor.PaletteColour.Green.monochromaticGreen
        layer.borderWidth = 0
        applyLightShadow()
    }
    private func applyHeavyShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4 // distance away from source
        layer.shadowOpacity = 0.4 // amount of shadow; intensity
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    private func applyLightShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4 // distance away from source
        layer.shadowOpacity = 0.1 // amount of shadow; intensity
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
