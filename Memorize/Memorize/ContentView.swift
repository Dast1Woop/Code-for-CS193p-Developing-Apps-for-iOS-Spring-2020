//
//  ContentView.swift
//  Memorize
//
//  Created by LongMa on 2020/11/17.
//  Copyright © 2020 myl. All rights reserved.
//

import SwiftUI


/// 紫色：系统关键字，蓝色：系统类型，绿色：自定义变量名
struct ContentView: View {
    var body: some View {
        return ZStack{
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
//                .foregroundColor(Color.blue)
            Text("👻").font(Font.largeTitle)
//            Text("test")
        }.foregroundColor(Color.orange)
            .padding()
        //cmd+ctrl+space,调出emoji
    }
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
