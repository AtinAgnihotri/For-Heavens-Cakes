//
//  OrderManager.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 20/06/21.
//

import Foundation

final class OrderManager: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case type
        case quantity
        case addSprinkles
        case extraFrosting
        case name
        case streetAddress
        case city
        case pinCode
    }
    
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        pinCode = try container.decode(String.self, forKey: .pinCode)
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(pinCode, forKey: .pinCode)
    }
}
