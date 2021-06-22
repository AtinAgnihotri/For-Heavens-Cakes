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
    @State private var showingConfirmation = false
    @State private var isProcessingRequest = false
    
    var billText: LocalizedStringKey {
        "Your total bill is $\(orderManager.order.cost, specifier: "%.2f")"
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
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(alertMsg), dismissButton: .default(Text("OK"))  {
                isProcessingRequest.toggle()
            })
        }
    }
    
    func showAlert(title: String, message: String) {
        alertTilte = title
        alertMsg = message
        showingConfirmation = true
//        isProcessingRequest.toggle()
    }
    
    func showConfirmation(_ message: String) {
        showAlert(title: "Thank you!", message: message)
    }
    
    func showError(_ error: String) {
        print(error)
        showAlert(title: "Error!", message: error)
    }

    func checkoutOrder() {
        isProcessingRequest.toggle()
        orderManager.submitOrder(confirmAction: showConfirmation, errorAction: showError)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
