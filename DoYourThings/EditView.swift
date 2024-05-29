//
//  EditView.swift
//  DoYourThings
//
//  Created by RGMCode on 28.05.24.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var doYourThingsViewModel: DoYourThingsViewModel
    @Binding var doYourThings: DoYourThings
    @State private var dytTopic: String
    @State private var dytDetails: String
    @State private var dytPriority: String
    let priority = ["Hoch", "Normal", "Niedrig"]
    @Environment(\.presentationMode) var presentationMode
    
    init(doYourThings: Binding<DoYourThings>) {
        self._doYourThings = doYourThings
        self._dytTopic = State(initialValue: doYourThings.wrappedValue.dytTopic)
        self._dytDetails = State(initialValue: doYourThings.wrappedValue.dytDetails)
        self._dytPriority = State(initialValue: doYourThings.wrappedValue.dytPriority)
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("DoYourThings")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Form {
                    Section {
                        Picker("Priority:", selection: $dytPriority) {
                            ForEach(priority, id: \.self) {
                                Text($0)
                            }
                        }
                        .font(.title3)
                    }
                }
                VStack {
                        Text("Thing:")
                            .font(.title)
                            .foregroundColor(.white)
                            .underline()
                        
                        TextEditor(text: $dytTopic)
                            .background(Color.white)
                            .frame(height: 100)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 2)
                            )
                        Text("Details:")
                            .font(.title)
                            .foregroundColor(.white)
                            .underline()
                        
                        TextEditor(text: $dytDetails)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 2)
                            )
                }.padding(.top, -200)
            }.padding()
                Section {
                    Button(action: {
                        doYourThingsViewModel.updateDoYourThings(doYourThings: doYourThings, newTopic: dytTopic, newDetails: dytDetails, newDytPriority: dytPriority)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "pencil.tip.crop.circle.badge.plus.fill")
                            .font(.system(size: 50))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.teal)
                    }
                }.navigationTitle("Bearbeiten")
        }.colorScheme(.light)
         .background(Gradient(colors: [.teal, .mint, .green]).opacity(0.6))
         .scrollContentBackground(.hidden)
        
    }
}

#Preview {
    EditView(doYourThings: .constant(DoYourThings(dytTopic: "Sample Topic", dytDetails: "Sample Details", dytPriority: "Normal")))
}
