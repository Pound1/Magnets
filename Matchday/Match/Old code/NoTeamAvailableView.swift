//
//  NoTeamAvailableView.swift
//  Matchday
//
//  Created by Lachy Pound on 30/10/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit
// NOT USED ANYMORE
class NoTeamAvailableView: UIView {
    
    let footerView: FooterView = {
        let footer = FooterView()
        footer.footerTitle.text = "Set Up Required"
        footer.footerSubText.text = "Tap Manage to set up the field."
        footer.translatesAutoresizingMaskIntoConstraints = false
        return footer
    }()
    
    //MARK:- Required initialiser methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
        addSubview(footerView)
        NSLayoutConstraint.activate([
            footerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            footerView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
}
