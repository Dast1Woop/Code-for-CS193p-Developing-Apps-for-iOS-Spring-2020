//
//  FlipCardModel.swift
//  Memorize
//
//  Created by LongMa on 2020/11/19.
//  Copyright © 2020 myl. All rights reserved.
//

import Foundation

//MVVM，可以在类的结尾分别加M、V、VM来区分
struct MemoryGameM<CardContent> {
    
    //结构体的属性声明时不必初始化，在自定义init方法里初始化更合理
    var cards:Array<Card>
    
    init(cardPairs:Int, content:((Int) -> CardContent)) {
        cards = Array<Card>()
        for i in 0..<cardPairs {
            let content = content(i)
            
            let card0 = Card(content: content, id: 2*i)
            cards.append(card0)
            let card1 = Card(content: content, id: 2*i + 1)
            cards.append(card1)
        }
        
        //洗牌
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = true
        var isChoosed = false
        var content:CardContent
        
        //id为Int类型，赋值时，要是唯一的。使得可以正常洗牌。
        var id: Int
        
        func choosed()  {
            print("choosed:\(self)")
        }
    }
    
}

