//
//  PhotoHorizontalView.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/22.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import Photos

extension ImagesHorizontalViewCell {
    func loadWithAsset(asset : PHAsset,index : Int){
        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil) { (image, nfo) in
            self.zoomView.imageView.image = image
        }
        self.zoomView.index = index
    }
}

class PhotoHorizontalView: ImagesHorizontalView {

    var assetsFetchResults:PHFetchResult<PHAsset>?
    
    
    init(frame: CGRect,fetchResults:PHFetchResult<PHAsset>,index : Int) {
        super.init(frame : frame)
        self.assetsFetchResults = fetchResults
        self.addCollectionView()
        self.collectView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
    }
    
    override func cellLoadImage(cell:ImagesHorizontalViewCell,indexPath: IndexPath) {
        cell.loadWithAsset(asset: self.assetsFetchResults![indexPath.row], index: indexPath.row)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetsFetchResults?.count ?? 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tapClick(index: Int) {
    
    }
    
}
