//
//  NewFeatureCell.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/21/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit
import SnapKit

class NewFeatureCell: UICollectionViewCell
{
    var image: UIImage? {
        didSet {
            if let img = image {
                imageView.image = img
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    internal lazy var imageView: UIImageView = UIImageView()
}
