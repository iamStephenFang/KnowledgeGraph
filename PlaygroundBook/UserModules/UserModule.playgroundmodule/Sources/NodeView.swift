//
//  EntityView.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import SwiftUI

struct NodeView: View {
  static let width = CGFloat(100)
  @State var node: Node
  @ObservedObject var selection: SelectionHandler
  var isSelected: Bool {
    return selection.isNodeSelected(node)
  }
  
  var body: some View {
    Ellipse()
      .fill(Color(node.color))
      .overlay(Ellipse()
                .stroke(isSelected ? Color.black : Color.clear, lineWidth: 2 ))
      .overlay(Text(node.text)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)))
      .frame(width: NodeView.width, height: NodeView.width, alignment: .center)
  }
}
