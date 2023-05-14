//
//  ContentView.swift
//  LearnSwiftUI
//
//  Created by Beket Muratbek on 25.11.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var departure = ""
    @State private var arrival = ""
    @State private var gate: Int64 = 0
    @State var sometext = ""
//    @StateObject private var flights = Flight()
    @State var flightsarr: [Flight] = [Flight(id: UUID(),departure_city: "Alamaty",arrival_city: "Astana",gate: 2)]
    @ObservedObject var flights: FlightsViewModel
//    let temp: UIView = deinit
    @State var isPressed = false
    var body: some View {
        VStack {
            NavigationView {
//                List {
//                    Button(action: {
//
//                    }, label: {
//                        Text("Hi")
//                    })
//                }
                List {
                    Section(header: Text("Flight info")) {
                        TextField("Departure City", text: $departure)
                        TextField("Arrival City", text: $arrival)
                        TextField("Gate", value: $gate, formatter: NumberFormatter())
                    }
                    
                    Button (action: {
                        if !departure.isEmpty && !arrival.isEmpty && !(gate == 0) {
                            flights.addFlight(departure_city: departure, arrival_city: arrival, gate: Int(exactly: gate)!)
                            isPressed = true
                            DispatchQueue.main.async {
                                let id = UUID()
                                flights.addFlight(id: id ,departure_city: departure, arrival_city: arrival, gate: gate)
                            }
                        }
                    }, label: {
                        Text("Add flight")
                    })
                    
                    Text("hello")
                }
                
            }.navigationTitle("Flights")
                .navigationBarTitleDisplayMode(.inline)
        }
//        .onAppear(){
//            MainView()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject private static var flights = FlightsViewModel()
    static var previews: some View {
        ContentView(flights: flights)
    }
}
