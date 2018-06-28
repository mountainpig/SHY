//
//  FeedEventCenter.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/5.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class FeedEventCenter: NSObject{
    weak var viewController : UIViewController! = nil
    func clickCellImages(array : Array<ImageModel>,index:Int,imageViewArray :Array<UIImageView>){
        let view = ImagesHorizontalView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth + 20, height: kScreenHeight))
        viewController.view.addSubview(view)
        view.animationApear(array: array,index : index,imageViewArray : imageViewArray)
    }
    
    func clickAvatarWithUserId(_ userId : String){
        viewController.jumpProfileWithUserId(userId)
    }
}
