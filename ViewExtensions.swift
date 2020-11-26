//
//  ViewExtensions.swift
//  Matchday
//
//  Created by Lachy Pound on 23/9/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func provideBackgroundColour () -> UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    func provideSecondaryBackgroundColour() -> UIColor {
        if #available(iOS 13.0, *) {
            return .secondarySystemBackground
        } else {
            return .gray
        }
    }
    func provideLabelColour() -> UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
    func provideTertiaryLabelColour() -> UIColor {
        if #available(iOS 13.0, *) {
            return .tertiaryLabel
        } else {
            return .black
        }
    }
    func provideSecondaryLabelColour() -> UIColor {
        if #available(iOS 13.0, *) {
            return .secondaryLabel
        } else {
            return .black
        }
    }
    func provideColour() -> UIColor {
        if #available(iOS 13.0, *) {
            return .tertiaryLabel
        } else {
            return .black
        }
    }
}

extension UITableView {
    func insetStyle() -> UITableView.Style {
        if #available(iOS 13.0, *) {
            return UITableView.Style.insetGrouped
        } else {
            return UITableView.Style.grouped
        }
    }
}
