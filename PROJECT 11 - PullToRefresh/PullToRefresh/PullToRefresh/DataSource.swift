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
    var newEmojis: [EmojiModel]
    
    init() {
        emojis = []
        newEmojis = []
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
        
        let emoji11 = EmojiModel("😀😀😀")
        newEmojis.append(emoji11)
        
        let emoji22 = EmojiModel("😬😬😬")
        newEmojis.append(emoji22)
        
        let emoji33 = EmojiModel("😡😡😡")
        newEmojis.append(emoji33)
        
        let emoji44 = EmojiModel("😋😋😋")
        newEmojis.append(emoji44)
        
        let emoji55 = EmojiModel("😛😛😛")
        newEmojis.append(emoji55)
        
        let emoji66 = EmojiModel("😳😳😳")
        newEmojis.append(emoji66)
    }
    
    func emojiData() -> [EmojiModel] {
        return emojis
    }
    
    func newEmojiData() -> [EmojiModel] {
        return newEmojis
    }
    
    
}
