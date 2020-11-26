//
//  PlayingFieldCell.swift
//  Matchday
//
//  Created by Lachy Pound on 4/2/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class PlayingFieldCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        matchPlayerDetailView.center = self.center
        setUpPositionCell()
    }
    
    let fieldPositionLabel: UILabel = {
        let label = UILabel()
        var fieldPositionText = "Flank"
        label.textAlignment = .center
        if #available(iOS 13, *) {
            label.textColor = .systemGray2
        } else {
            label.textColor = .lightGray
        }
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = fieldPositionText.uppercased()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let matchPlayerDetailView: MatchPlayerDetailView = {
        let detailView = MatchPlayerDetailView()
        detailView.clipsToBounds = true
        detailView.layer.cornerRadius = 12
        return detailView
    }()
    
    let addPlayerButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+"
        if #available(iOS 13, *) {
            label.textColor = .label
        } else {
            label.textColor = .white
        }
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                // selection colours
                if #available(iOS 13, *){
                    addPlayerButton.textColor = .systemGray5
                } else {
                    addPlayerButton.textColor = UIColor.PaletteColour.Green.lightGreen
                }
                if #available(iOS 13, *){
                    layer.shadowColor = UIColor.label.cgColor
                } else {
                    layer.shadowColor = UIColor.black.cgColor
                }
                layer.shadowRadius = 8 // distance away from source
                layer.shadowOpacity = 0.8 // amount of shadow; intensity
                layer.shadowOffset = CGSize(width: 0, height: 0)
            } else {
                if #available(iOS 13, *){
                    addPlayerButton.textColor = .label
                } else {
                    addPlayerButton.textColor = .white
                }
                layer.shadowRadius = 0 // removes the shadow.
            }
        }
    }
    
    private func setUpPositionCell(){
        layer.cornerRadius = 5
        setUpFieldPositionLabel()
        setUpPlayerDetail()
        setUpAddButton()
    }
    
    fileprivate func setUpFieldPositionLabel() {
        addSubview(fieldPositionLabel)
                
        NSLayoutConstraint.activate([
            fieldPositionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            fieldPositionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            fieldPositionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            fieldPositionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
            ])
    }
    
    fileprivate func setUpAddButton() {
        addSubview(addPlayerButton)
        let height = (frame.height)*2/3
        
        NSLayoutConstraint.activate([
            addPlayerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addPlayerButton.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    fileprivate func setUpPlayerDetail() {
        addSubview(matchPlayerDetailView)

        NSLayoutConstraint.activate([
        matchPlayerDetailView.leadingAnchor.constraint(equalTo: leadingAnchor),
        matchPlayerDetailView.trailingAnchor.constraint(equalTo: trailingAnchor),
        matchPlayerDetailView.heightAnchor.constraint(equalToConstant: 44),
        matchPlayerDetailView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
//    func resizeCellWithAnimation(translation: CGFloat) { // this is the Cell translation animation
//        UIView.animate(withDuration: 0.1) {
//            self.matchPlayerDetailView.transform = self.matchPlayerDetailView.transform.translatedBy(x: 0, y: translation)
//
////                self.matchPlayerDetailView.transform.scaledBy(x: 2, y: 2)
//
////
//        }
//    }
    
//    func fadePlayerName() { // this was an attempt to fade the player names in and out
//        UIView.animate(withDuration: 1) {
//            self.matchPlayerDetailView.playerName.alpha = 0
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
