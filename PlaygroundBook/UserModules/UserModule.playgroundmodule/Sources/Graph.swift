//
//  Graph.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import Foundation
import CoreGraphics

class Graph: ObservableObject {
  @Published var nodes: [Node] = []
  @Published var links: [EdgeProxy] = []
  
  var edges: [Edge] = [] {
    didSet {
      rebuildLinks()
    }
  }
  
  func rebuildLinks() {
    links = edges.compactMap { edge in
      let snode = nodes.filter({ $0.id == edge.start }).first
      let enode = nodes.filter({ $0.id == edge.end }).first
      if let snode = snode, let enode = enode {
        return EdgeProxy(id: edge.id, start: snode.position, end: enode.position, text: edge.text)
      }
      return nil
    }
  }
  
  func nodeWithID(_ nodeID: NodeID) -> Node? {
    return nodes.filter({ $0.id == nodeID }).first
  }
  
  func replace(_ node: Node, with replacement: Node) {
    var newSet = nodes.filter { $0.id != node.id }
    newSet.append(replacement)
    nodes = newSet
  }
}

extension Graph {
  func updateNodeText(_ srcNode: Node, string: String) {
    var newNode = srcNode
    newNode.text = string
    replace(srcNode, with: newNode)
  }
  
  func positionNode(_ node: Node, position: CGPoint) {
    var movedNode = node
    movedNode.position = position
    replace(node, with: movedNode)
    rebuildLinks()
  }
  
  func processNodeTranslation(_ translation: CGSize, nodes: [DragInfo]) {
    nodes.forEach { draginfo in
      if let node = nodeWithID(draginfo.id) {
        let nextPosition = draginfo.originalPosition.translatedBy(x: translation.width, y: translation.height)
        self.positionNode(node, position: nextPosition)
      }
    }
  }
  
  func addNode(_ node: Node) {
    nodes.append(node)
    if (node.position == CGPoint.zero) {
      let randomPosition = CGPoint(x: CGFloat.offsets.randomItem(), y: CGFloat.offsets.randomItem())
      self.positionNode(node, position: randomPosition)
    }
  }
  
  func connect(_ parent: Node, to child: Node, relation: String) {
    let newedge = Edge(start: parent.id, end: child.id, text: relation)
    let exists = edges.contains(where: { edge in
      return newedge == edge
    })
    guard exists == false else {
      return
    }
    edges.append(newedge)
  }
    
  func addRelation(_ parent: Node, to child: Node, relation: String){
    let center = parent.position
    let radius = 200.0
    let angle = CGFloat.random(in: 1.0..<360.0) * CGFloat.pi/180.0
    let point = CGPoint(x: center.x + CGFloat(radius) * cos(angle), y: center.y + CGFloat(radius) * sin(angle))
    
    self.positionNode(child, position: point)
    connect(parent, to: child, relation: relation)
    rebuildLinks()
  }
}

extension Graph {
  static func sampleGraph() -> Graph {
    let graph = Graph()
    let child1 = Node(text: "child 1")
    let child2 = Node(text: "child 2")
    graph.addNode(child1)
    graph.addNode(child2)
    graph.positionNode(child1, position: CGPoint(x: 100, y: 0))
    graph.positionNode(child2, position: CGPoint(x: -100, y: 0))
    graph.connect(child1, to: child2, relation: "Demo")
    return graph
  }
}
