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
    var content:(Item)->ItemView
    
    var body: some View {
        GeometryReader{geometry in
            let layout = GridLayout(itemCount: cards.count, in: geometry.size)
            
            //Closure containing control flow statement cannot be used with function builder 'ViewBuilder'
//            for i in 0..<cards.count{
//                let card = cards[i]
//                content(card)
//                    .position(layout.location(ofItemAt: i))
//            }
            
            ForEach(cards){
                card in
                let index = cards.firstIndex(matching: card)
                if let index = index{
                    content(card)
                        .position(layout.location(ofItemAt: index))
                        .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                }
            }
        }
    }
    
    //-> View: Protocol 'View' can only be used as a generic constraint because it has Self or associated type requirements
    //-> some View: 'some' types are only implemented for the declared type of properties and subscripts and the return type of functions
    init(_ cards:[Item], content:@escaping (_ card: Item)-> ItemView) {
        self.cards = cards
        self.content = content
    }
}

