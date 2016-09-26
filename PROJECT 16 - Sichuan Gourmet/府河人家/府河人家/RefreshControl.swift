//
//  RefreshControl.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/26/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit
import SnapKit

class RefreshControl: UIRefreshControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(refreshView)
        
        refreshView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 200, height: 60))
        }
        
        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        removeObserver(self, forKeyPath: "frame")
    }
    
    /// 监听frame的变化
    // 是否旋转箭头的标记
    fileprivate var rotationFlag = false
    // 是否执行动画的标记
    fileprivate var animatingFlag = false
    // 是否一开始就直接刷新, 没有进行下拉
    fileprivate var beginAnimFlag = false
    // 刷新的时候, 不再进行其他操作
    fileprivate var isLoading = false
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let y = frame.origin.y
        
        // 1. 最开始一进来的时候, 刷新按钮是隐藏的, y就是-64, 需要先判断掉, y>=0 , 说明刷新控件已经完全缩回去了...
        if y >= 0 || y == -64 {
            return
        }
        
        // 2. 判断是否一进来就进行刷新
        if beginAnimFlag && (y == -60 || y == -124.0) {
            if !isLoading {
                isLoading = true
                animatingFlag = true
                refreshView.beginLoadIndicator()
            }
            return
        }
        
        // start refresh
        if isRefreshing && !animatingFlag {
            animatingFlag = true
            refreshView.beginLoadIndicator()
            return
        }
        
        if y <= -50 && !rotationFlag {
            rotationFlag = true
            refreshView.rotateRefresh(rotationFlag)
        } else if y > -50 && rotationFlag {
            rotationFlag = true
            refreshView.rotateRefresh(rotationFlag)
        }
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        animatingFlag = false
        rotationFlag = false
        isLoading = false
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(2 * NSEC_PER_SEC) / Double(NSEC_PER_SEC)) {
            self.refreshView.stopLoadIndicator()
        }
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
        beginAnimFlag = true
        
    }
    
    fileprivate lazy var refreshView: RefreshView = RefreshView()
}
