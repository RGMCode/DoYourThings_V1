//
//  DoYourThingsViewModel.swift
//  DoYourThings
//
//  Created by RGMCode on 26.05.24.
//

import SwiftUI
import Foundation

// Die Klasse `DoYourThingsViewModel`, die von `ObservableObject` erbt, wird erstellt.
class DoYourThingsViewModel: ObservableObject {
    
    // Eine veröffentlichte Variable, die eine Liste von `DoYourThings`-Objekten enthält.
    @Published var doYourThings: [DoYourThings] = []
    
    // Initialisierung des ViewModels.
    init() {
        // Kopiert die JSON-Datei bei Bedarf ins Dokumentenverzeichnis.
        copyJSONFileToDocumentsIfNeeded()
        // Lädt die "Do Your Things"-Daten.
        loadDoYourThingsData()
    }
    
    // Funktion zum Hinzufügen eines neuen "Do Your Things"-Objekts.
    func addDoYourThings(dytTopic: String, dytDetails: String, dytPriority: String) {
        let newDoYourThing = DoYourThings(dytTopic: dytTopic, dytDetails: dytDetails, dytPriority: dytPriority)
        doYourThings.append(newDoYourThing)
        saveDoYourThingsData()
    }
    
    // Funktion zum Speichern der "Do Your Things"-Daten in einer JSON-Datei.
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
    
    // Funktion zum Laden der "Do Your Things"-Daten aus einer JSON-Datei.
    func loadDoYourThingsData() {
        let path = getDataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([DoYourThings].self, from: data) {
                doYourThings = decoded
            }
        }
    }
    
    // Funktion zum Entfernen eines "Do Your Things"-Objekts.
    func removeDoYourThings(doYourThings: DoYourThings) {
        if let index = self.doYourThings.firstIndex(of: doYourThings) {
            self.doYourThings.remove(at: index)
            saveDoYourThingsData()
        }
    }
    
    // Funktion zum Aktualisieren eines bestehenden "Do Your Things"-Objekts.
    func updateDoYourThings(doYourThings: DoYourThings, newTopic: String, newDetails: String, newDytPriority: String) {
        if let index = self.doYourThings.firstIndex(of: doYourThings) {
            self.doYourThings[index].dytTopic = newTopic
            self.doYourThings[index].dytDetails = newDetails
            self.doYourThings[index].dytPriority = newDytPriority
            objectWillChange.send()
            saveDoYourThingsData()
        }
    }
    
    // Funktion zum Abrufen des Dokumentenverzeichnisses.
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Funktion zum Abrufen des Pfads zur Daten-Datei.
    private func getDataFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent("DYT_Data.json")
    }
    
    // Funktion zum Kopieren der JSON-Datei ins Dokumentenverzeichnis, falls diese noch nicht existiert.
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
    
    // Funktion zur Bestimmung der Farbe basierend auf der Priorität.
    func colorForPriority(_ priority: String) -> Color {
        switch priority {
        case "Hoch":
            return .red
        case "Normal":
            return .green
        case "Niedrig":
            return .blue
        default:
            return .black
        }
    }
    
}
