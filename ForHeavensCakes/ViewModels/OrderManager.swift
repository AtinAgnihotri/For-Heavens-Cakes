//
//  OrderManager.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 20/06/21.
//

import Foundation

final class OrderManager: ObservableObject {
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var order = OrderModel()
    
    static var instance = OrderManager()
    
    private init() {

    }
    
    static func getInstance() -> OrderManager {
        self.instance
    }
    
    private func sanitizeOrderManagerData() {
        order.name = order.name.trimmingCharacters(in: .whitespacesAndNewlines)
        order.city = order.city.trimmingCharacters(in: .whitespacesAndNewlines)
        order.streetAddress = order.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        order.pinCode = order.pinCode.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func setupUrlRequest(_ url: URL, data: Data) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = data
        return request
    }
    
    private func showConfirmationMessage(_ order: OrderModel, confirmAction: (String) -> ()) {
        let quantity = order.quantity
        let type = OrderManager.types[order.type].lowercased()
        
        var specialOrder = " with "
        
        if order.extraFrosting {
            specialOrder += "extra frosting"
        }
        
        if order.addSprinkles {
            specialOrder += order.extraFrosting ? " and " : ""
            specialOrder += "sprinkles"
        }
        
        let isSpecialOrder = order.extraFrosting || order.addSprinkles
        
        confirmAction("Your order for \(quantity) \(type) cupcakes\(isSpecialOrder ? specialOrder : "") is on it's way")
    }
    
    private func runSessionTask(_ request: URLRequest, confirmAction: @escaping (String) -> (), errorAction: @escaping (String) -> ()) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                errorAction("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(OrderModel.self, from: data) {
                self.showConfirmationMessage(decodedOrder, confirmAction: confirmAction)
            } else {
                errorAction("Invalid response recieved")
            }
        }.resume()
    }
    
    func submitOrder(confirmAction : @escaping (String) -> (), errorAction: @escaping (String) -> ()) {
        sanitizeOrderManagerData()
        
        guard let encoded = try? JSONEncoder().encode(order) else {
            errorAction("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        let request = setupUrlRequest(url, data: encoded)
        runSessionTask(request, confirmAction: confirmAction, errorAction: errorAction)
        
    }
}
