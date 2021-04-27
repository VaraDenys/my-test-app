//
//  DetailScrollView.swift
//  my-test-app
//
//  Created by Deny Vorko on 23.04.2021.
//

import UIKit

class DetailScrollView: ScrollView {
    
    // MARK: - Private properties
    
    private lazy var imageView = UIImageView()
    var minScale: CGFloat = .zero
    
    // MARK: - Override func
    
    override func setupConstraints() {
        super.setupConstraints()
        
        addSubview(imageView)
        imageView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    override func setupView() {
        super.setupView()
        
        delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isZooming, zoomScale == minScale {
            self.setCurrentScale(imageSize: imageView.image?.size ?? .zero)
        }
        centerImageView()
    }
    
    //  MARK: - Private func
    
    private func setCurrentScale(imageSize: CGSize) {
        let widht = imageSize.width
        let heigh = imageSize.height
        let boundsSize = UIScreen.main.bounds.size
        
        let xScale = boundsSize.width / widht
        let yScale = boundsSize.height / heigh
        let minScale = min(xScale, yScale)
        
        self.minScale = minScale
        minimumZoomScale = minScale
        maximumZoomScale = minScale * 5
        zoomScale = minScale
    }
    
    private func centerImageView() {
        let boundsSize = bounds.size
        var frameToCenter = imageView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        imageView.frame = frameToCenter
    }
    
    // MARK: - Public func
    
    public func configure(image: UIImage) {
        self.imageView.image = image
        self.setCurrentScale(imageSize: image.size)
    }
}

// MARK: - Extension

extension DetailScrollView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
