//
//  EmojiFlipCardVM.swift
//  Memorize
//
//  Created by LongMa on 2020/11/19.
//  Copyright © 2020 myl. All rights reserved.
//

import Foundation

//vm,可能会被共享，所以需要声明为类，因其创建的对象是指针类型。而结构体是值类型（copy-on-write特性）
class EmojiFlipCardVM{
    
    //持有model、私有化，通过类方法初始化，不能通过对象方法，因为swift的对象的属性必须先初始化，才能创建对象
    private var model:FlipCardModel<String> = EmojiFlipCardVM.generateModel()
    
    //直接写Card会报错，需要写结构体路径
    var cards: Array<FlipCardModel<String>.Card>{
        return model.cards
    }
    
    static func generateModel()->FlipCardModel<String> {
        let arr = ["🎃", "👻", "🦁"]
        let model = FlipCardModel<String>(cardPairs: arr.count) { (index) -> String in
            arr[index]
        }
        return model
    }
    
    
    //mark:action
    //操作model
    
}

