//
//  ViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/28.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import MJRefresh

class BasePullLoadingViewController: BaseTableViewController {

    var loadingView : PullLoadingView! = nil
    var upLoadingView : UpLoadView! = nil
    var isPullLoading = false
    var isUpLoading = false
//    let header = MJRefreshNormalHeader()
    let header = CSRefreshStateHeader()
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        self.loadingView = PullLoadingView.init(frame: CGRect(x: 0, y: -44, width: kScreenWidth, height: 44), observedScrollView: table)
        table.addSubview(loadingView)
        self.upLoadingView = UpLoadView.init(frame: CGRect(x: 0, y: table.height, width: kScreenWidth, height: 33), observedScrollView: table)
        table.addSubview(self.upLoadingView)
 */
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        header.stateLabel.isHidden = true
        header.lastUpdatedTimeLabel.isHidden = true
        self.table.mj_header = header
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        footer.setTitle("", for: MJRefreshState.idle)
        self.table.mj_footer = footer
    }
    
    // MARK: - tableView delegate
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.loadingView.scrollViewDidScroll(scrollView)
        self.upLoadingView.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y + scrollView.contentInset.top <= -64 && !self.isPullLoading) {
            self.loadingView.changeStatus(PullLoadingStatus.loading)
            self.netRequestIsPullDown(true)
            self.isPullLoading = true
        }
    }
    */
    @objc func headerRefresh(){
        self.netRequestIsPullDown(true)
    }
    
    @objc func footerRefresh(){
        self.netRequestIsPullDown(false)
    }

    func netRequestIsPullDown(_ isPullDown:Bool) {
        
    }
    
    func finishPulldownloading(){
//        self.loadingView.changeStatus(PullLoadingStatus.stop)
//        self.isPullLoading = false
        self.table.mj_header.endRefreshing()
    }
    
    func finishPulluploading(){
        self.table.mj_footer.endRefreshing()
//        footer.endRefreshingWithNoMoreData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

