//
//  ShippingAddressView.swift
//  lesson3
//
//  Created by Jack Xia on 13/11/2023.
//

import SwiftUI

class ShippingAddressViewModel: ObservableObject {
    
    let apiClient = APIClient.demo
    
    // Casting state to Views who can listen to this state
    @Published var welcomeText = "Hello World!"
    @Published var address = ""
    @Published var postCode = ""
    
    @Published var isShowingError = false
    
    fileprivate var anotherText = "Private Text still accessible from this file!"
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.welcomeText = "Hello Sparrow"
        }
    }
    func didTapSubmitButton() {
        print(address)
        self.postCode = postCode
        self.welcomeText = address
        
        Task {
            do {
                try await apiClient.updateAddress(address, postCode)
                // Return back to screen ?
            } catch let error {
                print(error)
                isShowingError = true
            }
        }
    }
}

struct ShippingAddressView: View {
    @StateObject var viewModel = ShippingAddressViewModel()
    @State var helloText = "Hello World"
    
    var body: some View {
        
        VStack {
            Form {
                TextField("Address", text: $viewModel.address)
                TextField("Postal code", text: $viewModel.postCode)
            }
            Text(viewModel.welcomeText)
            Text(viewModel.anotherText)
            
            Button {
                viewModel.didTapSubmitButton()
            } label: {
                Text("Submit")
            }
            
        }.onAppear {
            viewModel.onAppear()
        }.alert("Error happened", isPresented: $viewModel.isShowingError) {
            
        } message: {
            
        }
    }
}

struct ShippingAddressView_Previews: PreviewProvider {
    static var previews: some View {
        ShippingAddressView()
    }
}
