//
//  SelectionHandler.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import Foundation
import CoreGraphics

struct DragInfo {
  var id: NodeID
  var originalPosition: CGPoint
}

class SelectionHandler: ObservableObject {
  @Published var draggingNodes: [DragInfo] = []
  @Published private(set) var selectedNodeIDs: [NodeID] = []
  
  @Published var editingText: String = ""
  
  func selectNode(_ node: Node) {
    selectedNodeIDs = [node.id]
    editingText = node.text
  }
  
  func isNodeSelected(_ node: Node) -> Bool {
    return selectedNodeIDs.contains(node.id)
  }
  
  func onlySelectedNode(in graph: Graph) -> Node? {
    let selectedNodes = self.selectedNodes(in: graph)
    if selectedNodes.count == 1 {
      return selectedNodes.first
    }
    return nil
  }
  
  func selectedNodes(in graph: Graph) -> [Node] {
    return selectedNodeIDs.compactMap { graph.nodeWithID($0) }
  }
  
  func startDragging(_ graph: Graph) {
    draggingNodes = selectedNodes(in: graph)
      .map { DragInfo(id: $0.id, originalPosition: $0.position) }
  }
  
  func stopDragging(_ graph: Graph) {
    draggingNodes = []
  }
}
