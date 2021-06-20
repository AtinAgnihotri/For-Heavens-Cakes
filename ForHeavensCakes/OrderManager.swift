//
//  OrderManager.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 20/06/21.
//

import Foundation

class OrderManager: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestsEnabled = false {
        didSet {
            if specialRequestsEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    static var instance = OrderManager()
    
    private init() {
        
    }
    
    static func getInstance() -> OrderManager {
        self.instance
    }
}
