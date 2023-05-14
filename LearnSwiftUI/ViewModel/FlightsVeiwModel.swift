//
//  FlightsVeiwModel.swift
//  LearnSwiftUI
//
//  Created by Beket Muratbek on 25.11.2022.
//

import Foundation
import CoreData
import SwiftUI

class FlightsViewModel: ObservableObject,Identifiable {
    @Published var flights: [Flight] = []
    @Published var savedEntities: [FlightEntity] = []
    let container: NSPersistentContainer
    
    func addFlight(departure_city: String, arrival_city: String, gate: Int) {
        flights.append(Flight(departure_city: departure_city, arrival_city: arrival_city, gate: gate))
    }
    
//    [weak self] in
    func showFlighst() -> String{
        return "\(flights)"
        
    }
    
    init() {
        print("initialized")
//        print(showFlighst())
        container = NSPersistentContainer(name: "TestContainer")
        container.loadPersistentStores{ (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA: \(error)")
            }else {
                print("SUCCESSFULLY LOADED CORE DATA")
            }
        }
    }
    
    deinit {
        print("deinitialized")
    }
    
    func fetchFlights() {
        let request = NSFetchRequest<FlightEntity>(entityName: "FlightEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addFlight(id: UUID,departure_city: String, arrival_city: String, gate: Int64) {
        let newFlight = FlightEntity(context: container.viewContext)
        newFlight.id = id
        newFlight.departure_city = departure_city
        newFlight.arrival_city = arrival_city
        newFlight.gate = gate
        saveFlight()
    }
    
    func saveFlight() {
        do {
            try container.viewContext.save()
            fetchFlights()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func updateFlight(entity: FlightEntity) {
        
    }
    
    func deleteFlight(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveFlight()
    }
}
