//
//  ContentView.swift
//  DoYourThings
//
//  Created by RGMCode on 26.05.24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var doYourThingsViewModel: DoYourThingsViewModel
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    Text("DoYourThings")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        List {
                            ForEach($doYourThingsViewModel.doYourThings, id: \.id) { $doYourThings in
                                NavigationLink(destination: DoYourThingsDetailView(doYourThings: $doYourThings)) {
                                    HStack {
                                        Image(systemName: "target")
                                            .font(.system(size: 30))
                                            .foregroundColor(doYourThingsViewModel.colorForPriority(doYourThings.dytPriority))
                                        Text(doYourThings.dytTopic)
                                    }
                                }
                            }
                            .onDelete { indexSet in
                                indexSet.forEach { index in
                                    let doYourThings = doYourThingsViewModel.doYourThings[index]
                                    doYourThingsViewModel.removeDoYourThings(doYourThings: doYourThings)
                                }
                            }
                        }
                        .listRowBackground(Color.red)
                        .scrollContentBackground(.hidden)
                        .padding(.top, -35)
                    VStack {
                        NavigationLink(destination: AddView()) {
                            Image(systemName: "note.text.badge.plus")
                                .font(.system(size: 50))
                                .foregroundColor(.teal)
                        }
                    }.padding()
                }.background(Gradient(colors: [.teal, .mint, .green]).opacity(0.6))
            }
        }.background(Color.mint)
         .colorScheme(.light)
    }
}

#Preview {
    ContentView().environmentObject(DoYourThingsViewModel())
}
