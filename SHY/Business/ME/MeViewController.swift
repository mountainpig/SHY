//
//  MeViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/7.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {

    override func viewDidLoad() {
        self.hiddenBackBtn = true
        super.viewDidLoad()
        self.title = "我"
        // Do any additional setup after loading the view.
        let imgView = UIImageView.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        imgView.backgroundColor = UIColor.blue
        imgView.image = UIImage.radiusCorver(width: 100, color: UIColor.white)
        imgView.image = UIImage.cornerRadiusCorver(withWidth: 100, color: UIColor.white)
        self.view.addSubview(imgView)
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
