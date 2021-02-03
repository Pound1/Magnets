//
//  StatisticTableViewCell.swift
//  Matchday
//
//  Created by Lachy Pound on 5/1/21.
//  Copyright © 2021 Lachy Pound. All rights reserved.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {
    var statistic: TeamStatistic? {
        didSet{
            if let statisticData = statistic {
                statisticName.text = statisticData.statisticName
                homeValue.text = String(statisticData.teamValue)
                awayValue.text = String(statisticData.opponentValue)
                if statisticData.opponentValue > statisticData.teamValue {
                    homeValue.textColor = .lightGray
                    awayValue.textColor = .black
                } else {
                    homeValue.textColor = .black
                    awayValue.textColor = .lightGray
                }
            }
        }
    }
    var statisticName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Statistic 1"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 2
        return label
    }()
    var homeValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//        label.textColor = .
        label.textAlignment = .center
        return label
    }()
    var awayValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [homeValue, awayValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    private func setUpCell() {
        addSubview(statisticName)
        addSubview(stackView)
        layoutCell()
    }
    private func layoutCell() {
        NSLayoutConstraint.activate([
            statisticName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statisticName.trailingAnchor.constraint(equalTo: centerXAnchor),
            statisticName.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: statisticName.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: statisticName.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
