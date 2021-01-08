//
//  ScorePageVC.swift
//  Matchday
//
//  Created by Lachy Pound on 22/12/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class RotationsPageVC: UIViewController {
    
    let cellID = "cellID"
    let clockImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(imageLiteralResourceName: "rotation_icon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.PaletteColour.Green.newGreen
        return imageView
    }()
    let controllerPageTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Rotations"
        title.textColor = UIColor.PaletteColour.Green.newGreen
        title.font = UIFont.boldSystemFont(ofSize: 22)
        return title
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = collectionView.provideBackgroundColour()
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        addConstraints()
    }
    
    private func setUpView() {
        view.backgroundColor = view.provideBackgroundColour()
        view.addSubview(clockImage)
        view.addSubview(controllerPageTitle)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RotationsViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
//            clockImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clockImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            clockImage.widthAnchor.constraint(equalToConstant: 30),
            clockImage.heightAnchor.constraint(equalToConstant: 30),
            clockImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            controllerPageTitle.leadingAnchor.constraint(equalTo: clockImage.trailingAnchor, constant: 20),
            controllerPageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            controllerPageTitle.centerYAnchor.constraint(equalTo: clockImage.centerYAnchor),
            controllerPageTitle.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: clockImage.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
}

extension RotationsPageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RotationsViewCell
        return cell
    }
}

extension RotationsPageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
}

extension RotationsPageVC: UICollectionViewDelegate {
    
}

class RotationsViewCell: UICollectionViewCell {
    
    let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(displayP3Red: 200/255, green: 199/255, blue: 204/255, alpha: 0.5)
        return view
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "12:45"
        label.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        label.textAlignment = .center
        return label
    }()
    let firstRotationInformation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(Player A) went from <the bench> to [forward flank]"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    let secondRotationInformation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(Player B) went from <forward flank> to [the bench]"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    private func setUpCell() {
        addSubview(timeLabel)
        addSubview(firstRotationInformation)
        addSubview(secondRotationInformation)
        addSubview(separator)
        layoutCellView()
    }
    private func layoutCellView() {
        let sectionOfWidth = frame.width/8
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: topAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: sectionOfWidth),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            firstRotationInformation.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            firstRotationInformation.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            firstRotationInformation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            secondRotationInformation.leadingAnchor.constraint(equalTo: firstRotationInformation.leadingAnchor),
            secondRotationInformation.topAnchor.constraint(equalTo: firstRotationInformation.bottomAnchor, constant: 2),
            secondRotationInformation.trailingAnchor.constraint(equalTo: firstRotationInformation.trailingAnchor),
            
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.topAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
