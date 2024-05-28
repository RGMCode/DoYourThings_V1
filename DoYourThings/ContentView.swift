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
        NavigationView {
            VStack {
                List {
                    ForEach($doYourThingsViewModel.doYourThings, id: \.id) { $doYourThings in
                        NavigationLink(destination: DoYourThingsDetailView(doYourThings: $doYourThings)) {
                            HStack {
                                Image(systemName: "target")
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
                .navigationTitle("Do Your Things")
                
                Spacer()
                
                VStack {
                    NavigationLink(destination: AddView()) {
                        Image(systemName: "note.text.badge.plus")
                            .font(.system(size: 50))
                            .foregroundColor(.green)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(DoYourThingsViewModel())
}
