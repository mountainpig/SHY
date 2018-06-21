//
//  FeedImagesView.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/29.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class FeedImagesView: UIView {
    
    var enventCenter : FeedEventCenter! = nil
    var listArray : Array! = [ImageModel]()

    func imageViewAtIndex(_ index : Int) -> UIImageView {
        var view = self.viewWithTag(index + 996) as? UIImageView
        if view == nil {
            view = UIImageView()
            view!.tag = index + 996
            view!.clipsToBounds = true
            view!.contentMode = UIViewContentMode.scaleAspectFill
            view!.backgroundColor = UIColor.colorWithHexString("#eaeaea")
            view!.isUserInteractionEnabled = true
            let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(imageTap(_:)))
            view?.addGestureRecognizer(tap)
            
            self.addSubview(view!)
        }
        return view!
    }
    
    @objc func imageTap(_ tap:UITapGestureRecognizer){
        var array = [UIImageView]()
        for index in 0...self.listArray.count-1 {
            array.append(self.viewWithTag(index + 996) as! UIImageView)
        }
        self.enventCenter.clickCellImages(array: self.listArray, index: tap.view!.tag - 996,imageViewArray: array)
    }
    
    class func heigthForCount(_ count : Int) -> CGFloat {
        var height : CGFloat = 0.0;
        if count == 1 {
            height = kScreenWidth * 3/4;
        } else if count == 2 {
            height = (kScreenWidth - 42)/2;
        } else if count == 3 {
            height = (kScreenWidth - 56)/3;
        } else if count == 4 {
            height = kScreenWidth - 28;
        }
        return height;
    }
    
    func imageFrame(count:Int, index:Int) -> CGRect {
        var frame : CGRect!
        switch count {
        case 1:
            frame = CGRect(x: 14, y: 0, width: self.width - 28, height: self.height)
            break
        case 2:
            if index == 0 {
                frame = CGRect(x: 14, y: 0, width: (self.width - 42)/2, height: self.height)
            } else {
                frame = CGRect(x: 28 + (self.width - 42)/2, y: 0, width: (self.width - 42)/2, height: self.height)
            }
            break
        case 3:
            let imageWidth = (self.width - 56)/3;
            if index == 0 {
                frame = CGRect(x: 14, y: 0, width: imageWidth, height: self.height)
            } else if index == 1 {
                frame = CGRect(x: imageWidth + 28, y: 0, width: imageWidth, height: self.height)
            } else {
                frame = CGRect(x: imageWidth * 2 + 42, y: 0, width: imageWidth, height: self.height)
            }
            break
        case 4:
            let imageWidth = (self.width - 42)/2;
            let imageHeigth = (self.height - 14)/2;
            if index == 0 {
                frame = CGRect(x: 14, y: 0, width: imageWidth, height: imageHeigth)
            } else if index == 1 {
                frame = CGRect(x: imageWidth + 28, y: 0, width: imageWidth, height: imageHeigth)
            }else if index == 2 {
                frame = CGRect(x: 14, y: imageHeigth + 14, width: imageWidth, height: imageHeigth)
            } else {
                frame = CGRect(x:  imageWidth + 28, y: imageHeigth + 14, width: imageWidth, height: imageHeigth)
            }
            break
        default:
            frame = CGRect.zero
            break
        }
        return frame
    }

    func loadWithArray(_ array : Array<ImageModel>){
        self.listArray = array
        for index in 0...3 {
            let view = self.viewWithTag(index + 996) as? UIImageView
            if index >= array.count {
                view?.isHidden = true
            } else {
                let imageView = self.imageViewAtIndex(index)
                imageView.isHidden = false;
                imageView.frame = self.imageFrame(count: array.count, index: index)
                imageView.sd_setImage(with: URL.init(string: array[index].smallUrlString!), completed: nil)
            }
        }
    }
}
