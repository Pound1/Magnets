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
//            dateLabel.text = dateString
            
//            homeTeamLabel.text = record?.teamRecord?.teamLabel
//            opponentTeamLabel.text = record?.teamRecord?.opponentLabel
        }
    }
    
    let detail1: MatchValues = {
        let detail = MatchValues()
        detail.label.text = "Date"
        detail.value.text = "8/8/20"
        return detail
    }()
    
    let detail2: MatchValues = {
        let detail = MatchValues()
        detail.label.text = "Mins"
        detail.value.text = "2:10"
        return detail
    }()
    
    let detail3: MatchValues = {
        let detail = MatchValues()
        detail.label.text = "EFC Score"
        detail.value.text = "4.5 (45)"
        return detail
    }()
    
    let detail4: MatchValues = {
        let detail = MatchValues()
        detail.label.text = "AFC Score"
        detail.value.text = "4.5 (45)"
        return detail
    }()
    
    lazy var stackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [cellTitle, scoreTeam, scoreOpponent, quarterLength])
        let stack = UIStackView(arrangedSubviews: [detail1, detail2, detail3, detail4])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
//        stack.backgroundColor = .purple
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        backgroundColor = UIColor.clear
        
        addSubview(stackView)
        
//        addSubview(homeTeamLabel)
//        addSubview(opponentTeamLabel)
//        addSubview(homeLabel)
//        addSubview(opponentLabel)
//        addSubview(versusLabel)
//        addSubview(separator)
//        addSubview(dateLabel)
//        addSubview(lengthLabel)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            
//            dateLabel.centerXAnchor.constraint(equalTo: dateValue.centerXAnchor),
//            dateLabel.topAnchor.constraint(equalTo: dateValue.bottomAnchor, constant: -4),
//
//            lengthLabel.centerXAnchor.constraint(equalTo: lengthValue.centerXAnchor),
//            lengthLabel.topAnchor.constraint(equalTo: lengthValue.bottomAnchor, constant: -16),
            
        
//        homeTeamLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
//        homeTeamLabel.bottomAnchor.constraint(equalTo: homeLabel.topAnchor),
//        homeTeamLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3, constant: 0),
//
//        opponentTeamLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
//        opponentTeamLabel.bottomAnchor.constraint(equalTo: opponentLabel.topAnchor),
//        opponentTeamLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3, constant: 0),
//
//        homeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
//        homeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
//        homeLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3, constant: 0),
//
//        opponentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
//        opponentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
//        opponentLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3, constant: 0),
//
//        versusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//        versusLabel.bottomAnchor.constraint(equalTo: homeLabel.topAnchor),
        
//        separator.leadingAnchor.constraint(equalTo: leadingAnchor),
//        separator.trailingAnchor.constraint(equalTo: trailingAnchor),
//        separator.heightAnchor.constraint(equalToConstant: 1),
//        separator.bottomAnchor.constraint(equalTo: bottomAnchor),
        
//            dateLabel.topAnchor.constraint(equalTo: versusLabel.bottomAnchor, constant: 4),
//        dateLabel.centerXAnchor.constraint(equalTo: versusLabel.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MatchValues: UIView {
    
    var value: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Value 3"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.textColor = .white
        return label
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "title 3"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightText
//        label.backgroundColor = .magenta
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView() {
        addSubview(value)
        addSubview(label)
        NSLayoutConstraint.activate([
        
            value.centerXAnchor.constraint(equalTo: centerXAnchor),
            value.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: value.bottomAnchor)
        
        ])
    }
    
    func setColorLayoutToDark() {
        label.textColor = .gray
        value.textColor = .gray
    }
    
    func shrinkLabelSizesTo(labelSize: CGFloat, valueSize: CGFloat) {
        label.font = UIFont.systemFont(ofSize: labelSize)
        value.font = UIFont.systemFont(ofSize: valueSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
