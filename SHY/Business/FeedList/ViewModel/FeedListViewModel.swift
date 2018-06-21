//
//  FeedListViewModel.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/15.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import YYText

class FeedListViewModel: NSObject {
    class func getData(isPullDown: Bool, completiom:(_ arr:Array<FeedModel>) ->()) {
        let path : String! = Bundle.main.path(forResource: "timeline_json", ofType: "txt")
        let content = try! String.init(contentsOf: URL.init(fileURLWithPath: path), encoding: String.Encoding.utf8)
        completiom(self.feedArrayFromRequestDict(content.jsonDictionaryValue()))
        /*
         let path : String! = Bundle.main.path(forResource: "timeline_json", ofType: "txt")
         let content = try! String.init(contentsOf: URL.init(fileURLWithPath: path), encoding: String.Encoding.utf8)
         if isPullDown {
         self.dataSuorceArray = self.feedArrayFromRequestDict(content.jsonDictionaryValue())
         } else {
         self.dataSuorceArray.append(self.feedArrayFromRequestDict(content.jsonDictionaryValue()))
         }
         CacheManager.sharedInstance().save(object: self.dataSuorceArray, key: "timeline")
         self.finishPulldownloading()
         self.table.reloadData()
         */
        /*
         Alamofire.request(str, method:.get, parameters: nil, encoding: URLEncoding.default, headers: ["S-CID":"01376853868992182400"]).responseJSON { (response) in
         if(response.error == nil){
         self.loadData(response.result.value as! Dictionary<String, Any>);
         } else {
         print("请求失败\(String(describing: response.error))")
         }
         self.finishPulldownloading()
         }
         */
    }
    
    
    class func feedArrayFromRequestDict(_ dic: Dictionary<String, Any>) -> Array<FeedModel>{
        var dataDic:Dictionary = dic["data"] as! Dictionary<String, Any>
        let feedList:Array = dataDic["feedList"] as! Array<Dictionary<String, Any>>
        var resultArray = [FeedModel]()
        for temp in feedList {
            let sourceDict = temp["sourceFeed"] as! Dictionary<String, Any>
            let type = sourceDict["template"] as! Int
            if (type == 1 || type == 3){
                let model = FeedModel();
                model.name = temp["userName"] as! String
                model.avatar = temp["avatar"] as! String
                model.time = temp["createTime"] as! String
                model.feedType = type == 1 ? FeedType.common.rawValue : FeedType.image.rawValue
                model.layout = FeedCellLayout()
                model.layout.cellHeight = 68;
                
                let contentLinkArray : Array<Dictionary<String, Any>> = temp["linkContent"] as! Array<Dictionary<String, Any>>
                var contentStr = ""
                var length = 0
                var rangeArray = [NSRange]()
                if contentLinkArray.count > 0 {
                    let str : String = contentLinkArray[0]["content"] as! String
                    contentStr += str
                    length += contentStr.count
                }
                if contentLinkArray.count > 1 {
                    for index in 1...contentLinkArray.count-1 {
                        let dict = contentLinkArray[index]
                        let nameStr : String = dict["userName"] as! String
                        let content : String = dict["content"] as! String
                        contentStr += (" //" + nameStr + ":" + content)
                        let range = NSRange.init(location: length + 3, length: nameStr.count)
                        rangeArray.append(range)
                        length = contentStr.count
                    }
                }
                
                if contentStr.count > 0 {
                    let text : NSMutableAttributedString = NSMutableAttributedString.init(string: contentStr)
                    text.yy_font = UIFont.systemFont(ofSize: 16)
                    text.yy_color = UIColor.grayTwo()
                    text.yy_lineSpacing = 3
                    text.yy_lineBreakMode = NSLineBreakMode.byCharWrapping
                    
                    if rangeArray.count > 0 {
                        for range in rangeArray {
                            let highlightBorder : YYTextBorder = YYTextBorder.init();
                            highlightBorder.cornerRadius = 4;
                            highlightBorder.fillColor = UIColor.colorWithHexString("#dadada");
                            text.yy_setColor(UIColor.colorWithHexString("#3d5699"), range: range)
                            let highlight : YYTextHighlight = YYTextHighlight.init()
                            highlight.setBackgroundBorder(highlightBorder)
                            text.yy_setTextHighlight(highlight, range: range)
                        }
                    }
                    
                    let container = YYTextContainer.init()
                    container.size = CGSize(width: kScreenWidth - 28, height: CGFloat(MAXFLOAT))
                    let textLayout = YYTextLayout.init(container: container, text: text)
                    model.layout.textLayout = textLayout
                    model.layout.textHeight = (textLayout?.textBoundingSize.height)! + 5
                    model.layout.cellHeight += model.layout.textHeight
                    model.layout.textTop = 68
                }
                
                if (type == 3 && sourceDict["dynamic_pic"] != nil && sourceDict["style_pic"] != nil) {
                    let dynamic_pic : String = sourceDict["dynamic_pic"] as! String
                    var dynamiDict : Dictionary<String, Any> = dynamic_pic.jsonDictionaryValue()
                    let style_pic : String = sourceDict["style_pic"] as! String
                    var styleDict : Dictionary<String, Any> = style_pic.jsonDictionaryValue()
                    var tempArray = [ImageModel]()
                    let array = [String](dynamiDict.keys)
                    for key in array {
                        let imageModel = ImageModel()
                        imageModel.bigUrlString = dynamiDict[key] as? String
                        let emDict : Dictionary<String,Any> = styleDict[key] as! Dictionary<String,Any>
                        imageModel.smallUrlString = emDict["p"] as? String
                        imageModel.height = emDict["h"] as! CGFloat
                        imageModel.width = emDict["w"] as! CGFloat
                        imageModel.tHeight = emDict["th"] as? CGFloat
                        imageModel.tWidth = emDict["tw"] as! CGFloat
                        tempArray.append(imageModel)
                    }
                    model.imageArray = tempArray
                    model.layout.imagesViewHeight = FeedImagesView.heigthForCount((model.imageArray?.count)!);
                    model.layout.cellHeight += (model.layout.imagesViewHeight)
                    model.layout.imagesViewTop = 68 + (model.layout.textHeight)
                }
                
                resultArray.append(model);
                
            }
        }
        return resultArray
    }

}
