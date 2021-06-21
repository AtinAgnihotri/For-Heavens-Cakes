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
                        Picker("Cupcake Flavor", selection: $orderManager.type) {
                            ForEach(0..<OrderManager.types.count) {
                                Text("\(OrderManager.types[$0])")
                            }
                        }
                        .pickerStyle(InlinePickerStyle())
                        .scaledToFit()
                    }
                    Section(header: Text("Number of cupcakes")
                                .font(.headline)) {
                        Stepper(value: $orderManager.quantity, in: 1...20) {
                            Text("\(orderManager.quantity)")
                                .padding()
                                .font(.title)
                        }
                    }
                    Section(header: Text("Special Requests")
                                .font(.headline)) {
                        Toggle(isOn: $orderManager.specialRequestsEnabled.animation()) {
                            Text("Any special requests?")
                        }
                        if orderManager.specialRequestsEnabled {
                            Toggle(isOn: $orderManager.extraFrosting) {
                                Text("Extra frosting?")
                            }
                            Toggle(isOn: $orderManager.addSprinkles) {
                                Text("Add sprinkles?")
                            }
                        }
                    }
                    
                   
                }
                
                NavigationLink(
                    destination: AddressView(),
                    label: {
                        HStack {
                            Spacer()
                            Text("Address Details")
                                .foregroundColor(Color.accentColor)
                                .font(.title)
                                .bold()
                            Spacer()
                        }
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
