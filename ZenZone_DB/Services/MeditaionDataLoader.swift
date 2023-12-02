//
//  MeditationDataLoader.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-25.
//

import Foundation

class MeditationDataLoader {
    static func loadMeditationSessions() -> [MeditationSession] {
        guard let url = Bundle.main.url(forResource: "MeditationSession", withExtension: "json") else {
            print("Meditation sessions JSON file not found.")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let sessions = try decoder.decode([MeditationSession].self, from: data)
            return sessions
        } catch {
            print("Error loading meditation sessions: \(error)")
            return []
        }
    }
}

