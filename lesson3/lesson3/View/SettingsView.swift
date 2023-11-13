//
//  SettingsView.swift
//  lesson3
//
//  Created by Jack Xia on 18/09/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @State var isShowingOpenURLAlert = false
    
    // Getting this from ProfileView
    @AppStorage(AppStorageKeys.username.rawValue) var username: String?
    
    func onAppear() {
        
    }
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    ProfileView()
                } label: {
                    HStack {
                        
                        Text("Min profil")
                        Spacer()
                        if let username = username {
                            Text(username)
                        } else {
                            Text("Du må logge inn")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Button.init("Kontakt oss") {
                    isShowingOpenURLAlert = true
                }
                
                NavigationLink {
                    ShippingAddressView()
                } label: {
                    Text("Shipping address")
                }
            }
            .navigationTitle("Instillinger")
            
        }.alert("Denne linken tar deg ut av appen", isPresented: $isShowingOpenURLAlert) {
            VStack {
                Text("Vil du åpne i nettleser?")
                Button("Ok") {
                    let url = URL.init(string: "https://kappahl.no/kontakt")!
                    UIApplication.shared.open(url)
                }
                Button("Avbryt") {}
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
