//
//  SelectView.swift
//  SHY
//
//  Created by 黄敬 on 2018/7/4.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

protocol SelectViewProtocol : NSObjectProtocol{
    func selectIndex(_ index : Int)
}

class SelectView: UIView {
    weak var delegate : SelectViewProtocol?
    let line = UIView()
    var lastSelectBtn : UIButton! = nil
    var _titlesArray : Array<String>?
    var titleWidthArray = [CGFloat]()
    var titlesArray : Array<String>? {
        get{
            return _titlesArray
        }
        set {
            _titlesArray = newValue
            self.refreshView()
        }
    }
    
    func refreshView(){
        let count = self.titlesArray!.count
        let width = self.width/CGFloat(count)
        
        for index in 0...count - 1 {
            let btn = self.viewForTag(tag: index + 1000) { () -> UIView in
                let btn = UIButton.init(frame: CGRect(x: width * CGFloat(index), y: 0, width: width, height: self.height))
                btn.setTitleColor(UIColor.grayThree(), for: UIControlState.normal)
                btn.setTitleColor(UIColor.black, for: UIControlState.selected)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                btn.addTarget(self, action: #selector(btnClick(_:)), for: UIControlEvents.touchUpInside)
                return btn
            } as! UIButton
            let str = self.titlesArray?[index]
            self.titleWidthArray.append(str!.widthWithFont(btn.titleLabel!.font) + 8)
            btn.setTitle(str, for: UIControlState.normal)
            if index == 0 {
                btn.isSelected = true
                self.lastSelectBtn = btn
                self.adjustBottomLineAinmation(false)
            }
            
        }
    }
    
    @objc func btnClick(_ sender:UIButton){
        if self.lastSelectBtn == sender {
            return
        }
        self.lastSelectBtn?.isSelected = false
        sender.isSelected = true
        self.lastSelectBtn = sender
        self.adjustBottomLineAinmation(true)
        self.delegate?.selectIndex(sender.tag - 1000)
    }
    
    func adjustBottomLineAinmation(_ animation:Bool){
        let index = self.lastSelectBtn.tag - 1000
        let block = {
            let width = self.titleWidthArray[index];
            self.line.frame = CGRect(x:self.lastSelectBtn.left + (self.lastSelectBtn.width - width)/2, y: self.height - 2, width: width, height: 2)
        }
        if  animation {
            UIView.animate(withDuration: 0.25) {
                block()
            }
        } else {
            block()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.line.clipsToBounds = true
        self.line.layer.cornerRadius = 1
        self.line.backgroundColor = UIColor.snsYellow()
        self.addSubview(self.line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
