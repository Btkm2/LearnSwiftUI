//
//  ParentView.swift
//  LearnSwiftUI
//
//  Created by Beket Muratbek on 25.11.2022.
//

import SwiftUI

struct ParentView: View {
    var sometext = "Hello from parent!"
    @State var isPresent = false
    @EnvironmentObject var flights: FlightsViewModel
    var body: some View {
//        VStack {
//            Text("Hello, World!")
//            Button (action: {
//                isPresent = true
//            }, label: {
//                Text("To the child")
//            })
//        }.sheet(isPresented: $isPresent,onDismiss: .none){
//          ContentView(sometext: sometext)
//        }
        TabView {
            SomeView().tabItem({
                VStack {
                    Image(systemName: "house.fill")
                    Text("Main")
                }
            })
//            ContentView().tabItem({
//                VStack {
//                    Image(systemName: "house")
//                    Text("Home")
//                }
//            }).accentColor(Color.green)
//            MainView(flights: $flights).tabItem({
            MainView(flights: _flights).tabItem({
                VStack {
                    Image(systemName: "airplane")
                    Text("All flights")
                }
            })
            ChartView().tabItem({
                VStack {
                    Image(systemName: "chart.bar")
                    Text("Bar")
                }
            })
        }.accentColor(Color.indigo)
    }
}

struct ParentView_Previews: PreviewProvider {
    static let tempObject = FlightsViewModel()
    static var previews: some View {
        ParentView()
            .environmentObject(tempObject)
    }
}

struct SomeView: View {
    var body: some View {
        VStack {
            Rectangle().frame(width: 1, height: 40).rotationEffect(Angle(degrees: 30.0))
            Rectangle().frame(width: 1, height: 40)
        }
    }
}

struct MainView: View {
    @EnvironmentObject var flights: FlightsViewModel
//    @State var flights = FlightsViewModel()
    @State var isPresent = false
    var body: some View {
        List {
            HStack {
                Text("Flights")
                Button (action: {
                    isPresent = true
                }, label: {
                    Text("Add flight")
                })
            }
            ForEach(flights.savedEntities) { entity in
                Text("Departure :\(entity.departure_city ?? "Error depart")" + "\n" + "Arrival: \(entity.arrival_city ?? "Error arrv")")
//                    .onTapGesture(count: <#T##Int#>, perform: <#T##() -> Void#>)
//                Text("Arrival :\(entity.arrival_city ?? "Error arrv")")
            }
            .onDelete(perform: flights.deleteFlight)
            Text("\(flights.savedEntities.count)")
        }
        .sheet(isPresented: $isPresent) {
            ContentView(flights: flights)
                .accentColor(Color.green)
                .onDisappear(perform: {
                    //
                })
            Button(action: {
                DispatchQueue.global(qos: .userInteractive).async {
                    isPresent = false
                }
            }, label: {
                VStack {
                    Image(systemName: "x.circle")
                    Text("close")
                }
            })
        }
        //MARK: .fullScreenCover
    }
}
