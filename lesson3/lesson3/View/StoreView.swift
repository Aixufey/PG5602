//
//  StoreView.swift
//  lesson3
//
//  Created by Jack Xia on 23/10/2023.
//

import SwiftUI
import CoreData
import MapKit

struct StoreView: View {
    
    // Useful for managing multiple sheet because you may only return one sheet per screen.
    enum SheetState {
        case addStore
        case openingHours(store: Store)
        case none
    }
    @State var isShowingSheet = false
    @State var sheetState = SheetState.none
    @State var isShowingAddStoreView: Bool = false
    @State var isShowingOpeningHours: Bool = false
    
    
    @State var isPresentingDelete: Bool = false
    @State var isDeleting: Bool = false
    
    
    
    // Environment var for App to reference this with .manageObjectContext
    @Environment(\.managedObjectContext) var moc
    
    // When fetching from database, we need to sort it on a type, here we sort by name ascending of collection type FetchedResults
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var stores: FetchedResults<Store>
    
    
    var body: some View {
        
        
        VStack {
            
            // Map takes a closure that returns a View and the item is the object we are passing into map to find the coordinates
            Map(mapRect: .constant(.world),
                annotationItems: stores) { store in
                
                // MapAnnotation returns a View -- Here we can make our own custom marker
                MapAnnotation(coordinate:
                                CLLocationCoordinate2D(latitude: CLLocationDegrees(store.latitude), longitude: CLLocationDegrees(store.longitude))) {
                    
                    HStack {
                        Circle()
                            .fill(.black)
                        Text(store.name ?? "Unknown")
                    }.onTapGesture {
                        print("did tap \(store.name)")
                        sheetState = .openingHours(store: store)
                        isShowingSheet = true
                    }
                }
                
            }
            
            
            ForEach(stores) { store in
                VStack {
                    Text(store.name ?? "N/A")
                }
                
                
            }
            
            Button("Insert store") {
                // Store is auto generated according to Entity Model which we created
                let entity = NSEntityDescription.entity(forEntityName: "Store", in: moc)!
                let store = Store(entity: entity, insertInto: moc)
                store.name = "testbutikk 1"
                store.longitude = 10.31234
                store.latitude = 52.12315
                store.openingHour = Date().description(with: .current)
                
                moc.saveAndPrintError()
                
            } // Button
            
            // Deleting in Core Data
            Button("Delete all") {
                if !stores.isEmpty {
                    isPresentingDelete = true
                }
            }
            
            Button("Add new store") {
                //isShowingAddStoreView = true
                sheetState = .addStore
                // TODO: A tool temporarily waiting 2 seconds before showing the sheet. A bug not assigning it to true.
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isShowingSheet = true
                }
            }
            .buttonStyle(.bordered)
            
        } // VStack
        // Refactored the condition to use enum to manage different cases for sheets
        .sheet(isPresented: $isShowingSheet) {
            switch sheetState {
            case .addStore:
                AddStoreView(isPresented: $isShowingSheet)
                    .onDisappear {
                        print(isShowingAddStoreView)
                    }
            case .openingHours(store: let store):
                Text("\(store.openingHour ?? "Unknown")")
                
                // Detent of a screen 33% size of screen
                    .presentationDetents([.fraction(0.3)])
            case .none:
                EmptyView()
                Text("lol")
                    .presentationDetents([.fraction(0.3)])
            }
        }
        .alert("Do you want to delete", isPresented: $isPresentingDelete) {
            VStack {
                Text("Do you want to delete all?")
                Button("Yes") {
                    // action
                    isDeleting = true
                    if isDeleting {
                        for store in stores {
                            moc.delete(store)
                        }
                        moc.saveAndPrintError()
                    }
                }
                Button("Cancel") {
                    // action
                    isDeleting = false
                }
            }
        }
    } // body
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}


// Extension is extention a custom helper function to the existing NSManagedObjectcontext
// A refactoring of code.
extension NSManagedObjectContext {
    func saveAndPrintError() {
        do {
            try self.save()
        } catch let error {
            print(error)
        }
    }
}
