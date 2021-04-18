//
//  GraphView.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import SwiftUI

struct GraphView: View {
  @ObservedObject var selection: SelectionHandler
  @ObservedObject var graph: Graph
  
  var body: some View {
    ZStack {
      Rectangle().fill(Color.clear)
      EdgeGraphView(edges: $graph.links)
      EntityGraphView(selection: selection, entities: $graph.entities)
    }
  }
}
