//
//  ImagesHorizontalScrollView.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/5.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class ImagesHorizontalViewCell: UICollectionViewCell {
    var zoomView : ImageZoomScrollView = ImageZoomScrollView.init(frame: kScreenRect)
    func addCustomView(){
        self.addSubview(zoomView)
    }
    
    func loadWithModel(model : ImageModel,index : Int){
        self.zoomView.imageView.sd_setImage(with: URL.init(string: model.smallUrlString!), completed: nil)
        self.zoomView.index = index
    }
}

class ImagesHorizontalView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,ImageZoomScrollViewProtocol {

    var collectView : UICollectionView! = nil;
    var listArray : Array! = [ImageModel]();
    var viewArray : Array! = [UIImageView]();
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect,array : Array<ImageModel>,index : Int,imageViewArray :Array<UIImageView>) {
        super.init(frame: frame)
        self.listArray = array
        self.viewArray = imageViewArray
        self.addCollectionView()
        self.collectView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        self.collectView.isHidden = true
        self.imageAnimation(array: array, index: index, imageViewArray: imageViewArray,appear: true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        let backgroundView = UIView.init(frame: self.bounds)
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = appear ? 0 : 1
        self.addSubview(backgroundView)
        
        let tapImageView = imageViewArray[index];
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
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            backgroundView.alpha = appear ? 1 : 0
            animationImageView.frame = animationFrame
        }) { (finish) in
            if appear {
                self.collectView.isHidden = false
                backgroundView.isHidden = true
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
    
    func tapClick(index: Int) {
        self.imageAnimation(array: self.listArray, index: index, imageViewArray: self.viewArray, appear: false)
    }

}
