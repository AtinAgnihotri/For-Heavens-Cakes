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
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var pinCode = ""
    
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
    
    var cost: Double{
        var costPerCupcake = 2.0 // Basic cost of cupcake
        costPerCupcake += extraFrosting ? 1 : 0 // Charge for extra frosting per cupcake
        costPerCupcake += addSprinkles ? 0.5 : 0 // Charge for adding sprinkles per cupcake
        
        // Extra charge for type of cupcake in ascending order
        let chargePerType = Double(type) / 2 // Vanilla: 0, Strawberry: 1, Chocolate: 1.5, Rainbow: 2
        
        return (chargePerType + (costPerCupcake * Double(quantity)))
    }
}
