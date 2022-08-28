//
//  HeaderView.swift
//  weather_app
//
//  Created by Deny Vorko on 28.08.2022.
//

import Foundation
import UIKit

class HeaderView: UIView {
    private let infoHeaderView = InfoHeaderView()
    private let imageView = UIImageView(image: UIImage(named: "sunIcon"))
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .headerBackground
        self.layer.cornerRadius = 15
        
        self.addSubview(infoHeaderView)
        self.infoHeaderView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(20)
        }
        
        self.addSubview(imageView)
        self.imageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(30)
            $0.width.height.equalTo(75)
        }
        self.imageView.contentMode = .scaleAspectFill
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ValueCollectionViewCell.self, forCellWithReuseIdentifier: "valueCell")
        self.collectionViewLayout.minimumInteritemSpacing = 0
        self.collectionViewLayout.sectionInset.left = 0
        self.collectionViewLayout.sectionInset.right = 0
        self.collectionViewLayout.minimumLineSpacing = 0
        self.collectionView.backgroundColor = .clear
        
        self.addSubview(collectionView)
        self.collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }
    }
}

extension HeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HeaderWeatherInfo.someInfo().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "valueCell", for: indexPath) as? ValueCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = HeaderWeatherInfo.someInfo()[indexPath.row]
        cell.configure(info: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width / 2
        let height: CGFloat = collectionView.bounds.height / 2
        return CGSize(width: width, height: height)
    }
}
