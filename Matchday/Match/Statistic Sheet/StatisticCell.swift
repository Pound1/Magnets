//
//  StatisticCell.swift
//  Matchday
//
//  Created by Lachy Pound on 12/9/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class StatisticCell: UITableViewCell {
    
    var delegate: StatisticSheetControllerDelegate?
    var statistic = Statistic(label: "Stat", value: 0) {
        didSet{
            statisticLabel.text = statistic.label
            statisticValue.text = String(statistic.value)
        }
    }
    
    let statisticValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    let statisticLabel: UILabel = {
        let label = UILabel()
        label.text = "Stat"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.backgroundColor = UIColor.PaletteColour.Green.darkLeaves
        button.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    lazy var subtractButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("-", for: .normal)
        button.backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
        button.addTarget(self, action: #selector(handleSubtractButton), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    func setUpStatCell(){
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
        }
        
        addSubview(statisticValue)
        addSubview(statisticLabel)
        addSubview(addButton)
        addSubview(subtractButton)
        
        let thirdOfRowHeight = frame.height/3
        let fifthOfRowWidth = frame.width/5
        
        NSLayoutConstraint.activate([
            
            statisticValue.topAnchor.constraint(equalTo: topAnchor),
            statisticValue.centerXAnchor.constraint(equalTo: centerXAnchor),
            statisticValue.heightAnchor.constraint(equalToConstant: thirdOfRowHeight*2),
            
            statisticLabel.topAnchor.constraint(equalTo: statisticValue.bottomAnchor),
            statisticLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            statisticLabel.heightAnchor.constraint(equalToConstant: thirdOfRowHeight),
            statisticLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            addButton.widthAnchor.constraint(equalToConstant: fifthOfRowWidth),
            
            subtractButton.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            subtractButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            subtractButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            subtractButton.widthAnchor.constraint(equalToConstant: fifthOfRowWidth)
            
            ])
    }
    
    @objc func handleAddButton() {
        statistic.value += 1
        delegate?.updateRecord(statistic: statistic)
    }
    
    @objc func handleSubtractButton() {
        if statistic.value > 0 {
            statistic.value -= 1
            delegate?.updateRecord(statistic: statistic)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpStatCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateRecord2(statistic: Statistic){
        
    }
    
}
