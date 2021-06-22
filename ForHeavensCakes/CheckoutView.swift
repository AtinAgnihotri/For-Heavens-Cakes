//
//  CheckoutView.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 21/06/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderManager = OrderManager.getInstance()
    @State private var alertMsg = ""
    @State private var alertTilte = ""
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
            Alert(title: Text("Thank you!"), message: Text(alertMsg), dismissButton: .default(Text("OK")))
        }
    }
    
    func showAlert(title: String, message: String) {
        alertTilte = title
        alertMsg = message
        showConfirmation = true
        isProcessingRequest.toggle()
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
        
        let msg = "Your order for \(quantity) \(type) cupcakes\(isSpecialOrder ? specialOrder : "") is on it's way"
        showAlert(title: "Thank you!", message: msg)
    }
    
    func setupUrlRequest(_ url: URL, data: Data) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = data
        return request
    }
    
    func showError(_ error: String) {
        print(error)
        showAlert(title: "Error!", message: error)
    }
    
    func runSessionTask(_ request: URLRequest) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                let errorMsg = "No data in response: \(error?.localizedDescription ?? "Unknown error")"
                showError(errorMsg)
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(OrderManager.self, from: data) {
                showConfirmationMessage(decodedOrder)
            } else {
                let errorMsg = "Invalid response recieved"
                showError(errorMsg)
            }
        }.resume()
    }
    
    func checkoutOrder() {
        guard let encoded = try? JSONEncoder().encode(orderManager) else {
            let errorMsg = "Failed to encode order"
            showError(errorMsg)
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
