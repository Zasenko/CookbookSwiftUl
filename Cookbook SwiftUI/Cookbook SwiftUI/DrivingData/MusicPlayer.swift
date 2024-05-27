//
//  MusicPlayer.swift
//  Cookbook SwiftUI
//
//  Created by Dmitry Zasenko on 27.05.24.
//

import SwiftUI

struct MusicPlayerView: View {
        
    private let songs = [
        Song(artist: "Luke", name: "99", cover: "dublin"),
        Song(artist: "Foxing", name: "No Trespassing",
             cover: "las-vegas"),
        Song(artist: "Breaking Benjamin", name: "Phobia",
             cover: "miami"),
        Song(artist: "J2", name: "Solenoid",
             cover:"paris"),
        Song(artist: "Wildflower Clothing",
             name: "Lightning Bottles", cover: "singapore"),
        Song(artist: "The Broken Spirits", name: "Rubble",
             cover: "california"),
        ]

    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationStack {
                List(self.songs) { song in
                    SongView(song: song)
                }
                .listStyle(.plain)
                .navigationTitle("Music Player")
            }
            MiniPlayerView()
                .background(.gray)
                .offset(y: 44)
                .zIndex(1.0)
        }
        .environmentObject(MusicPlayer())
    }
}

#Preview {
    MusicPlayerView()
}

struct Song: Identifiable, Equatable {
    var id = UUID()
    let artist: String
    let name: String
    let cover: String
}

class MusicPlayer: ObservableObject {
    @Published var currentSong: Song?
    
    func tapButton(song: Song) {
        if currentSong == song {
            currentSong = nil
        } else {
            currentSong = song
        }
    }
}

struct PlayButton: View {
    @EnvironmentObject private var musicPlayer: MusicPlayer
    let song: Song
    private var buttonText: String {
        if song == musicPlayer.currentSong {
            return "stop"
        } else {
            return "play"
        }
    }
    var body: some View {
        Button {
            withAnimation {
                musicPlayer.tapButton(song: song)
            }
        } label: {
            Image(systemName: buttonText)
                .font(.system(.largeTitle))
                .foregroundStyle(.black)
        }
    }
}

struct SongView: View {
    @EnvironmentObject private var musicPlayer: MusicPlayer
    let song: Song
    var body: some View {
        HStack {
            NavigationLink(destination:
                            PlayerView(song: song)) {
                Image(song.cover)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                VStack(alignment: .leading) {
                    Text(song.name)
                    Text(song.artist).italic()
                }
            }
            Spacer()
            PlayButton(song: song)
        }
        .buttonStyle(.plain)
    }
}

struct PlayerView: View {
    @EnvironmentObject private var musicPlayer: MusicPlayer
    let song: Song
    var body: some View {
        VStack {
            Image(song.cover)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
            HStack {
                Text(song.name)
                Text(song.artist).italic()
            }
            PlayButton(song: song)
        }
    }
}

struct MiniPlayerView: View {
    @EnvironmentObject private var musicPlayer: MusicPlayer
    var body: some View {
        if let currentSong = musicPlayer.currentSong {
            SongView(song: currentSong)
                .padding(24)
        } else {
            EmptyView()
        }
    }
}
