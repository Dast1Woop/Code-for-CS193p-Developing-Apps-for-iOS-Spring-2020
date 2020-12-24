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
            
            //当函数没有参数时，()也可以省略
            
            //尾调闭包写法更简洁
//            HStack {
//
//                //content:参数是闭包
//                ForEach(self.viewModel.cards){card in
//
//                    //just cannot print or 声明var in viewBuilder！
//                    //                    print(index)
//                    Cardview(card: card)
//                        .aspectRatio(2/3, contentMode: .fit)
//                        .onTapGesture(perform: {
//                        self.viewModel.chooseCard(card: card)
//                    })
//                }
//            }
//            .padding()
//            .foregroundColor(Color.orange)
        
        //自定义布局
            //GridView未支持泛型时：
            //Could not cast value of type 'SwiftUI.ModifiedContent<Memorize.Cardview, SwiftUI.AddGestureModifier<SwiftUI._EndedGesture<SwiftUI.TapGesture>>>' (0x7fe09b81e640) to 'Memorize.Cardview' (0x10565d910).
//            GridView(self.viewModel.cards){ card in
//                Cardview(card: card)
//                    .aspectRatio(2/3, contentMode: .fit)
//                    .onTapGesture(perform: {
//                        self.viewModel.chooseCard(card: card)
//                    }) as! Casrdview
//            }
//            .padding()
        
            //正解：修正GridView支持泛型，修正初始化方法中func返回视图为泛型。此后，可以不写 as! Cardview 了，运行也不会报错了。
            GridView(self.viewModel.cards){ card in
                Cardview(card: card)
                    .padding(5)
//                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture(perform: {
                        self.viewModel.chooseCard(card: card)
                    })
            }
           
        
        //在外面写的方法会作用于整个代码块
    }
}

struct Cardview: View {
    var card: MemoryGameM<String>.Card
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                if !card.isMatched{
                    if(card.isFaceUp){
                        
                        //                不能在 viewbuilder 中声明再使用变量，必须放在 viewbuilder 外面，最好是 body 闭包外面
                        //                var x = 1
                        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                        
                        //cmd+ctrl+space,调出emoji
                        Text(card.content).font(cardContentFont(size: geometry.size))
                    }else{
                        RoundedRectangle(cornerRadius:cornerRadius).fill(Color.orange)
                    }
                }else{
                    RoundedRectangle(cornerRadius:cornerRadius).fill(Color.white)
                    Text("✔").font(cardContentFont(size: geometry.size))
                }
            }
        }
    }
    
    //MARK: constants
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 3
    
    func cardContentFont(size:CGSize)->Font{
        return Font.system(size: 0.75 * min(size.width, size.height))
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
