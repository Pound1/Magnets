//
//  OnboardingView.swift
//  Matchday
//
//  Created by Lachy Pound on 11/3/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class OnboardingView: UIView {
    
    var delegate: MatchCollectionViewControllerDelegate?
    // define views
    let firstView: OnboardingSubView = {
        let view = OnboardingSubView()
        view.textLabel.text = "To start organising the field, tap a player."
        view.imageView.image = UIImage(imageLiteralResourceName: "HighlightedPlayerImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let secondView: OnboardingSubView = {
        let view = OnboardingSubView()
        view.textLabel.text = "Move the player by tapping on a second player or an empty position."
        view.imageView.image = UIImage(imageLiteralResourceName: "VacantPositionImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thirdView: OnboardingSubView = {
        let view = OnboardingSubView()
        view.textLabel.text = "Tap play to begin the quarter."
        view.imageView.image = UIImage(imageLiteralResourceName: "PlayButtonImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // set up the view contents
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    private func setUpView() {
        backgroundColor = UIColor(white: 0, alpha: 0.6)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        addSubview(firstView)
        addSubview(secondView)
        addSubview(thirdView)
        let viewWidth = frame.width*(7/8)
        let viewHeight = frame.height*(1/8)
        let viewPositionalSpacing = frame.height/10
        print("Width: \(viewWidth), Height: \(viewHeight)")
        NSLayoutConstraint.activate([
            firstView.centerXAnchor.constraint(equalTo: centerXAnchor),
            firstView.topAnchor.constraint(equalTo: topAnchor, constant: viewPositionalSpacing),
            firstView.widthAnchor.constraint(equalToConstant: viewWidth),
            firstView.heightAnchor.constraint(equalToConstant: viewHeight),
            
            secondView.centerXAnchor.constraint(equalTo: centerXAnchor),
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: viewPositionalSpacing),
            secondView.widthAnchor.constraint(equalToConstant: viewWidth),
            secondView.heightAnchor.constraint(equalToConstant: viewHeight),

            thirdView.centerXAnchor.constraint(equalTo: centerXAnchor),
            thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: viewPositionalSpacing),
            thirdView.widthAnchor.constraint(equalToConstant: viewWidth),
            thirdView.heightAnchor.constraint(equalToConstant: viewHeight),
        ])
    }
    
    @objc private func handleTap() {
        print("Tapped view")
        delegate?.removeView(view: self)
    }
    
    func animateViewsIn() {
        print("Animating...")
        firstView.transform = CGAffineTransform(translationX: frame.width, y: 0)
        secondView.transform = CGAffineTransform(translationX: frame.width, y: 0)
        thirdView.transform = CGAffineTransform(translationX: frame.width, y: 0)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.firstView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.secondView.transform = CGAffineTransform(translationX: 0, y: 0)
            }) { (_) in
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    self.thirdView.transform = CGAffineTransform(translationX: 0, y: 0)
                })
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OnboardingSubView: UIView {
    
    let backgroundView:UIView = {
        let view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .tertiarySystemBackground
        } else {
            view.backgroundColor = .white
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let textLabel:UILabel = {
        let label = UILabel()
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.font = label.font.withSize(14)
        label.text = "Label"
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpSubView()
    }
    
    func setUpSubView() {
        addSubview(backgroundView)
        addSubview(imageView)
        addSubview(textLabel)
        
        let padding = CGFloat(16)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
//            imageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0.1),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            textLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
