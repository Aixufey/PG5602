//
//  ContactVerticalListView.swift
//  exe3
//
//  Created by Jack Xia on 06/09/2023.
//

import SwiftUI

struct ContactVerticalListView: View {
    
    let contacts: [Contact]
    
    var body: some View {
        
        List {
            
            ForEach(contacts) {ele in
                // Route to a new "view"
                NavigationLink {
                    VStack {
                        Text(ele.firstName)
                        Text(ele.lastName)
                    }
                    // label = placeholder for each rows in the list
                } label: {
                    
                    ContactRowView(contact: ele)
                    
                    
                } // label
            } // foreach
        } // list
    }
}

struct ContactVerticalListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactVerticalListView(contacts: [Contact(firstName: "", lastName: "")])
    }
}
