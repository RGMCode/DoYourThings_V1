//
//  DoYourThingsDetailView.swift
//  DoYourThings
//
//  Created by RGMCode on 27.05.24.
//

import SwiftUI

struct DoYourThingsDetailView: View {
    
    @Binding var doYourThings: DoYourThings
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var doYourThingsViewModel: DoYourThingsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("Priorität: \(doYourThings.dytPriority)")
                        .font(.title)
                        .padding()
                    
                    Text("Titel:")
                        .font(.title)
                        .padding()
                    
                    Text(doYourThings.dytTopic)
                        .frame(width: 300)
                        .border(Color.gray)
                        .padding()
                    
                    Text("Details:")
                        .font(.title)
                        .padding()
                    
                    Text(doYourThings.dytDetails)
                        .frame(maxWidth: .infinity, minHeight: 250 ,alignment: .leading)
                        .border(Color.gray)
                        .padding()
                }
                
                HStack {
                    Button(action:{
                        doYourThingsViewModel.removeDoYourThings(doYourThings: doYourThings)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 75))
                    }.padding()
                    
                    NavigationLink(destination: EditView(doYourThings: $doYourThings)) {
                        Image(systemName: "pencil")
                    }
                }
            }
        }.background(Color.teal)
    }
}

#Preview {
    DoYourThingsDetailView(doYourThings: .constant(DoYourThings(dytTopic: "Sample Topic", dytDetails: "Sample Details", dytPriority: "Normal")))
}
