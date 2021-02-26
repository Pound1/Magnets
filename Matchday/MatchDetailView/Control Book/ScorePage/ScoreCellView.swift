//
//  ScoreCellView.swift
//  Matchday
//
//  Created by Lachy Pound on 25/2/21.
//  Copyright © 2021 Lachy Pound. All rights reserved.
//

import UIKit

class ScoreCellView: UITableViewCell {
    var score: Score? {
        didSet{
            setCellValues()
        }
    }
    var statisticName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AFC"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 2
        return label
    }()
    var goalScoreView: StatIncrementerView = {
        let view = StatIncrementerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.type = statisticType.goal
        return view
    }()
    var pointScoreView: StatIncrementerView = {
        let view = StatIncrementerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.type = statisticType.point
        return view
    }()
    var totalScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "131"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [goalScoreView, pointScoreView, totalScoreLabel])
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
        goalScoreView.delegate = self
        pointScoreView.delegate = self
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
            
            goalScoreView.topAnchor.constraint(equalTo: statisticName.topAnchor),
            goalScoreView.bottomAnchor.constraint(equalTo: goalScoreView.bottomAnchor),
            pointScoreView.topAnchor.constraint(equalTo: goalScoreView.topAnchor),
            pointScoreView.bottomAnchor.constraint(equalTo: goalScoreView.bottomAnchor),
            totalScoreLabel.topAnchor.constraint(equalTo: goalScoreView.topAnchor),
            totalScoreLabel.bottomAnchor.constraint(equalTo: goalScoreView.bottomAnchor),
        ])
    }
    
    private func setCellValues(){
        guard let score = score else {return}
        statisticName.text = score.teamName
        let goalTally = Int(score.goalTally)
        let pointTally = Int(score.pointTally)
        
        goalScoreView.statValue = goalTally
        pointScoreView.statValue = pointTally
        
        let totalScore = (6*goalTally) + pointTally
        totalScoreLabel.text = String(totalScore)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ScoreCellView: IncrementAndDecrementDelegate {
    func decrement(type: statisticType) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        switch type {
        case statisticType.goal:
            print("Dec", type)
            score?.goalTally -= 1
        case statisticType.point:
            print("dec", type)
            score?.pointTally -= 1
        default:
            print("Couldn't decrement score.")
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
        case statisticType.goal:
            print("Incrementing", type)
            score?.goalTally += 1
        case statisticType.point:
            print("Incrementing", type)
            score?.pointTally += 1
        default:
            print("Couldn't increment score.")
        }
        setCellValues()
        do {
            try context.save()
        } catch let err {
            print("Couldn't increment with error: ", err)
        }
    }
}
