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
            Form {
                Section {
                    Picker("Priority:", selection: $dytPriority) {
                        ForEach(priority, id: \.self) {
                            Text($0)
                        }
                    }
                    .font(.title3)
                }
                
                Section(header: Text("Aufgabe:").font(.title)) {
                    TextEditor(text: $dytTopic)
                        .border(Color.gray)
                }
                
                Section(header: Text("Details:").font(.title)) {
                    TextEditor(text: $dytDetails)
                        .border(Color.gray)
                        .frame(height: 300)
                }
                
                Section {
                    Button(action: {
                        doYourThingsViewModel.updateDoYourThings(doYourThings: doYourThings, newTopic: dytTopic, newDetails: dytDetails, newDytPriority: dytPriority)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "pencil.tip.crop.circle.badge.plus.fill")
                            .font(.system(size: 50))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.green)
                    }
                }
            }
            .navigationTitle("Bearbeiten")
        }
    }
}

#Preview {
    EditView(doYourThings: .constant(DoYourThings(dytTopic: "Sample Topic", dytDetails: "Sample Details", dytPriority: "Normal")))
}
