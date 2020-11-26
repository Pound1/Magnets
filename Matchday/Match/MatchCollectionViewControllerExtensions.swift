//
//  MatchCollectionViewControllerExtensions.swift
//  Matchday
//
//  Created by Lachy Pound on 14/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

extension MatchCollectionViewController {
    func getFieldPositionLabel(index: IndexPath) -> String {
        switch index.section {
        case 0:
            switch index.row {
            case 0:
                return "POCKET"
            case 1:
                return "FULL BACK"
            case 2:
                return "POCKET"
            case 3:
                return "FLANK"
            case 4:
                return "CENTRE HALF"
            case 5:
                return "FLANK"
            default:
                return "forward"
            }
        case 1:
            switch index.row {
            case 0:
                return "WING"
            case 1:
                return "CENTRE"
            case 2:
                return "WING"
            case 3:
                return "ROVER"
            case 4:
                return "RUCK ROVER"
            case 5:
                return "RUCK"
            default:
                return "mid"
            }
            
        case 2:
            switch index.row {
            case 0:
                return "FLANK"
            case 1:
                return "CENTRE HALF"
            case 2:
                return "FLANK"
            case 3:
                return "POCKET"
            case 4:
                return "FULL FORWARD"
            case 5:
                return "POCKET"
            default:
                return "back"
            }
        default:
            return "Bench"
        }
    }
    
    func getFieldPositionLabelForRotation(index: IndexPath) -> String {
        switch index.section {
        case 0:
            switch index.row {
            case 0:
                return "Back Pocket"
            case 1:
                return "Full Back"
            case 2:
                return "Back Pocket"
            case 3:
                return "Back Flank"
            case 4:
                return "Centre Half Back"
            case 5:
                return "Back Flank"
            default:
                return "back"
            }
        case 1:
            switch index.row {
            case 0:
                return "Wing"
            case 1:
                return "Centre"
            case 2:
                return "Wing"
            case 3:
                return "Rover"
            case 4:
                return "Ruck Rover"
            case 5:
                return "Ruck"
            default:
                return "mid"
            }
            
        case 2:
            switch index.row {
            case 0:
                return "Forward Flank"
            case 1:
                return "Centre Half Forward"
            case 2:
                return "Forward Flank"
            case 3:
                return "Forward Pocket"
            case 4:
                return "Full Forward"
            case 5:
                return "Forward Pocket"
            default:
                return "forward"
            }
        default:
            return "Bench"
        }
    }
}
