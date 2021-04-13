//
//  IntroView.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/13.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        Image("Intro")
          .resizable()
          .aspectRatio(contentMode: .fit)
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
