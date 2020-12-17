//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by LongMa on 2020/12/17.
//  Copyright © 2020 myl. All rights reserved.
//

import Foundation

//Cannot find type 'Element' in scope
//extension Array<Element> where Element: Identifiable{

extension Array where Element: Identifiable{
    func firstIndex(matching element:Element) -> Int? {
        for i in 0..<self.count {
            let lEle = self[i]
            if lEle.id == element.id {
                return i
            }
        }
        return nil
    }
}
