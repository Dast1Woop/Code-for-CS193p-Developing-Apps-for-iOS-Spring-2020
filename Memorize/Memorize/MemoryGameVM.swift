//
//  EmojiFlipCardVM.swift
//  Memorize
//
//  Created by LongMa on 2020/11/19.
//  Copyright © 2020 myl. All rights reserved.
//

import Foundation


//函数也可以单独声明在 “类外面”，然后作为形参传入
let gEmojiArr = ["🏆", "🌴","💧", "🔥", "🌏",]
func creatCardContent(index: Int)->String{
    return gEmojiArr[index]
}

//vm,可能会被共享，所以需要声明为类，因其创建的对象是指针类型。而结构体是值类型（copy-on-write特性）
class MemoryGameVM{
    
    //持有model、私有化，通过类方法初始化，不能通过对象方法，因为swift的对象的属性必须先初始化，才能创建对象
    private var model:MemoryGameM<String> = MemoryGameVM.createMemoryGame()
    
    //直接写Card会报错，需要写结构体路径
    var cards: Array<MemoryGameM<String>.Card>{
        return model.cards
    }

    //type method
    static func createMemoryGame()->MemoryGameM<String> {
        
        //1、直接传入函数法
//        let model = FlipCardModel<String>(cardPairs: gEmojiArr.count,content: creatCardContent)
        
        //2、尾调闭包法,更符合 高内聚 思想
        let arr = ["🏆", "🌴","💧", "🔥", "🌏",]
        let randomNum = arc4random_uniform(5 - 2 + 1) + 2
        let model = MemoryGameM<String>(cardPairs: Int(randomNum)){ (index) -> String in
            arr[index]
        }
        
        return model
    }
    
    
    //mark:action
    //操作model
    func chooseCard(card: MemoryGameM<String>.Card)  {
        card.choosed()
    }
}

