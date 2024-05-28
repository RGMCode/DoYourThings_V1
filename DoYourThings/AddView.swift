//
//  AddView.swift
//  DoYourThings
//
//  Created by RGMCode on 26.05.24.
//

import SwiftUI

struct AddView: View {
    
    @EnvironmentObject var doYourThingsViewModel: DoYourThingsViewModel
    @State private var dytTopic: String = ""
    @State private var dytDetails: String = ""
    @State private var dytPriority = "Normal"
    let priority = ["Hoch", "Normal", "Niedrig"]
    @Environment(\.presentationMode) var presentationMode
    
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
                        doYourThingsViewModel.addDoYourThings(dytTopic: dytTopic, dytDetails: dytDetails, dytPriority: dytPriority)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "pencil.tip.crop.circle.badge.plus.fill")
                            .font(.system(size: 50))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.green)
                    }
                }
            }
            .navigationTitle("Neues Do Your Thing")
        }
    }
}

#Preview {
    AddView().environmentObject(DoYourThingsViewModel())
}
