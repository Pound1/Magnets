//
//  ColorExtensions.swift
//  Matchday
//
//  Created by Lachy Pound on 18/7/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    struct PaletteColour {
        struct Green {
            static let darkLeaves = UIColor(displayP3Red: 80/255, green: 109/255, blue: 47/255, alpha: 1) //LEAVES
            static let lightLeaves = UIColor(displayP3Red: 107/255, green: 168/255, blue: 106/255, alpha: 1)
            static let lGreen = UIColor(displayP3Red: 147/255, green: 208/255, blue: 146/255, alpha: 1)
            static let primaryColor = UIColor(red: 0.30, green: 0.69, blue: 0.31, alpha: 1.0);
            static let primaryLightColor = UIColor(red: 0.50, green: 0.89, blue: 0.49, alpha: 1.0);
            static let primaryDarkColor = UIColor(red: 0.03, green: 0.50, blue: 0.14, alpha: 1.0);
            
            //Palette Oct 18 2020
            static let softGreen = UIColor(displayP3Red: 200/255, green: 242/255, blue: 207/255, alpha: 1)
            static let lightGreen = UIColor(displayP3Red: 0/255, green: 224/255, blue: 127/255, alpha: 1)
            static let darkGreen = UIColor(displayP3Red: 7/255, green: 64/255, blue: 21/255, alpha: 1)
        }
        struct Red {
            static let primaryRed = UIColor(displayP3Red: 237/255, green: 85/255, blue: 59/255, alpha: 1)
        }
        
        struct White {
            static let marble = UIColor(displayP3Red: 243/255, green: 235/255, blue: 221/255, alpha: 1) // MARBLE
        }
        
        struct Brown {
            static let bark = UIColor(displayP3Red: 42/255, green: 41/255, blue: 34/255, alpha: 1) // BARK
            static let brownstone = UIColor(displayP3Red: 125/255, green: 86/255, blue: 66/255, alpha: 1) // BROWNSTONE
        }
        
        struct BlueGray {
            static let secondaryColor = UIColor(red: 0.38, green: 0.49, blue: 0.55, alpha: 1.0);
            static let secondaryLightColor = UIColor(red: 0.56, green: 0.67, blue: 0.73, alpha: 1.0);
            static let secondaryDarkColor = UIColor(red: 0.20, green: 0.32, blue: 0.37, alpha: 1.0);
        }
        
        struct SelectionTones {
            static let hyperlinkBlue = UIColor(red: 6/255, green: 69/255, blue: 173/255, alpha: 1.0)
            static let slightGrey = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1.0)
        }
    }
}
