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
   @ObservedObject var viewModel: MemoryGameVM
    
    //some View，任意视图。：代表表现的像xx
    //😓，注释不能写在代码后面的同一行，否则预览会报错
    var body: some View {
        return
            
            //当函数没有参数时，()也可以省略
            
            //尾调闭包写法更简洁
            HStack {
                
                //content:参数是闭包。
                ForEach(self.viewModel.cards, content: {card in
                    
                    //just cannot print or 声明var in viewBuilder！
                    //                    print(index)
                    Cardview(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture(perform: {
                        self.viewModel.chooseCard(card: card)
                    })
                    //                        .padding()
                })
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
                
//                不能在 viewbuilder 中声明再使用变量，必须放在 viewbuilder 外面，最好是 body 闭包外面
//                var x = 1
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                
                //cmd+ctrl+space,调出emoji
                Text(card.content).font(card.isFontUseLargeTitle ? Font.largeTitle : Font.body)
            }else{
                RoundedRectangle(cornerRadius:10).fill(Color.orange)
            }
        }
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
