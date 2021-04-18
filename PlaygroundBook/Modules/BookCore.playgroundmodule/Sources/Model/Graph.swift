//
//  Graph.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import Foundation
import CoreGraphics

public class Graph: ObservableObject {
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
    }
    
    func addNodes(_ nodesToAdd: [Node]) {
      for node in nodesToAdd {
        nodes.append(node)
      }
    }
    
    func updateNode(_ node: Node, string: String) {
      var newNode = node
      newNode.text = string
      replace(node, with: newNode)
    }
    
    func deleteNode(_ nodeToDelete: NodeID) {
        if let delete = nodes.firstIndex(where: { $0.id == nodeToDelete }) {
          nodes.remove(at: delete)
          let remainingEdges = edges.filter({ $0.end != nodeToDelete && $0.start != nodeToDelete })
          edges = remainingEdges
        }
      rebuildLinks()
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
    
    func addRelation(_ entity: Node, to anotherEntity: Node, relation: String){
        let center = entity.position
        let radius = 300.0
        let angle = CGFloat.random(in: 1.0..<360.0) * CGFloat.pi/180.0
        let point = CGPoint(x: center.x + CGFloat(radius) * cos(angle), y: center.y + CGFloat(radius) * sin(angle))
        
        self.positionNode(anotherEntity, position: point)
        connect(entity, to: anotherEntity, relation: relation)
        rebuildLinks()
    }
    
    func deleteNode(_ entity: Node) {
      deleteNode(entity.id)
    }

    func updateEntity(_ entity: Node, relation: String) {
        var newNode = entity
        newNode.text = relation
        replace(entity, with: newNode)
    }
    
    func getEntityInfo(_ entity: Node) {
      
    }
    
    func addNewEntity(_ entity: Node, at point: CGPoint? = nil, relation: String) -> Node {
      let target = point ?? entity.position
      let child = Node(position: target, text: "")
      addNode(child)
      connect(entity, to: child, relation: relation)
      rebuildLinks()
      return child
    }
    
    func pointWithCenter(center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
      let deltax = radius*cos(angle)
      let deltay = radius*sin(angle)
      let newpoint = CGPoint(x: center.x + deltax, y: center.y + deltay)
      return newpoint
    }
    
    func positionForNewChild(_ parent: Node, length: CGFloat) -> CGPoint {
      let childEdges = edges.filter { $0.start == parent.id }
      if let grandparentedge = edges.filter({ $0.end == parent.id }).first, let grandparent = nodeWithID(grandparentedge.start) {
        let baseAngle = angleFrom(start: grandparent.position, end: parent.position)
        let childBasedAngle = positionForChildAtIndex(childEdges.count, baseAngle: baseAngle)
        let newpoint = pointWithCenter(center: parent.position, radius: length, angle: childBasedAngle)
        return newpoint
      }
      return CGPoint(x: 200, y: 200)
    }
    
    func angleFrom(start: CGPoint, end: CGPoint) -> CGFloat {
      var deltax = end.x - start.x
      let deltay = end.y - start.y
      if abs(deltax) < 0.001 {
        deltax = 0.001
      }
      let  angle = atan(deltay/abs(deltax))
      return deltax > 0 ? angle: CGFloat.pi - angle
    }
    
    func positionForChildAtIndex(_ index: Int, baseAngle: CGFloat) -> CGFloat {
      let jitter = CGFloat.random(in: CGFloat(-1.0)...CGFloat(1.0)) * CGFloat.pi/32.0
      guard index > 0 else { return baseAngle + jitter }

      let level = (index + 1)/2
      let polarity: CGFloat = index % 2 == 0 ? -1.0:1.0

      let delta = CGFloat.pi/6.0 + jitter
      return baseAngle + polarity * delta * CGFloat(level)
    }
}

public func drawComposition(firstEntity: String, nextEntity: String, relation: String) -> Graph {
    let graph = Graph()
    let child1 = Node(text: firstEntity)
    let child2 = Node(text: nextEntity)
    graph.addNode(child1)
    graph.addNode(child2)
    graph.positionNode(child1, position: CGPoint(x: 100, y: 0))
    graph.positionNode(child2, position: CGPoint(x: -100, y: 0))
    graph.connect(child1, to: child2, relation: relation)
    return graph
}

public func drawCountryGraph() -> Graph {
  let graph = Graph()
  
  let Countries = Node(text: "Countries")
  graph.addNode(Countries)
  
  let Beijing = Node(text: "Beijing")
  let Washington = Node(text: "Washington, D.C.")
  let Tokyo = Node(text: "Tokyo")
  let Berlin = Node(text: "Berlin")
  let London = Node(text: "London")
  let Paris = Node(text: "Paris")
  
  let Madarin = Node(text: "Madarin")
  let English = Node(text: "English")
  let Japanese = Node(text: "Japanese")
  let German = Node(text: "German")
  let French = Node(text: "French")
  
  let TokyoTower = Node(text: "Tokyo Tower")
  let EiffelTower = Node(text: "EiffelTower")
  let TheGreatWall = Node(text: "The Great Wall")
  let BigBen = Node(text: "Big Ben")
  let StatueofLiberty = Node(text: "Statue of Liberty")
  let NeuschwansteinCastle = Node(text: "Neuschwanstein Castle")
  
  let TheUS = graph.addNewEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 400, angle: (0 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
  graph.updateNode(TheUS, string: "TheUS")
  graph.addRelation(TheUS, to: Washington, relation: "Capital")
  graph.positionNode(Washington, position: graph.positionForNewChild(TheUS, length: 200))
  graph.addRelation(TheUS, to: English, relation: "Official Language")
  graph.positionNode(English, position: graph.positionForNewChild(TheUS, length: 200))
  graph.addRelation(TheUS, to: StatueofLiberty, relation: "Famous Attractions")
  graph.positionNode(StatueofLiberty, position: graph.positionForNewChild(TheUS, length: 200))
  
  let TheUK = graph.addNewEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 350, angle: (1 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
  graph.updateNode(TheUK, string: "TheUK")
  graph.addRelation(TheUK, to: London, relation: "Capital")
  graph.positionNode(London, position: graph.positionForNewChild(TheUK, length: 200))
  graph.addRelation(TheUK, to: English, relation: "Official Language")
  graph.addRelation(London, to: BigBen, relation: "Landmark")
  graph.positionNode(BigBen, position: graph.positionForNewChild(London, length: 400))
  
  let China = graph.addNewEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 350, angle: (2 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
  graph.updateNode(China, string: "China")
  graph.addRelation(China, to: Beijing, relation: "Capital")
  graph.positionNode(Beijing, position: graph.positionForNewChild(China, length: 200))
  graph.addRelation(China, to: Madarin, relation: "Official Language")
  graph.positionNode(Madarin, position: graph.positionForNewChild(China, length: 200))
  graph.addRelation(Beijing, to: TheGreatWall, relation: "Landmark")
  graph.positionNode(TheGreatWall, position: graph.positionForNewChild(Beijing, length: 400))
  
  let Japan = graph.addNewEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 350, angle: (3 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
  graph.updateNode(Japan, string: "Japan")
  graph.addRelation(Japan, to: Tokyo, relation: "Capital")
  graph.positionNode(Tokyo, position: graph.positionForNewChild(Japan, length: 200))
  graph.addRelation(Japan, to: Japanese, relation: "Official Language")
  graph.positionNode(Japanese, position: graph.positionForNewChild(Japan, length: 200))
  graph.addRelation(Tokyo, to: TokyoTower, relation: "Landmark")
  graph.positionNode(TokyoTower, position: graph.positionForNewChild(Tokyo, length: 400))
  
  let Germany = graph.addNewEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 350, angle: (4 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
  graph.updateNode(Germany, string: "Germany")
  graph.addRelation(Germany, to: Berlin, relation: "Capital")
  graph.positionNode(Berlin, position: graph.positionForNewChild(Germany, length: 200))
  graph.addRelation(Germany, to: German, relation: "Official Language")
  graph.positionNode(German, position: graph.positionForNewChild(Germany, length: 200))
  graph.addRelation(Germany, to: NeuschwansteinCastle, relation: "Famous Attractions")
  graph.positionNode(NeuschwansteinCastle, position: graph.positionForNewChild(Germany, length: 200))
  
  let France = graph.addNewEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 350, angle: (5 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
  graph.updateNode(France, string: "France")
  graph.addRelation(France, to: Paris, relation: "Capital")
  graph.positionNode(Paris, position: graph.positionForNewChild(France, length: 200))
  graph.addRelation(France, to: French, relation: "Official Language")
  graph.positionNode(French, position: graph.positionForNewChild(France, length: 200))
  graph.addRelation(Paris, to: EiffelTower, relation: "Landmark")
  graph.positionNode(EiffelTower, position: graph.positionForNewChild(Paris, length: 200))

  return graph
}

