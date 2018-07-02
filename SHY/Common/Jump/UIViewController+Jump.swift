//
//  UIViewController+Jump.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/21.
//  Copyright © 2018年 hj. All rights reserved.
//

import Foundation

extension UIViewController {
    func jumpPhotoViewController() {
        let nav = UINavigationController()
        nav.viewControllers = [PhotoAlbumViewController(),PhotosViewController()]
        self.navigationController?.present(nav, animated: true, completion: {})
    }
    
    func jumpProfileWithUserId(_ userId : String) {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    func jumpFansListWithUserId(_ userId : String) {
        self.navigationController?.pushViewController(FansListViewController(), animated: true)
    }
}
