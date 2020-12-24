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
class MemoryGameVM: ObservableObject{
    
    //持有model、私有化，通过类方法初始化，不能通过对象方法，因为swift的对象的属性必须先初始化，才能创建对象
    @Published private var model:MemoryGameM<String> = MemoryGameVM.createMemoryGame()
    
    //直接写Card会报错，需要写结构体路径
    var cards: [MemoryGameM<String>.Card]{
        return model.cards
    }
    
    var onlyOneFaceUpCardIndex: Int?{
        get{cards.firstIndex(matching: cards.filter({$0.isFaceUp}).only)}
    
        set{}
    }
    
    var faceUpCardIndexesArr:[Int]?{
        get{
            var indexesArr = [Int]()
            let arr = cards.filter({$0.isFaceUp})
            if arr.count > 0 {
                for i in 0..<arr.count {
                    if let index = cards.firstIndex(matching: arr[i]){
                        indexesArr.append(index)
                    }
                }
            }
            
            if indexesArr.count > 0 {
                return indexesArr
            }
            return nil
        }
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
    //选中卡片时：
    //交互方案（todo：翻转和匹配动画）：如果当前已有1张正面卡，匹配当前翻的卡片与正面卡是否一致，一致时修改isMatched属性为true；否则，除选中卡片，faceup都设置为false。再刷新全部卡片（匹配的隐藏，未匹配的根据模型显示正/反面）
    func chooseCard(card: MemoryGameM<String>.Card)  {
        card.choosed()
        
        //反转 cards 中对应 card 的 isFaceUp 属性
        let sltedIndex = cards.firstIndex(matching: card)
        if let sltedIndex = sltedIndex{
            
            if let desiredCardIndex = onlyOneFaceUpCardIndex, desiredCardIndex != sltedIndex{
                if cards[sltedIndex].content == cards[desiredCardIndex].content {
                    model.cards[sltedIndex].isMatched = true
                    model.cards[desiredCardIndex].isMatched = true
                }
                onlyOneFaceUpCardIndex = nil
                
                model.cards[sltedIndex].isFaceUp = !cards[sltedIndex].isFaceUp
            }else{
                if let faceUpCardIndexesArr = faceUpCardIndexesArr{
                    
                    //当点击的不是已翻面卡片时，使所有卡片朝下，然后使被点击卡片朝上；否则，不做任何操作
                    if !faceUpCardIndexesArr.contains(sltedIndex) {
                        for i in 0..<cards.count {
                            model.cards[i].isFaceUp = false
                        }
                        
                        model.cards[sltedIndex].isFaceUp = !cards[sltedIndex].isFaceUp
                    }else{
                        //do nothing，被点击卡片也无需翻转
                    }
                }else{
                    model.cards[sltedIndex].isFaceUp = !cards[sltedIndex].isFaceUp
                }
            }
        }
        
    }
}

