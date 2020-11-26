//
//  MatchViewController.swift
//  Matchday
//
//  Created by Lachy Pound on 5/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class MatchView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    let playersInSectionCount = 6
    var playersOnField = [Player]()
    let playerCellID = "playerCellID"
    let matchFieldPositionHeader = "headerCellID"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setUpMatchView()
        register(PositionOnFieldCell.self, forCellWithReuseIdentifier: playerCellID)
        register(MatchFieldPositionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: matchFieldPositionHeader)
    }
    
    private func setUpMatchView() {
        backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



