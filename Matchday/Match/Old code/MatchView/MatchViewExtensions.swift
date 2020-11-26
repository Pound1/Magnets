//
//  MatchViewExtensions.swift
//  Matchday
//
//  Created by Lachy Pound on 5/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

extension MatchView {
    
    // STANDARD CELL METHODS
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playersInSectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: playerCellID, for: indexPath) as! FieldPositionCell
        if playersOnField.isEmpty {
            print("Empty player list. ")
            return cell
        } else {
        cell.matchPlayerDetailView.playerName.text = "Poundy"
            print(playersOnField[indexPath.row].name)
        cell.matchPlayerDetailView.playerNumber.text = String(playersOnField[indexPath.row].number)
        return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSize = ((self.frame.width-3)/3)
        return CGSize(width: widthSize, height: 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // HEADER METHODS
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 42)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: matchFieldPositionHeader, for: indexPath) as! MatchFieldPositionHeader
        return header
    }
    
}
