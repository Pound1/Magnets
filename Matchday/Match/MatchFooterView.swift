////
////  MatchFooterView.swift
////  Matchday
////
////  Created by Lachy Pound on 15/10/19.
////  Copyright © 2019 Lachy Pound. All rights reserved.
////
//
//import UIKit
//
//
//class MatchFooterView: UICollectionViewCell {
//    
//    let footerTitle: UILabel = {
//        let title = UILabel()
//        title.text = "No players available."
//        title.textColor = .white
//        title.textAlignment = .center
//        title.font = UIFont.boldSystemFont(ofSize: 22)
//        title.translatesAutoresizingMaskIntoConstraints = false
//        return title
//    }()
//    
//    let footerSubText: UILabel = {
//        let subText = UILabel()
//        subText.text = "Add players to the list by tapping the Add button."
//        subText.textColor = .white
//        subText.textAlignment = .center
//        subText.translatesAutoresizingMaskIntoConstraints = false
//        return subText
//    }()
//    
//    override init(frame: CGRect){
//        super.init(frame:frame)
//        
//        backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
//        addSubview(footerTitle)
//        addSubview(footerSubText)
//        
//        setUpSubviews()
//    }
//    
//    private func setUpSubviews(){
//        NSLayoutConstraint.activate([
//            footerTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
//            footerTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
//            footerTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
//            
//            footerSubText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            footerSubText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//            footerSubText.topAnchor.constraint(equalTo: footerTitle.bottomAnchor, constant: 8)
//            ])
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
