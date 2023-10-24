//
//  AddStoreView.swift
//  lesson3
//
//  Created by Jack Xia on 24/10/2023.
//

import SwiftUI
import CoreData

struct AddStoreView: View {
    // This Binding is like props in React that Parent can send a setter into Child component to alter the state
    // Here we will set isPresented to False and Parent can close a sheet or this View
    var isPresented: Binding<Bool>
    init(isPresented: Binding<Bool>) {
        self.isPresented = isPresented
    }
    // Internal enum for this View where we will be using array to include all possible errors
    // Then using extensions to customise each error messages. To access this enum using AddStoreView.FormError
    enum FormError: String, Error {
        case missingName
        case missingLongitude
        case missingLatitude
        case missingOpeningHours
        case longitudeWrongFormat
        case latitudeWrongFormat
        
        var localizedName: String {
            switch self {
            case .missingName:
                return "Store name"
            case .missingLongitude:
                return "Longitude"
            case .missingLatitude:
                return "Latitude"
            case .longitudeWrongFormat:
                return "Wrong format longitude"
            case .latitudeWrongFormat:
                return "Wrong format latitude"
            case .missingOpeningHours:
                return "Opening hours"
            }
        }
    }
    
    @Environment(\.managedObjectContext) var moc
    @State var storeName: String =  ""
    @State var longitude: String = ""
    @State var latitude: String = ""
    @State var openingHours: String = ""
    
    @State var isShowingError = false
    @State var validationErrors = [FormError]() // Making a state of errors array of type enum FormErrors
    
    func didTapSaveButton() {
        var errors = [FormError]()
        if storeName.isEmpty {
            errors.append(.missingName)
        }
        if longitude.isEmpty {
            errors.append(.missingLongitude)
        }
        if latitude.isEmpty {
            errors.append(.missingLatitude)
        }
        if openingHours.isEmpty {
            errors.append(.missingOpeningHours)
        }
        
        // A premise with guard this to be float, needs return
        guard let longitude = Float(longitude) else {
            errors.append(.longitudeWrongFormat)
            isShowingError = true
            validationErrors = errors
            return
        }
        guard let latitude = Float(latitude) else {
            errors.append(.latitudeWrongFormat)
            isShowingError = true
            validationErrors = errors
            return
        }
        
        if errors.isEmpty {
            // Save state - referring to Model Entity "Store2"
            
            let entityDescription =
            NSEntityDescription.entity(forEntityName: "Store", in:
                                        moc)!
            let store = Store(entity: entityDescription, insertInto: moc)
            store.name = storeName
            store.longitude = longitude
            store.latitude = latitude
            
            // save
            moc.saveAndPrintError()
            
            // Setting state to False to close this View/Sheet
            self.isPresented.wrappedValue = false
            
        } else {
            // Show errors
            isShowingError = true
            validationErrors = errors   // fill array with appended occurring errors
        }
        
    }
    
    var body: some View {
        Form {
            
            Section("Create Store") {
                TextField("Name", text: $storeName)
                TextField("Longitude", text: $longitude)
                TextField("Latitude", text: $latitude)
                TextField("Opening hours", text: $openingHours)
            }
            
            Section {
                Button("Save") {
                    didTapSaveButton()
                }
            }
        }
        .autocorrectionDisabled()
        .alert(isPresented: $isShowingError) {
            Alert(title: Text("Missing fields: "),
                  message: Text("\(validationErrors.text)"))
        }
    }
}

struct AddStoreView_Previews: PreviewProvider {
    static var previews: some View {
        AddStoreView(isPresented: .constant(true))
    }
}

// We can get the scope by extending  AddStoreView.FormError's Array with text and loop through
// with closure and applying each existing appearing error text from "localizedName"
private extension Array where Element == AddStoreView.FormError{
    var text: String {
        var text = ""
        self.forEach {error in
            text += error.localizedName
            text += "\n"
        }
        return text
    }
}
