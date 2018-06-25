//
//  PhotosViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/21.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import Photos

extension BaseViewController {
    func addCancelBtn(){
        let cancelBtn = UIButton.init(frame: CGRect(x: self.customNavigationView.width - 51, y: 0, width: 51, height: 44))
        self.customNavigationView.addSubview(cancelBtn)
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        cancelBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelBtn.addTarget(self, action: #selector(cancelClick), for: UIControlEvents.touchUpInside)
    }
    
    @objc func cancelClick(){
        self.navigationController?.dismiss(animated: true, completion: {})
    }
}

class PhotosViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    let cellWidth = (kScreenWidth - 6)/3
    var collectView : UICollectionView! = nil;
    var assetsFetchResults:PHFetchResult<PHAsset>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout: UICollectionViewFlowLayout! = UICollectionViewFlowLayout.init()
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        layout.itemSize = CGSize(width: cellWidth, height:cellWidth)
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        self.collectView = UICollectionView.init(frame: CGRect(x: 0, y: self.customNavigationView.bottom, width: kScreenWidth, height: kScreenHeight - self.customNavigationView.bottom), collectionViewLayout: layout)
        self.collectView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "identifier")
        self.collectView.delegate = self
        self.collectView.dataSource = self
        self.collectView.backgroundColor = UIColor.clear
        self.view.addSubview(self.collectView)
        
        if self.assetsFetchResults == nil {
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status != .authorized {
                    return
                }
                let allPhotosOptions = PHFetchOptions()
                allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                                     ascending: false)]
                allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                         PHAssetMediaType.image.rawValue)
                self.assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image,
                                                              options: allPhotosOptions)
//                self.imageManager = PHCachingImageManager()
//                self.imageManager.stopCachingImagesForAllAssets()
                
                DispatchQueue.main.async{
                    self.collectView.reloadData()
                }
            })
        }
        self.addCancelBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetsFetchResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath)
        let imageView = cell.contentView.viewForTag(tag: 1) { () -> UIView in
            return UIImageView.init(frame: cell.bounds)
        } as! UIImageView

        if let asset = self.assetsFetchResults?[indexPath.row] {
            PHCachingImageManager.default().requestImage(for: asset, targetSize: CGSize(width: cellWidth * UIScreen.main.scale, height: cellWidth * UIScreen.main.scale),
                                           contentMode: PHImageContentMode.aspectFill,
                                           options: nil) { (image, nfo) in
                                            imageView.image = image
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoHorizontalViewController()
        vc.assetsFetchResults = self.assetsFetchResults
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
