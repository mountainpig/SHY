//
//  PhotoHorizontalViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/22.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import Photos

class PhotoHorizontalViewController: BaseViewController {

    var assetsFetchResults:PHFetchResult<PHAsset>?
    var index : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.insertSubview(PhotoHorizontalView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth + 20, height: kScreenHeight), fetchResults: self.assetsFetchResults!,index:self.index), belowSubview: self.customStatusBar)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
