//
//  ContentView.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 20/06/21.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject private var orderManager = OrderManager.getInstance()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Flavors")
                                .font(.headline)) {
                        Picker("Cupcake Flavor", selection: $orderManager.order.type) {
                            ForEach(0..<OrderManager.types.count) {
                                Text("\(OrderManager.types[$0])")
                            }
                        }
                        .pickerStyle(InlinePickerStyle())
                        .scaledToFit()
                    }
                    Section(header: Text("Number of cupcakes")
                                .font(.headline)) {
                        Stepper(value: $orderManager.order.quantity, in: 1...20) {
                            Text("\(orderManager.order.quantity)")
                                .padding()
                                .font(.title)
                        }
                    }
                    Section(header: Text("Special Requests")
                                .font(.headline)) {
                        Toggle(isOn: $orderManager.order.specialRequestsEnabled.animation()) {
                            Text("Any special requests?")
                        }
                        if orderManager.order.specialRequestsEnabled {
                            Toggle(isOn: $orderManager.order.extraFrosting) {
                                Text("Extra frosting?")
                            }
                            Toggle(isOn: $orderManager.order.addSprinkles) {
                                Text("Add sprinkles?")
                            }
                        }
                    }
                    
                   
                }
                
                NavigationLink(
                    destination: AddressView(),
                    label: {
                        SubmitButtonView("Address Details")
                    })
                
                Spacer()
            }.navigationBarTitle("For Heaven's Cakes")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
