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
    @FocusState var isInputActive: Bool
    @Environment(\.presentationMode) var presentationMode
    
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
                    TextEditor(text: $dytDetails)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 2)
                        )
                }.padding(.top, -200)
            }.padding()
                    Button(action: {
                        doYourThingsViewModel.addDoYourThings(dytTopic: dytTopic, dytDetails: dytDetails, dytPriority: dytPriority)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "pencil.tip.crop.circle.badge.plus.fill")
                            .font(.system(size: 50))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.teal)
                            .background(Color.clear)
                    }.navigationTitle("Neues Do Your Thing")
        }.background(Gradient(colors: [.teal, .mint, .green]).opacity(0.6))
        .colorScheme(.light)
        .scrollContentBackground(.hidden)
        .focused($isInputActive)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            Button("fertig") {
                isInputActive = false
                }
              }
            }
    }
    
}

#Preview {
    AddView().environmentObject(DoYourThingsViewModel())
}
