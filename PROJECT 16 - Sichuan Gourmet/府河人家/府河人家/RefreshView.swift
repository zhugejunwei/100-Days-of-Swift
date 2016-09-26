//
//  RefreshView.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/26/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit
import SnapKit

class RefreshView: UIView
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        addSubview(arrowView)
        addSubview(tipLabel)
        
        arrowView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self).offset(-40)
            make.centerY.equalTo(self)
        }
        
        tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(arrowView.snp.right).offset(20)
            make.centerY.equalTo(arrowView)
        }
    }

    let arrowView: UIImageView = {
        let arrow = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
        return arrow
    }()
    let tipLabel : UILabel = {
        let tip = UILabel()
        tip.font = UIFont(name: "CODE LIGHT", size: 14)
        tip.text = "Pull To Refresh"
        return tip
    }()
    
    // rotate arrow, change text
    func rotateRefresh(_ flag: Bool) {
        // transfrom的旋转默认是顺时针旋转
        // 如果设置了旋转的角度, 默认是就近原则, 离那边近, 就从哪个方向转
        let angle = flag ? -0.01 : 0.01
        UIView.animate(withDuration: 0.5) {
            self.arrowView.transform = self.arrowView.transform.rotated(by: CGFloat(angle + M_PI))
            self.tipLabel.text = flag ? "Release Refresh" : "Pull To Refresh"
        }
    }
    
    // Begin to load the activity indicator
    func beginLoadIndicator() {
        tipLabel.text = "Loading..."
        arrowView.image = UIImage(named: "tableview_loading")
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.repeatCount = MAXFLOAT
        anim.duration = 0.25
        anim.toValue = 2 * M_PI
        anim.isRemovedOnCompletion = false
        arrowView.layer.add(anim, forKey: nil)
    }
    
    // Stop activity indicatior
    func stopLoadIndicator() {
        tipLabel.text = "Pull To Refresh"
        arrowView.image = UIImage(named: "tableview_pull_refresh")
        arrowView.layer.removeAllAnimations()
    }
}
