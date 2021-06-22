//
//  CheckoutView.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 21/06/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderManager = OrderManager.getInstance()
    @State private var confirmationMsg = ""
    @State private var showConfirmation = false
    @State private var isProcessingRequest = false
    
    var billText: LocalizedStringKey {
        "Your total bill is $\(orderManager.cost, specifier: "%.2f")"
    }
    
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack (alignment: .center) {
                    VStack {
                        Image("cupcakes")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geo.size.width)
                        Text(billText)
                            .padding()
                            .font(.title)
                        
                    }
                    Spacer(minLength: 100)
                    Button (action: checkoutOrder,
                    label: {
                        SubmitButtonView("Checkout")
                    }).disabled(isProcessingRequest)
                        .colorMultiply(isProcessingRequest ? Color.secondary : Color(red: 1, green: 1, blue: 1))
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
        .alert(isPresented: $showConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMsg), dismissButton: .default(Text("OK")))
        }
    }
    
    func showConfirmationMessage(_ order: OrderManager) {
        let quantity = order.quantity
        let type = OrderManager.types[order.type].lowercased()
        
        var specialOrder = "with "
        
        if order.extraFrosting {
            specialOrder += "extra frosting"
        }
        
        if order.addSprinkles {
            specialOrder += order.extraFrosting ? " and " : ""
            specialOrder += "sprinkles"
        }
        
        let isSpecialOrder = order.extraFrosting || order.addSprinkles
        
        confirmationMsg = "Your order for \(quantity) \(type) cupcakes\(isSpecialOrder ? specialOrder : "") is on it's way"
        showConfirmation = true
        isProcessingRequest.toggle()
    }
    
    func setupUrlRequest(_ url: URL, data: Data) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = data
        return request
    }
    
    func runSessionTask(_ request: URLRequest) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(OrderManager.self, from: data) {
                showConfirmationMessage(decodedOrder)
            } else {
                print("Invalid response recieved")
            }
        }.resume()
    }
    
    func checkoutOrder() {
        guard let encoded = try? JSONEncoder().encode(orderManager) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        let request = setupUrlRequest(url, data: encoded)
        isProcessingRequest.toggle()
        runSessionTask(request)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
