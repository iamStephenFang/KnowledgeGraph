//
//  IntroView.swift
//  BookCore
//
//  Created by StephenFang on 2021/4/19.
//

import SwiftUI
import AVKit

public struct IntroView: View {
    @State var audioPlayer: AVAudioPlayer!
    public init(
        audioPlayer : AVAudioPlayer = AVAudioPlayer()
    ) {
        _audioPlayer = State(wrappedValue: audioPlayer)
    }
    public var body: some View {
        Image("Intro")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .onAppear {
                let sound = Bundle.main.path(forResource: "BGM", ofType: "mp3")
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                self.audioPlayer.play()
            }
    }
}
struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
