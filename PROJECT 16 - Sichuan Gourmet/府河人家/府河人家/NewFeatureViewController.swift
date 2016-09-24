//
//  NewFeatureViewController.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/21/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let NewFeatureCellIdentifier = "NewFeature"

class NewFeatureViewController: UICollectionViewController
{
    fileprivate let imageArray = ["guideImage1", "guideImage2", "guideImage3"]
    
    // MARK: - Lifecycle
    init() {
        super.init(collectionViewLayout: NewFeatureFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layoutUI()
    }
    
    fileprivate func prepareUI() {
        // register cell
        self.collectionView?.register(NewFeatureCell.self, forCellWithReuseIdentifier: NewFeatureCellIdentifier)
        
        // add page control
        collectionView?.addSubview(pageControl)
        collectionView?.addSubview(startButton)
    }
    
    fileprivate func layoutUI() {
        pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-28)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize(width: 100, height: 20))
        }
        
        startButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(pageControl).offset(-18)
            make.height.equalTo(40)
            make.width.equalTo(110)
            make.centerX.equalTo(self.view.snp.centerX)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewFeatureCellIdentifier, for: indexPath) as! NewFeatureCell
        if imageArray.count > 0 {
            cell.image = UIImage(named: imageArray[indexPath.item])
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    {
//        // the last image
//        if indexPath.item == imageArray.count - 1 {
//            // enter the main page
//            KeyWindow.rootViewController = MainViewController()
//        }
//    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / self.view.bounds.width + 0.5)
        pageControl.currentPage = currentPage
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView.contentOffset.x/self.view.bounds.width > (CGFloat(imageArray.count) - 1.5)
        {
            // hide pageControl at last page
            pageControl.isHidden = true
            
            // show the startButton at last page
            UIView.animate(withDuration: 0.5, animations: {
                self.startButton.isHidden = false
            })
        } else {
            pageControl.isHidden = false
            startButton.isHidden = true
        }
    }
    
    // MARK: - lazy var
    
    fileprivate lazy var pageControl: UIPageControl = {
       let pc = UIPageControl()
        pc.numberOfPages = self.imageArray.count
        pc.pageIndicatorTintColor = UIColor.gray
        pc.currentPageIndicatorTintColor = UIColor.cyan
        return pc
    }()
    fileprivate lazy var startButton: UIButton = {
        let startButton = UIButton(type: .custom)
        startButton.layer.cornerRadius = 18.0
        startButton.setTitle("Enter", for: UIControlState())
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
        startButton.setTitleColor(UIColor.white, for: UIControlState())
        startButton.backgroundColor = UIColor(r: 30, g: 144, b: 255)
        startButton.addTarget(self, action: #selector(NewFeatureViewController.didTappedStartButton(_:)), for: .touchUpInside)
        startButton.isHidden = true
        return startButton
    }()
    
    // Enter the main page
    @objc fileprivate func didTappedStartButton(_ btn: UIButton) {
        KeyWindow.rootViewController = MainViewController()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

// MARK: - Customed FlowLayout
class NewFeatureFlowLayout: UICollectionViewFlowLayout
{
    override func prepare()
    {
        super.prepare()
        
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        
        collectionView?.bounces = false
    }
}
