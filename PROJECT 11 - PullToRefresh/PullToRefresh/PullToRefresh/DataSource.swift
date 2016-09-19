//
//  Model.swift
//  PullToRefresh
//
//  Created by 诸葛俊伟 on 9/18/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import Foundation

class EmojiData {
    var emojis: [EmojiModel]
    
    init() {
        emojis = []
        let emoji1 = EmojiModel("😀")
        emojis.append(emoji1)
        
        let emoji2 = EmojiModel("😬")
        emojis.append(emoji2)
        
        let emoji3 = EmojiModel("😡")
        emojis.append(emoji3)
        
        let emoji4 = EmojiModel("😋")
        emojis.append(emoji4)
        
        let emoji5 = EmojiModel("😛")
        emojis.append(emoji5)
        
        let emoji6 = EmojiModel("😳")
        emojis.append(emoji6)
    }
}
