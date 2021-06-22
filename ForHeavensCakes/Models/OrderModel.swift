//
//  OrderModel.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 22/06/21.
//

import Foundation

struct OrderModel: Codable {
    
    var type = 0
    var quantity = 3
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var pinCode = ""
    var extraFrosting = false
    var addSprinkles = false
    
    var specialRequestsEnabled = false {
        didSet {
            if specialRequestsEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
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


