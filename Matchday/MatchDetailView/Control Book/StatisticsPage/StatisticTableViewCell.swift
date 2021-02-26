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
                setCellValues()
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
    var homeStatistic: StatIncrementerView = {
        let view = StatIncrementerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.type = statisticType.home
        return view
    }()
    var awayStatistic: StatIncrementerView = {
        let view = StatIncrementerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.type = statisticType.away
        return view
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
        let stack = UIStackView(arrangedSubviews: [homeStatistic, awayStatistic])
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
        homeStatistic.delegate = self
        awayStatistic.delegate = self
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
            
            homeStatistic.topAnchor.constraint(equalTo: statisticName.topAnchor),
            homeStatistic.bottomAnchor.constraint(equalTo: statisticName.bottomAnchor),
            awayStatistic.topAnchor.constraint(equalTo: statisticName.topAnchor),
            awayStatistic.bottomAnchor.constraint(equalTo: statisticName.bottomAnchor),
        ])
    }
    private func setCellValues() {
        guard let statisticData = statistic else {return}
        statisticName.text = statisticData.statisticName
//        homeValue.text = String(statisticData.teamValue)
//        awayValue.text = String(statisticData.opponentValue)
        homeStatistic.statValue = Int(statisticData.teamValue)
        awayStatistic.statValue = Int(statisticData.opponentValue)
        if statisticData.opponentValue > statisticData.teamValue {
            homeStatistic.statLabel.textColor = .lightGray
            awayStatistic.statLabel.textColor = .black
        } else if statisticData.opponentValue == statisticData.teamValue {
            homeStatistic.statLabel.textColor = .lightGray
            awayStatistic.statLabel.textColor = .lightGray
        } else {
            homeStatistic.statLabel.textColor = .black
            awayStatistic.statLabel.textColor = .lightGray
//            homeValue.textColor = .black
//            awayValue.textColor = .lightGray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatisticTableViewCell: IncrementAndDecrementDelegate {
    func decrement(type: statisticType) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        switch type {
        case statisticType.home:
            print("Dec", type)
            statistic?.teamValue -= 1
        case statisticType.away:
            print("dec", type)
            statistic?.opponentValue -= 1
        default:
            print("Couldn't decrement statistic.")
        }
        setCellValues()
        do {
            try context.save()
        } catch let err {
            print("Couldn't increment with error: ", err)
        }
    }
    
    func increment(type: statisticType) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        switch type {
        case statisticType.home:
            print("Incrementing", type)
            statistic?.teamValue += 1
        case statisticType.away:
            print("Incrementing", type)
            statistic?.opponentValue += 1
        default:
            print("Couldn't increment statistic.")
        }
        setCellValues()
        do {
            try context.save()
        } catch let err {
            print("Couldn't increment with error: ", err)
        }
    }
}
