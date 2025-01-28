//
//  AudioModel.swift
//  MyPetsApp
//
//  Created by Lisa Hofbauer on 27.01.25.
//

import Foundation
import AVFoundation

class AudioModel: NSObject, ObservableObject, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var soundFileURL = URL(string: "")
    
    @Published var isRecording: Bool = false
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Error setting up audio session")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        soundFileURL = path.appendingPathComponent("recording.m4a")
        
        print(path)
        
        let audioSettings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: self.soundFileURL!, settings: audioSettings)
            audioRecorder?.delegate = self
            
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Error setting up audio recorder")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
    }
    
    func startPlaying(soundURL: URL) {
        print("Attempting to play sound at URL: \(soundURL)")
        do {
            let playbackSession = AVAudioSession.sharedInstance()
                try playbackSession.setCategory(.playback, mode: .default)
                try playbackSession.setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            print("Playing sound...")
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func stopPlaying(){
        audioPlayer?.stop()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool){
        print("Finished recording")
    }
}
