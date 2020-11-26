//
//  MatchFieldPositionHeader.swift
//  Matchday
//
//  Created by Lachy Pound on 14/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

// this class creates the headers of the Match view.
class MatchFieldPositionHeader: UICollectionViewCell {
    
    var delegate: MatchCollectionViewControllerDelegate?
    
    var headerTitleLabel: UILabel = {
        var label = UILabel() {
            didSet {
                print("setting the header ...") // why does this not trigger??
            }
        }
        if #available(iOS 13, *){
            label.textColor = .label
        } else {
            label.textColor = .white
        }
        label.text = "Header"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .separator
        } else {
            view.backgroundColor = .white
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMatchFieldPositionHeader()
    }
    
    private func setUpMatchFieldPositionHeader(){
        addSubview(headerTitleLabel)
        addSubview(separatorLine)
        NSLayoutConstraint.activate([
            
            headerTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            headerTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            separatorLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    @objc func handleAddButtonAction(){
        print("this used to add more cells to the section...")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UILabel {
    func applyHeaderStyle() {
        addCharacterSpacing()
        if #available(iOS 13.0, *) {
            textColor = .label
        } else {
            textColor = .white
        }
//        font = UIFont.boldSystemFont(ofSize: 18)
        font = UIFont.systemFont(ofSize: 16)
    }
}
