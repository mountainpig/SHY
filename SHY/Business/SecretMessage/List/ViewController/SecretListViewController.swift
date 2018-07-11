//
//  SecretListViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/7/4.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class SecretListViewController: BaseViewController,SelectViewProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let selectView = SelectView.init(frame: CGRect(x: 0, y: self.customNavigationView.bottom, width: kScreenWidth, height: 38))
        selectView.titlesArray = ["section1","section2"]
        selectView.delegate = self
        self.view.addSubview(selectView)
    }
    
    func selectIndex(_ index: Int) {
        
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
