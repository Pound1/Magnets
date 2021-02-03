//
//  ScorePageVC.swift
//  Matchday
//
//  Created by Lachy Pound on 22/12/20.
//  Copyright © 2020 Lachy Pound. All rights reserved.
//

import UIKit

class RotationsPageVC: UIViewController {
    
    let footerID = "footerID"
    var rotationsList = [RotationData]()
    let cellID = "cellID"
    let rotationImage: UIImageView = {
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
//        collectionView.register(AddToFieldCell.self, forCellWithReuseIdentifier: footerID)
        collectionView.register(ControlBookFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
    }
    
    private func setUpView() {
        view.backgroundColor = view.provideBackgroundColour()
        view.addSubview(rotationImage)
        view.addSubview(controllerPageTitle)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RotationsViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
//            clockImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rotationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rotationImage.widthAnchor.constraint(equalToConstant: 30),
            rotationImage.heightAnchor.constraint(equalToConstant: 30),
            rotationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            controllerPageTitle.leadingAnchor.constraint(equalTo: rotationImage.trailingAnchor, constant: 20),
            controllerPageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            controllerPageTitle.centerYAnchor.constraint(equalTo: rotationImage.centerYAnchor),
            controllerPageTitle.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: rotationImage.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
}

extension RotationsPageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rotationsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RotationsViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath) as! ControlBookFooterView
        return footer
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return rotationsList.isEmpty == true ? CGSize(width: view.frame.width, height: 150) : CGSize(width: 0, height: 0)
    }
}

extension RotationsPageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
}

extension RotationsPageVC: UICollectionViewDelegate {
    
}



class ControlBookFooterView: UICollectionViewCell {
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Rotations were recorded for this quarter."
        label.text = "Under Construction"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .gray
        return label
    }()
    let subText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rotations are coming soon. If you would like to see this feature sooner, please tap the YES button."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .gray
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpFooter()
    }
    private func setUpFooter() {
        addSubview(title)
        addSubview(subText)
        NSLayoutConstraint.activate([
//            title.centerXAnchor.constraint(equalTo: centerXAnchor),
//            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
//            title.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            title.bottomAnchor.constraint(equalTo: centerYAnchor),
            
            subText.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subText.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            subText.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
            subText.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
