//
//  ProfileView.swift
//  lesson3
//
//  Created by Jack Xia on 19/09/2023.
//

import SwiftUI
import KeychainSwift

enum AppStorageKeys: String {
    case username
    case password
}

enum AlertMessage: String {
    case usernameEmpty = "Character must be greater than 5"
    case passwordEmpty = "Password is empty"
}

struct ProfileView: View {
    
    //@AppStorage(AppStorageKeys.username.rawValue) var username: String?
    @State var username: String?
    @State var password = ""
    
    // @Binding var isLoggedIn: Bool -> use when inside View
    // var isLoggedIn: Binding<Bool> { } -> use Type casting inside constructor for instance init to accept from across views
    @State var isLoggedIn: Bool = false
    
    @State var isShowingAlert: Bool = false
    @State var _alertMessage: AlertMessage = .usernameEmpty
    
    func onAppear() {
        // Protocol for AppStorage: Check if logged in
        // UserDefault is a database with k/v pairs but we have to explicit cast to String when data is saved on disk then reload it back as .. ?
        if let username = UserDefaults.standard.object(forKey: AppStorageKeys.username.rawValue) as? String {
            self.username = username
        }
        
        let keychain = KeychainSwift()
        if let password = keychain.get(AppStorageKeys.password.rawValue) {
            self.password = password
        }
        print(username as Any)
    }
    
    func createUserTapped() {
        print("inside")
        
        // using package keychain
        let keychain = KeychainSwift()
        keychain.set(password, forKey: AppStorageKeys.password.rawValue)
        
        
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
        let keychain = KeychainSwift()
        keychain.delete(AppStorageKeys.password.rawValue)
        keychain.clear() // wipe all from iCloud keychain
        
        username = nil
        password = ""
        isLoggedIn = false
    }
    
    var body: some View {
        // Binding does not accept String values, but we can use get and set to return string val
        VStack {
            Form {
                TextField("Brukernavn", text: Binding(get: {
                    
                    // Binding username if exist
                    if let username = username {
                        return username
                    }
                    // Else return empty string
                    return ""
                    
                }, set: { newValue, transaction in
                    // Set value to username
                    username = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
                }))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                
                // Password
                SecureField("Passord", text: $password)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    
                
//                Button("Opprett bruker") {
//                    // print("username is nil on load:\($username.wrappedValue)")
//                    if username != nil, username != "", username!.count > 5 {
//                        createUserTapped()
//                    } else {
//                        // print("username is nil")
//                        username = nil
//                        print(username as Any)
//                    }
//                    isShowingAlert = true
//                }
//                .padding()
                
                
                // username != nil, !username!.isEmpty,
                if UserDefaults.standard.object(forKey: AppStorageKeys.username.rawValue) != nil {
                    Button("Slett bruker") {
                        deleteUserTapped()
                    }.padding()
                }
            } // Form
            Button("Opprett bruker") {
                // print("username is nil on load:\($username.wrappedValue)")
                if username != nil, username != "", username!.count >= 5, password != "" {
                    createUserTapped()
                } else if username == nil || username == "" || username!.count < 5 {
                    // print("username is nil")
                    print(username as Any)
                    isShowingAlert = true
                    self._alertMessage = .usernameEmpty
                } else {
                    self._alertMessage = .passwordEmpty
                    isShowingAlert = true
                }
            }
            .padding()
            
        } // vstack
        .onAppear {
            onAppear()
            
        }
        .alert("\(_alertMessage.rawValue)", isPresented: $isShowingAlert) {
            Button("OK") {
                isShowingAlert = false
                //username = nil
                password = ""
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
