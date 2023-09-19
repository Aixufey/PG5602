//
//  ProfileView.swift
//  lesson3
//
//  Created by Jack Xia on 19/09/2023.
//

import SwiftUI

enum AppStorageKeys: String {
    case username
}


struct ProfileView: View {
    
    //@AppStorage(AppStorageKeys.username.rawValue) var username: String?
    @State var username: String?
    
    // @Binding var isLoggedIn: Bool -> use when inside View
    // var isLoggedIn: Binding<Bool> { } -> use Type casting inside constructor for instance init to accept from across views
    @State var isLoggedIn: Bool = false
    
    @State var isShowingAlert: Bool = false
    
    func onAppear() {
        // Protocol for AppStorage: Check if logged in
        // UserDefault is a database with k/v pairs but we have to explicit cast to String when data is saved on disk then reload it back as .. ?
        if let username = UserDefaults.standard.object(forKey: AppStorageKeys.username.rawValue) as? String {
            self.username = username
        }
        //print(username as Any)
    }
     
    func createUserTapped() {
        print("inside")
        if username != "" {
            print("created")
            UserDefaults.standard.setValue(username, forKey: AppStorageKeys.username.rawValue)
            isLoggedIn = true
        } else {
            isShowingAlert = true
        }
    }
    
    func deleteUserTapped() {
        // print("Delete tapped")
        UserDefaults.standard.removeObject(forKey: AppStorageKeys.username.rawValue)
        username = nil
        isLoggedIn = false
    }
    
    var body: some View {
        // Binding does not accept String values, but we can use get and set to return string val
        VStack {
            TextField("Brukernavn", text: Binding(get: {
                
                // Binding username if exist
                if let username = username {
                    return username
                }
                // Else return empty string
                return ""
                
            }, set: { newValue, transaction in
                // Set value to username
                username = newValue
            }))
            .border(.black, width: 1)
            .padding(.horizontal, 50)
            .textFieldStyle(.roundedBorder)
            
            
            Button("Opprett bruker") {
                // print("username is nil on load:\($username.wrappedValue)")
                if username != nil {
                    createUserTapped()
                } else {
                    // print("username is nil")
                    isShowingAlert = true
                }
            }
            .alert("Username is empty", isPresented: $isShowingAlert) {
                Button("OK") {}
            }
            .padding()
            
            
            if username != nil {
                Button("Slett bruker") {
                    deleteUserTapped()
                }.padding()
            }
            
        }
        .alert("Username cannot be empty", isPresented: $isShowingAlert) {
            Button("OK") {}
        }
        .onAppear {
            onAppear()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
