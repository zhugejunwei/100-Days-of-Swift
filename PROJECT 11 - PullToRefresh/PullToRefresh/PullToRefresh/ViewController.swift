//
//  ViewController.swift
//  PullToRefresh
//
//  Created by 诸葛俊伟 on 9/18/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var meImage: UIImageView!
    @IBOutlet weak var emojiTableView: UITableView!
    
    let cellIdentifer = "TableViewCell"
    
    let emojisDataSource = EmojiData()
    var emojis = [EmojiModel]()
    var newEmojis = [EmojiModel]()
    var showEmojis = [EmojiModel]() {
        didSet {
            self.emojiTableView.reloadData()
        }
    }
    var refreshControl = UIRefreshControl()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emojiTableView.dataSource = self
        self.emojiTableView.delegate = self
        self.emojis = emojisDataSource.emojiData()
        self.newEmojis = emojisDataSource.newEmojiData()
        self.showEmojis = emojis
        
        
        // same as uncheck "Adjust scroll view insets" in storyboard.
        self.automaticallyAdjustsScrollViewInsets = false;
        
        self.emojiTableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(ViewController.reloadEmoji), for: .valueChanged)
        
        self.refreshControl.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        let attributes = [NSForegroundColorAttributeName: UIColor.white]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Last updated on \(Date())", attributes: attributes)
        self.refreshControl.tintColor = UIColor.white
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "My Emojis"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showEmojis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = emojiTableView.dequeueReusableCell(withIdentifier: cellIdentifer) as! TableViewCell
        let emoji = showEmojis[indexPath.row]
        cell.emojiLabel.text = emoji.emoji
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func reloadEmoji() {
        self.showEmojis = newEmojis
        self.emojiTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

