//
//  ContentView.swift
//  ForHeavensCakes
//
//  Created by Atin Agnihotri on 20/06/21.
//

import SwiftUI

class User: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "User TestUser"
    
    required init(from decoder: Decoder) throws {
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        name = try containter.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
