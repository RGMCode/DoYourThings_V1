//
//  DoYourThingsViewModel.swift
//  DoYourThings
//
//  Created by RGMCode on 26.05.24.
//

import SwiftUI
import Foundation

class DoYourThingsViewModel: ObservableObject {
    
    @Published var doYourThings: [DoYourThings] = []
    
    init() {
        copyJSONFileToDocumentsIfNeeded()
        loadDoYourThingsData()
    }
    
    func addDoYourThings(dytTopic: String, dytDetails: String, dytColor: String) {
        let newDoYourThing = DoYourThings(dytTopic: dytTopic, dytDetails: dytDetails, dytColor: dytColor)
        doYourThings.append(newDoYourThing)
        saveDoYourThingsData()
    }
    
    func saveDoYourThingsData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(doYourThings) {
            do {
                let url = getDataFilePath()
                try encoded.write(to: url, options: .atomic)
                print("Data saved to \(url)")
            } catch {
                print("Failed to save data: \(error.localizedDescription)")
            }
        }
    }
    
    func loadDoYourThingsData() {
        let path = getDataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([DoYourThings].self, from: data) {
                doYourThings = decoded
            }
        }
    }
    
    func removeDoYourThings(doYourThings: DoYourThings) {
        if let index = self.doYourThings.firstIndex(of: doYourThings) {
            self.doYourThings.remove(at: index)
            saveDoYourThingsData()
        }
    }
    
    func updateDoYourThings(doYourThings: DoYourThings, newTopic: String, newDetails: String, newDytColor: String) {
        if let index = self.doYourThings.firstIndex(of: doYourThings) {
            self.doYourThings[index].dytTopic = newTopic
            self.doYourThings[index].dytDetails = newDetails
            self.doYourThings[index].dytColor = newDytColor
            objectWillChange.send()
            saveDoYourThingsData()
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func getDataFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent("DYT_Data.json")
    }
    
    private func copyJSONFileToDocumentsIfNeeded() {
        let fileManager = FileManager.default
        let destinationPath = getDataFilePath()
        
        if !fileManager.fileExists(atPath: destinationPath.path) {
            if let sourcePath = Bundle.main.url(forResource: "DYT_Data", withExtension: "json") {
                do {
                    try fileManager.copyItem(at: sourcePath, to: destinationPath)
                    print("Data.json copied to \(destinationPath)")
                } catch {
                    print("Failed to copy Data.json: \(error.localizedDescription)")
                }
            } else {
                print("Data.json not found in bundle.")
            }
        }
    }
}
