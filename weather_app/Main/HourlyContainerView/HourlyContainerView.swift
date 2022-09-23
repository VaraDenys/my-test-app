//
//  HourlyContainerView.swift
//  weather_app
//
//  Created by Deny Vorko on 23.09.2022.
//

import Foundation
import UIKit

class HourlyContainerView: UIView {
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .appBackground
        self.collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionViewLayout.scrollDirection = .horizontal
    }
}

extension HourlyContainerView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HourlyCellInfo.mock.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HourlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = HourlyCellInfo.mock[indexPath.row]
        cell.configure(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width / 5
        let height: CGFloat = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}
