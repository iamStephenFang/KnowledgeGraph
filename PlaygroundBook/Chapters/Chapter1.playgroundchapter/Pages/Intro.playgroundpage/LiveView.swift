////
////  See LICENSE folder for this template’s licensing information.
////
////  Abstract:
////  Instantiates a live view and passes it to the PlaygroundSupport framework.
////

import SwiftUI
import BookCore
import PlaygroundSupport

struct IntroView: View {
    var body: some View {
        Image("Intro")
          .resizable()
          .aspectRatio(contentMode: .fill)
    }
}
PlaygroundPage.current.setLiveView(IntroView())


