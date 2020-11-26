//
//  MatchControllerExtensions.swift
//  Matchday
//
//  Created by Lachy Pound on 5/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

extension MatchController {
    
    // STANDARD CELL METHODS
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: matchFieldCellID, for: indexPath) as! MatchFieldCell
            print("Player list is passed.")
            // setting the player List seems to be failing... Why?
            cell.players = players
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: benchFieldCellID, for: indexPath) as! BenchFieldCell
//            cell.players = players
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // set the section sizes
        let fieldFrameHeight = view.frame.height * (3/4)
        let benchFrameHeight = view.frame.height/7
        let frameWidth = view.frame.width
        return indexPath.section == 0 ? CGSize(width: frameWidth, height: fieldFrameHeight) : CGSize(width: frameWidth, height: benchFrameHeight)
    }
    
    // HEADER METHODS
    
}
