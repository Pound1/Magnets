//
//  FooterView.swift
//  Matchday
//
//  Created by Lachy Pound on 12/9/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    let footerTitle: UILabel = {
        let title = UILabel()
        title.text = "No players available."
        if #available(iOS 13.0, *) {
            title.textColor = .label
        } else {
            title.textColor = .white
        }
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 22)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let footerSubText: UILabel = {
        let subText = UILabel()
        subText.text = "Add players to the list by tapping the + button."
        if #available(iOS 13.0, *) {
            subText.textColor = .label
        } else {
            subText.textColor = .white
        }
        subText.textAlignment = .center
        subText.numberOfLines = 2
        subText.translatesAutoresizingMaskIntoConstraints = false
        return subText
    }()
    
    public override init(frame: CGRect){
        super.init(frame:frame)
        backgroundColor = UIColor(white: 1, alpha: 0)
        addSubview(footerTitle)
        addSubview(footerSubText)
        
        setUpSubviews()
    }
    
    private func setUpSubviews(){
        NSLayoutConstraint.activate([
            footerTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerTitle.topAnchor.constraint(equalTo: topAnchor, constant: 48),
            
            footerSubText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            footerSubText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            footerSubText.topAnchor.constraint(equalTo: footerTitle.bottomAnchor, constant: 8)
            ])
    }
    
    func adjustFooterText (title: String, subText: String) {
        footerTitle.text = title
        footerSubText.text = subText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
