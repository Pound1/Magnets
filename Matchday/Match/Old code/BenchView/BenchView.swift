//
//  BenchView.swift
//  Matchday
//
//  Created by Lachy Pound on 6/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

class BenchView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let benchCell = "benchCellID"
    let benchHeaderID = "benchHeaderID"
    var players = [Player]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setUpBenchView()
        fetchPlayingGroupData()
        register(BenchCell.self, forCellWithReuseIdentifier: benchCell)
        register(MatchFieldPositionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: benchHeaderID)
    }
    
    func fetchPlayingGroupData(){
//            Service.shared.fetchPlayersFromServer()
//            players = Service.shared.getPlayersObtainedFromServer()
//            reloadData()
    }
    
    func setUpBenchView() {
        backgroundColor = UIColor.PaletteColour.BlueGray.secondaryDarkColor
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
