//
//  ImageBrowserViewController.swift
//  Floral
//
//  Created by ALin on 16/6/6.
//  Copyright © 2016年 ALin. All rights reserved.
//

import UIKit
private let ImageBrowserCellReuseIdentifier = "ImageBrowserCellReuseIdentifier"
class ImageBrowserViewController: UICollectionViewController, ImageBrowserViewCellDelegate {
    // 图片URL数组的
    var imageUrls : [URL]
    // 点击的当前图片的索引
    var indexPath : IndexPath
    init(urls: [URL], index: IndexPath)
    {
        imageUrls = urls
        indexPath = index
        super.init(collectionViewLayout: PhotoBrowserLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 滚动到指定位置
        collectionView!.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.register(ImageBrowserViewCell.self, forCellWithReuseIdentifier: ImageBrowserCellReuseIdentifier)
        
        KeyWindow.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.centerX.equalTo(KeyWindow)
        }
        titleLabel.text = "\((indexPath as NSIndexPath).item+1)/\(imageUrls.count)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        titleLabel.removeFromSuperview()
    }
    
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageBrowserCellReuseIdentifier, for: indexPath) as! ImageBrowserViewCell
        
        cell.imageURL = imageUrls[(indexPath as NSIndexPath).item]
        cell.delegate = self
        
        return cell
    }
    
    
    // MARK: - PhotoBrowserViewCellDelegate
    func ImageBrowserViewCellDidClickImage(_ cell: ImageBrowserViewCell) {
        dismiss(animated: true, completion: nil)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / collectionView!.frame.width + 0.5)
        titleLabel.text = "\(index+1)/\(imageUrls.count)"
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error:NSError?, contextInfo: AnyObject)
    {
        if error != nil{
            showHint("保存失败", duration: 2.0, yOffset: 0)
        }else
        {
            showHint("保存成功", duration: 2.0, yOffset: 0)
        }
    }
    
    // MARK: - 懒加载
    fileprivate lazy var titleLabel = UILabel(textColor: UIColor.white, font: UIFont.systemFont(ofSize: 22))

}



private class PhotoBrowserLayout: UICollectionViewFlowLayout
{
    fileprivate override func prepare() {
        super.prepare()
        
        // 1.设置layout
        itemSize = UIScreen.main.bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.horizontal
        
        // 2.设置collectionView
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
    }
}
