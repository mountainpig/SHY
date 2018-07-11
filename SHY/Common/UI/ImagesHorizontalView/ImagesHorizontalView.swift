//
//  ImagesHorizontalScrollView.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/5.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import SDWebImage

class ImagesHorizontalViewCell: UICollectionViewCell {
    var zoomView : ImageZoomScrollView = ImageZoomScrollView.init(frame: kScreenRect)
    func addCustomView(){
        self.addSubview(zoomView)
    }
    
    func loadWithModel(model : ImageModel,index : Int){
//        self.zoomView.imageView.sd_setImage(with: URL.init(string: model.bigUrlString!), completed: nil)
        self.zoomView.imageView.sd_setImage(with: URL.init(string: model.bigUrlString!), placeholderImage: SDImageCache.shared().imageFromCache(forKey: model.smallUrlString), options: SDWebImageOptions.retryFailed, completed: nil)
        self.zoomView.index = index
    }
}

class ImagesHorizontalView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,ImageZoomScrollViewProtocol {
    var collectView : UICollectionView! = nil;
    var listArray : Array! = [ImageModel]();
    var viewArray : Array! = [UIImageView]();
    var hiddenTapImge = false
    let backgroundView = UIView.init(frame: kScreenRect)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animationApear(array : Array<ImageModel>,index : Int,imageViewArray :Array<UIImageView>){
        self.listArray = array
        self.viewArray = imageViewArray
        self.collectView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        self.collectView.isHidden = true
        self.collectView.backgroundColor = UIColor.clear
        self.imageAnimation(array: array, index: index, imageViewArray: imageViewArray,appear: true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundView.backgroundColor = UIColor.black
        self.addSubview(backgroundView)
        self.addCollectionView()
    }
    
    func addCollectionView(){
        let layout: UICollectionViewFlowLayout! = UICollectionViewFlowLayout.init()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: self.width, height: self.height)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        self.collectView.register(ImagesHorizontalViewCell.classForCoder(), forCellWithReuseIdentifier: "identifier")
        self.collectView.delegate = self
        self.collectView.dataSource = self
        self.collectView.isPagingEnabled = true
        self.addSubview(self.collectView!)
        self.collectView.reloadData()
    }
    
    // MARK: - appear animation
    
    func imageAnimation(array : Array<ImageModel>,index : Int,imageViewArray :Array<UIImageView>,appear:Bool){
        backgroundView.alpha = appear ? 0 : 1
        let tapImageView = imageViewArray[index];
        if self.hiddenTapImge {
            tapImageView.isHidden = true
        }
        let smallFrame = self.convert(tapImageView.bounds, from: tapImageView)
        let animationImageView = UIImageView.init(frame: smallFrame)
        animationImageView.clipsToBounds = true
        animationImageView.contentMode = UIViewContentMode.scaleAspectFill
        var size : CGSize = tapImageView.size
        if tapImageView.image != nil {
            size = tapImageView.image!.size
            animationImageView.image = tapImageView.image
        }
        self.addSubview(animationImageView)
        var animationFrame = self.getAinmationFrame(imageSize: size)
        
        if !appear {
            animationImageView.frame = animationFrame
            animationFrame = smallFrame
            self.collectView.isHidden = true
        } else {
            animationImageView.layer.cornerRadius = tapImageView.layer.cornerRadius
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = appear ? 1 : 0
            animationImageView.frame = animationFrame
            if appear {
                animationImageView.layer.cornerRadius = 0
            } else {
                animationImageView.layer.cornerRadius = tapImageView.layer.cornerRadius
            }
        }) { (finish) in
            if self.hiddenTapImge {
                tapImageView.isHidden = false
            }
            if appear {
                self.collectView.isHidden = false
                animationImageView.isHidden = true
            } else {
                self.removeFromSuperview()
            }
        }
    }
    
    func getAinmationFrame(imageSize : CGSize) -> CGRect {
        if imageSize.height/imageSize.width >= kScreenHeight/kScreenWidth {
            let width = kScreenHeight * imageSize.width/imageSize.height
            return CGRect(x: (kScreenWidth - width)/2, y: 0, width: width, height: kScreenHeight)
        } else {
            let height = kScreenWidth * imageSize.height/imageSize.width
            return CGRect(x: 0, y: (kScreenHeight - height)/2, width: kScreenWidth, height: height)
        }
    }
    
    // MARK: - collectView delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ImagesHorizontalViewCell = collectView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as! ImagesHorizontalViewCell
        cell.addCustomView()
        cell.zoomView.delegate = self
        cell.zoomView.scrollView.setZoomScale(1.0, animated: false)
        self.cellLoadImage(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func cellLoadImage(cell:ImagesHorizontalViewCell,indexPath: IndexPath) {
        cell.loadWithModel(model: listArray[indexPath.row], index: indexPath.row)
    }
    
    // MARK: - zoom View delegate
    
    func tapClick(index: Int) {
        self.imageAnimation(array: self.listArray, index: index, imageViewArray: self.viewArray, appear: false)
    }
    
    func changeAlaph(_ alaph: CGFloat) {
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: alaph)
    }

}
