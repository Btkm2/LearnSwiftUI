//
//  FlightsModel.swift
//  LearnSwiftUI
//
//  Created by Beket Muratbek on 25.11.2022.
//

import Foundation

struct Flight:Identifiable {
    var id = UUID()
    var departure_city: String
    var arrival_city: String
    var gate: Int
    
    func flightInfo() -> String{
        return departure_city + arrival_city + "\(gate)"
    }
}
