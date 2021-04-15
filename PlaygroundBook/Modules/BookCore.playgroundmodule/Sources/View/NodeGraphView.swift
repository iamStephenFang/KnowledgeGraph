//
//  NodeGraphView.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import SwiftUI

struct NodeGraphView: View {
  @ObservedObject var selection: SelectionHandler
  @Binding var nodes: [Node]
  
  var body: some View {
    ZStack {
      ForEach(nodes, id: \.id) { node in
        NodeView(node: node, selection: self.selection)
          .offset(x: node.position.x, y: node.position.y)
          .onTapGesture {
            self.selection.selectNode(node)
          }
      }
    }
  }
}
