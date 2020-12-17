//
//  GridView.swift
//  Memorize
//
//  Created by LongMa on 2020/12/16.
//  Copyright © 2020 myl. All rights reserved.
//

import SwiftUI

//添加 泛型<>，简化代码，方便扩展！！！
struct GridView<Item, ItemView>: View where Item:Identifiable, ItemView: View {
    
    var cards:[Item]
    var makeViewFunc:(Item)->ItemView
    
    var body: some View {
        GeometryReader{geometry in
            let layout = GridLayout(itemCount: cards.count, in: geometry.size)
            
            //Closure containing control flow statement cannot be used with function builder 'ViewBuilder'
            //在视图构造器中，不能用for in等控制流语句，只能用ForEach结构体
            //            for i in 0..<cards.count{
            //                let card = cards[i]
            //                content(card)
            //                    .position(layout.location(ofItemAt: i))
            //            }
            
            bodyFor(layout)
        }
    }
    
    func bodyFor(_ layout: GridLayout)-> some View{
        ForEach(cards){
            card in
            bodyFor(item: card, in: layout)
        }
    }
    
    func bodyFor(item: Item,in layout: GridLayout)-> some View{
        
        //Group：当闭包无返回值时，它会自动返回一个 空视图。同 ZStack 等
        Group{
            let index = cards.firstIndex(matching: item)
            if let index = index{
                makeViewFunc(item)
                    .position(layout.location(ofItemAt: index))
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            }
        }
    }
    
    //-> View: Protocol 'View' can only be used as a generic constraint because it has Self or associated type requirements
    //-> some View: 'some' types are only implemented for the declared type of properties and subscripts and the return type of functions
    init(_ cards:[Item], content:@escaping (_ card: Item)-> ItemView) {
        self.cards = cards
        self.makeViewFunc = content
    }
}

