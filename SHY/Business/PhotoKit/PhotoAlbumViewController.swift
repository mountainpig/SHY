//
//  PhotoAlbumViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/22.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import Photos

class AlbumItem {
    //相簿名称
    var title:String?
    //相簿内的资源
    var fetchResult : PHFetchResult<PHAsset>?
    
    init(title:String?,fetchResult : PHFetchResult<PHAsset>){
        self.title = title
        self.fetchResult = fetchResult
    }
}

class PhotoAlbumViewController: BaseTableViewController {

    var fetchResult:PHFetchResult<AnyObject>?
    
    override func viewDidLoad() {
        self.hiddenBackBtn = true
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addCancelBtn()
        
        let smartOptions = PHFetchOptions()
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum,
                                                                          subtype: PHAssetCollectionSubtype.albumRegular,
                                                                          options: smartOptions)
        self.convertCollection(collection: smartAlbums as! PHFetchResult<AnyObject>)
    }
    
    private func convertCollection(collection:PHFetchResult<AnyObject>){
        
        for i in 0..<collection.count{
            //获取出但前相簿内的图片
            let resultsOptions = PHFetchOptions()
            resultsOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                               ascending: false)]
            resultsOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                   PHAssetMediaType.image.rawValue)
            guard let c = collection[i] as? PHAssetCollection else { return }
            let assetsFetchResult = PHAsset.fetchAssets(in: c,options: resultsOptions)
            //没有图片的空相簿不显示
            if assetsFetchResult.count > 0{
                self.dataSuorceArray.append(AlbumItem(title: c.localizedTitle, fetchResult: assetsFetchResult))
            }
        }
    }
        


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identifier";
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            cell?.imageView?.frame = CGRect.width(44)
        }
        let item = self.dataSuorceArray[indexPath.row] as! AlbumItem
        PHCachingImageManager.default().requestImage(for: (item.fetchResult?.lastObject)!, targetSize: CGSize(width: 44 * UIScreen.main.scale, height: 44 * UIScreen.main.scale),
                                       contentMode: PHImageContentMode.aspectFill,
                                       options: nil) { (image, nfo) in
                                        DispatchQueue.main.async{
                                            cell?.imageView?.image = image
                                        }
                                        
        }
        cell?.textLabel?.text = item.title! + "  " + "(" + "\(item.fetchResult!.count)" + ")"
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.dataSuorceArray[indexPath.row] as! AlbumItem
        let vc = PhotosViewController()
        vc.assetsFetchResults = item.fetchResult
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
