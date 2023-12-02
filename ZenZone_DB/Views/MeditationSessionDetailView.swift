//
//  MeditationSessionDetailView.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-25.
//

import SwiftUI
import AVFoundation

struct MeditationSessionDetailView: View {
    let session: MeditationSession

    @StateObject private var mediaPlayer = MediaPlayer.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                
                Image(session.imageName)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 5)

                Text(session.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text(session.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(15)

                HStack {
                    Text("Duration: \(String(format: "%.2f", session.duration)) mins")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(10)

                    Spacer()

                    Text("Category: \(session.category)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(10)
                }

                // Audio player controls and progress
                VStack(spacing: 15) {
                    HStack {
                        Text(mediaPlayer.currentTimeString) // Current time
                        Spacer()
                        Text(mediaPlayer.totalDurationString) // Total duration
                    }
                    .font(.caption)
                    .foregroundColor(.gray)

                    Slider(value: $mediaPlayer.progress, in: 0...1, step: 0.01)

                    Button(action: {
                        if mediaPlayer.isPlaying {
                            mediaPlayer.pauseAudio()
                        } else {
                            mediaPlayer.playAudio(file: session.audioFileName, ofType: "mp3")
                        }
                    }) {
                        Image(systemName: mediaPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.blue)
                            .padding()

                        Text(mediaPlayer.isPlaying ? "Pause Session" : "Play Session")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()

                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .navigationBarTitle(Text(session.title), displayMode: .inline)
        .onAppear {
             mediaPlayer.playAudio(file: session.audioFileName, ofType: "mp3")
        }
        .onDisappear {
            mediaPlayer.stopAudio()
        }
    }
}

struct MeditationSessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationSessionDetailView(session: MeditationSession(id: "1", title: "Mountain Meditation", description: "This is a sample description for a meditation session.", duration: 8.13, category: "Relaxation", audioFileName: "MountainMeditation", imageName: "meditation_icon"))
    }
}
