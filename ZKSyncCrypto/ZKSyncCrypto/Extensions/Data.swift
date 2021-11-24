//
//  Data.swift
//  ZKSyncCrypto
//
//  Created by Maksim Makhun on 11/19/21.
//  Copyright © 2021 sirintellect. All rights reserved.
//

import Foundation

extension Data {
    
    init<T>( value: inout T, count: Int) {
        self = withUnsafePointer(to: &value) { (pointer: UnsafePointer<T>) -> Data in
            return Data(buffer: UnsafeBufferPointer(start: pointer, count: count))
        }
    }
}
