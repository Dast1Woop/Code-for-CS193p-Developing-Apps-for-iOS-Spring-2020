//
//  FlipCardModel.swift
//  Memorize
//
//  Created by LongMa on 2020/11/19.
//  Copyright © 2020 myl. All rights reserved.
//

import Foundation

struct FlipCardModel<CardContent> {
    var cards:Array<Card> = []
    
    //    func numberOf(cardPairs:Int, content:CardContent) -> FlipCardModel<CardContent>

    //?函数如何单独声明，然后作为形参传入？
//    var aa: (Int) -> CardContent
    
    init(cardPairs:Int, content:((Int) -> CardContent)) {
      
        for i in 0..<cardPairs {
            let content = content(i)
            
            let card0 = Card(content: content, id: 2*i)
            cards.append(card0)
            let card1 = Card(content: content, id: 2*i + 1)
            cards.append(card1)
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = true
        var isChoosed = false
        var content:CardContent
        
        //Int?
        var id: Int
    }
    
}

