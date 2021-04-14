//
//  EdgeGraphView.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import SwiftUI

struct EdgeGraphView: View {
  @Binding var edges: [EdgeProxy]
  
  var body: some View {
    ZStack {
      ForEach(edges) { edge in
        EdgeView(edge: edge)
      }
    }
  }
}
