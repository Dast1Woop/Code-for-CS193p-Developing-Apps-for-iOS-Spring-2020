//
//  ContentView.swift
//  Memorize
//
//  Created by LongMa on 2020/11/17.
//  Copyright © 2020 myl. All rights reserved.
//

import SwiftUI



/// swiftUI是函数式编程，不是面向对象编程
/// 紫色：系统关键字，蓝色：系统类型，绿色：自定义变量名
struct ContentView: View {
    var viewModel: MemoryGameVM
    
    //some View，任意视图。：代表表现的像xx
    //😓，注释不能写在代码后面的同一行，否则预览会报错
    var body: some View {
        return
            
            //当函数没有参数时，()也可以省略
            VStack {
                
                //尾调闭包写法更简洁
                ForEach(0..<3) {index in
                    HStack {
                        
                        //content:参数是闭包。
                        ForEach(self.viewModel.cards, content: {card in
                            
                            //todo:why cannot print
                            //                    print(index)
                            Cardview(card: card).onTapGesture(perform: {
                                self.viewModel.chooseCard(card: card)
                            })
                            //                        .padding()
                        })
                    }
                }
            }
            .padding()
            .foregroundColor(Color.orange)
        
        //在外面写的方法会作用于整个代码块
    }
}

struct Cardview: View {
    var card: MemoryGameM<String>.Card
    var body: some View {
    
        ZStack {
            if(card.isFaceUp){
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                
                //cmd+ctrl+space,调出emoji
                Text(card.content).font(card.isFontUseLargeTitle ? Font.largeTitle : Font.body)
            }else{
                RoundedRectangle(cornerRadius:10).fill(Color.orange)
            }
        }.aspectRatio(2/3, contentMode: .fit)
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(viewModel: MemoryGameVM())
                .preferredColorScheme(.dark)
            ContentView(viewModel: MemoryGameVM())
                .preferredColorScheme(.light)
        }
    }
}
