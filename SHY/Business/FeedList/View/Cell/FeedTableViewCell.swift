//
//  FeedTableViewCell.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/28.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import YYText

class FeedTableViewCell: UITableViewCell {

    var headImageView:UIImageView?
    var nameLabel:UILabel?
    var timeLabel:UILabel?
    var contentLabel:YYLabel?
    var imagesView:FeedImagesView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomView() {
        self.headImageView = UIImageView()
        self.contentView.addSubview(self.headImageView!);
        self.nameLabel = UILabel()
        self.contentView.addSubview(self.nameLabel!)
        self.timeLabel = UILabel()
        self.contentView.addSubview(self.timeLabel!)
        self.headImageView?.layer.cornerRadius = 20;
        self.headImageView?.clipsToBounds = true;
        self.headImageView?.frame = CGRect(x: 14, y: 14, width: 40, height: 40)
        self.nameLabel?.frame = CGRect(x: (self.headImageView?.right)! + 14, y: (self.headImageView?.top)!, width: 100, height: 20)
        self.timeLabel?.frame = (self.nameLabel?.frame)!;
        self.timeLabel?.top = (self.nameLabel?.bottom)!;
        
        self.contentLabel = YYLabel.init(frame: CGRect(x: 14, y: 68, width: kScreenWidth - 28, height: 24))
        self.contentView.addSubview(self.contentLabel!);
        let action : YYTextAction = {(containerView : UIView,text : NSAttributedString,range : NSRange,rect : CGRect)  -> Void in
            print("test")
        };
        self.contentLabel!.highlightTapAction = action;
        self.contentView.addSubview(self.contentLabel!);
    }
    
    func loadWithModel(feedModel:FeedModel,eventCenter:FeedEventCenter) {
        self.nameLabel?.text = feedModel.name
        let imgUrl : URL = URL.init(string:  feedModel.avatar)!
        self.headImageView?.sd_setImage(with: imgUrl, completed: nil)
        self.timeLabel?.text = feedModel.time;
        
        if feedModel.layout.textLayout != nil {
            self.contentLabel?.textLayout = feedModel.layout.textLayout
            self.contentLabel?.top = feedModel.layout.textTop
            self.contentLabel?.height = feedModel.layout.textHeight
        }
        
        if feedModel.feedType == FeedType.image.rawValue {
            if (self.imagesView == nil) {
                self.imagesView = FeedImagesView()
                self.imagesView?.enventCenter = eventCenter
                self.imagesView?.frame = CGRect(x: 0, y: 92, width: kScreenWidth, height: kScreenWidth)
                self.contentView.addSubview(self.imagesView!)
            }
            self.imagesView?.top = feedModel.layout.imagesViewTop
            self.imagesView?.height = feedModel.layout.imagesViewHeight
            self.imagesView?.loadWithArray(feedModel.imageArray!)
            self.imagesView?.isHidden = false
        } else {
            self.imagesView?.isHidden = true
        }
    }
}
