//
//  Array+Only.swift
//  Memorize
//
//  Created by LongMa on 2020/12/18.
//  Copyright © 2020 myl. All rights reserved.
//

import Foundation

extension Array{
    var only: Element? {
        if 1 == self.count {
            return first
        }else{
            return nil
        }
    }
}
