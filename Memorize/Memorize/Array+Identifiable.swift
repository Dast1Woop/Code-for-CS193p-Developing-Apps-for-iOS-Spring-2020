//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by LongMa on 2020/12/17.
//  Copyright © 2020 myl. All rights reserved.
//

import Foundation

//Cannot find type 'Element' in scope！！！
//extension Array<Element> where Element: Identifiable{

extension Array where Element: Identifiable{
    
    //Element:swift 自定义的占位符，不是所有的 Element 都能被 T 代替，比如此处
    func firstIndex(matching element:Element?) -> Int? {
        if let element = element{
            for i in 0..<self.count {
                let lEle = self[i]
                if lEle.id == element.id {
                    return i
                }
            }
        }
     
        return nil
    }
}
