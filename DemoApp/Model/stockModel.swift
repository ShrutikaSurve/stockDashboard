//
//  stockModel.swift
//  DemoApp
//
//  Created by Shrutika Surve on 26/09/21.
//

import Foundation


class Stock{
    var title: String?

    var value1: Double?

    var value2: Double?
   
    var value3 : Double?
   
    var value4 : Double?

    var stockKey : String?
   
    required init (arr : [Substring])
    {
        self.title = String(arr[0])
        self.value1 = Double(arr[1])
        self.value2 = Double(arr[2])
        self.value3 = Double(arr[3])
        self.value4 = Double(arr[4])
        self.stockKey = String(arr[5])
    }
}
