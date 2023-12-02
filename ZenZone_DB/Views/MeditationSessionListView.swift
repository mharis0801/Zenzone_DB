//
//  MeditationSessionListView.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-25.
//

import SwiftUI

struct MeditationSessionListView: View {
    @State private var sessions: [MeditationSession] = []
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                // Search bar for filtering
                TextField("Search by category or title", text: $searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)

                // List of sessions
                List(filteredSessions) { session in
                    NavigationLink(destination: MeditationSessionDetailView(session: session)) {
                        HStack {
                            Image(session.imageName) // Displaying session's image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)

                            VStack(alignment: .leading) {
                                Text(session.title)
                                    .fontWeight(.bold)
                                
                                Text("Category: \(session.category)")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                .navigationTitle("Meditation Sessions")
            }
            .onAppear {
                // Load sessions from the MeditationDataLoader
                sessions = MeditationDataLoader.loadMeditationSessions()
            }
        }
    }

    // Filter sessions based on the search text
    private var filteredSessions: [MeditationSession] {
        if searchText.isEmpty {
            return sessions
        } else {
            return sessions.filter { session in
                session.title.localizedCaseInsensitiveContains(searchText) ||
                session.category.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    

}

struct MeditationSessionListView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationSessionListView()
    }
}



