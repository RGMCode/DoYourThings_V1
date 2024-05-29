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
                Text("DoYourThings")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                VStack {
                    VStack {
                        Text("Priorität: \(doYourThings.dytPriority)")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    }
                    VStack {
                        Text("Thing:")
                            .font(.title)
                            .foregroundColor(.white)
                            .underline()
                        TextEditor(text: $doYourThings.dytTopic)
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50 ,alignment: .leading)
                            .padding(.top, -20)
                            //.disabled(true)
                    }.overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 2)
                    )
                    VStack {
                        Text("Details:")
                            .font(.title)
                            .foregroundColor(.white)
                            .underline()
                        TextEditor(text: $doYourThings.dytDetails)
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 250 ,alignment: .leading)
                            .padding(.top, -20)
                            //.disabled(true)
                    }.overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 2)
                    )
                }.padding()
                Spacer()
                HStack {
                    Button(action:{
                        doYourThingsViewModel.removeDoYourThings(doYourThings: doYourThings)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 50))
                    }.padding()
                    NavigationLink(destination: EditView(doYourThings: $doYourThings)) {
                        Image(systemName: "pencil")
                            .foregroundColor(.teal)
                            .font(.system(size: 50))
                            .bold()
                    }.padding()
                }.padding()
            }
        }.background(Gradient(colors: [.teal, .mint, .green]).opacity(0.6))
         .colorScheme(.light)
         .scrollContentBackground(.hidden)
    }
}

#Preview {
    DoYourThingsDetailView(doYourThings: .constant(DoYourThings(dytTopic: "Sample Topic", dytDetails: "Sample Details", dytPriority: "Normal")))
}
