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
    var body: some View {//some View，任意视图。：代表表现的像xx
        
        //content:参数是代码块
        return
            HStack{
                ForEach(0..<4, content: {index in
                    
                    //todo:why cannot print
//                    print(index)
                    Cardview()
                })
            }
            .foregroundColor(Color.orange)
            .padding()
        //在外面写的方法会作用于整个代码块
    }
}

struct Cardview: View {
    var isFaceUp = false
    var body: some View{
        ZStack{
            if(isFaceUp){
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                
                //cmd+ctrl+space,调出emoji
                Text("👻").font(Font.largeTitle)
            }else{
                RoundedRectangle(cornerRadius: 10).fill(Color.orange)
            }
            
        }
    }
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
