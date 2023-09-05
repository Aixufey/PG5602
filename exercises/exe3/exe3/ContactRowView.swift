//
//  LabelView.swift
//  exe3
//
//  Created by Jack Xia on 05/09/2023.
//

import SwiftUI

struct ContactRowView: View {

    // Field contact of type Contact to send into this struct from navigation link label part.
    var contact: Contact
   
    
    var body: some View {
        HStack {
            Image("coder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .clipShape(Rectangle())
                .overlay(Rectangle()
                    .stroke(Color.black, lineWidth: 2))
            HStack {
                VStack {
                    HStack {
                        Text(contact.firstName)
                        Text(contact.lastName)
                        
                        Spacer()
                    }
                    //                                    .border(Color.red, width: 2)
                    
                    HStack {
                        HStack {
                            Text(contact.description ?? "")
                                .font(.system(size: 12, weight: .light)).italic()
                        }
                        //                                        .border(Color.blue, width: 2)
                        .padding(.trailing)
                        
                        Spacer()
                    }
                    
                    
                }
                //                                .border(Color.green, width: 2)
                .padding(.trailing)
                
            }
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
            
        } // label HStack
        .padding(5)
    }
}

struct ContactRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContactRowView(contact: Contact(firstName: "test", lastName: "test"))
    }
}
