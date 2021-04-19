//
//  GraphExample.swift
//  BookCore
//
//  Created by StephenFang on 2021/4/18.
//

import SwiftUI
import UIKit

public func drawEmptyGraph() -> Graph {
    let graph = Graph()
    return graph
}

public func drawComposition(firstEntity: String, nextEntity: String, relation: String) -> Graph {
    let graph = Graph()
    let child1 = Entity(text: firstEntity)
    let child2 = Entity(text: nextEntity)
    graph.addEntity(child1)
    graph.addEntity(child2)
    graph.positionEntity(child1, position: CGPoint(x: 100, y: 0))
    graph.positionEntity(child2, position: CGPoint(x: -100, y: 0))
    graph.connect(child1, to: child2, relation: relation)
    return graph
}

public func drawCountryGraph() -> Graph {
  let graph = Graph()
  
  let Countries = Entity(text: "Countries")
  graph.addEntity(Countries)
  
  let Beijing = Entity(text: "Beijing")
  let Washington = Entity(text: "Washington, D.C.")
  let Tokyo = Entity(text: "Tokyo")
  let Berlin = Entity(text: "Berlin")
  let London = Entity(text: "London")
  let Paris = Entity(text: "Paris")
  
  let Madarin = Entity(text: "Madarin")
  let English = Entity(text: "English")
  let Japanese = Entity(text: "Japanese")
  let German = Entity(text: "German")
  let French = Entity(text: "French")
  
  let TokyoTower = Entity(text: "Tokyo Tower")
  let EiffelTower = Entity(text: "EiffelTower")
  let TheGreatWall = Entity(text: "The Great Wall")
  let BigBen = Entity(text: "Big Ben")
  let StatueofLiberty = Entity(text: "Statue of Liberty")
  let NeuschwansteinCastle = Entity(text: "Neuschwanstein Castle")
  
  let TheUS = graph.quickAddEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 400, angle: (0 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
    graph.updateEntity(TheUS, text: "TheUS")
  graph.addRelation(TheUS, to: Washington, relation: "Capital")
  graph.positionEntity(Washington, position: graph.positionForNewChild(TheUS, length: 200))
  graph.addRelation(TheUS, to: English, relation: "Official Language")
  graph.positionEntity(English, position: graph.positionForNewChild(TheUS, length: 200))
  graph.addRelation(TheUS, to: StatueofLiberty, relation: "Famous Attractions")
  graph.positionEntity(StatueofLiberty, position: graph.positionForNewChild(TheUS, length: 200))
  
  let TheUK = graph.quickAddEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 350, angle: (1 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
  graph.updateEntity(TheUK, text: "TheUK")
  graph.addRelation(TheUK, to: London, relation: "Capital")
  graph.positionEntity(London, position: graph.positionForNewChild(TheUK, length: 200))
  graph.addRelation(TheUK, to: English, relation: "Official Language")
  graph.addRelation(London, to: BigBen, relation: "Landmark")
  graph.positionEntity(BigBen, position: graph.positionForNewChild(London, length: 400))
  
  let China = graph.quickAddEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 350, angle: (2 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
  graph.updateEntity(China, text: "China")
  graph.addRelation(China, to: Beijing, relation: "Capital")
  graph.positionEntity(Beijing, position: graph.positionForNewChild(China, length: 200))
  graph.addRelation(China, to: Madarin, relation: "Official Language")
  graph.positionEntity(Madarin, position: graph.positionForNewChild(China, length: 200))
  graph.addRelation(Beijing, to: TheGreatWall, relation: "Landmark")
  graph.positionEntity(TheGreatWall, position: graph.positionForNewChild(Beijing, length: 400))
  
  let Japan = graph.quickAddEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 350, angle: (3 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
  graph.updateEntity(Japan, text: "Japan")
  graph.addRelation(Japan, to: Tokyo, relation: "Capital")
  graph.positionEntity(Tokyo, position: graph.positionForNewChild(Japan, length: 200))
  graph.addRelation(Japan, to: Japanese, relation: "Official Language")
  graph.positionEntity(Japanese, position: graph.positionForNewChild(Japan, length: 200))
  graph.addRelation(Tokyo, to: TokyoTower, relation: "Landmark")
  graph.positionEntity(TokyoTower, position: graph.positionForNewChild(Tokyo, length: 400))
  
  let Germany = graph.quickAddEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 350, angle: (4 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
  graph.updateEntity(Germany, text: "Germany")
  graph.addRelation(Germany, to: Berlin, relation: "Capital")
  graph.positionEntity(Berlin, position: graph.positionForNewChild(Germany, length: 200))
  graph.addRelation(Germany, to: German, relation: "Official Language")
  graph.positionEntity(German, position: graph.positionForNewChild(Germany, length: 200))
  graph.addRelation(Germany, to: NeuschwansteinCastle, relation: "Famous Attractions")
  graph.positionEntity(NeuschwansteinCastle, position: graph.positionForNewChild(Germany, length: 200))
  
  let France = graph.quickAddEntity(Countries, at: graph.pointWithCenter(center: .zero, radius: 350, angle: (5 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
  graph.updateEntity(France, text: "France")
  graph.addRelation(France, to: Paris, relation: "Capital")
  graph.positionEntity(Paris, position: graph.positionForNewChild(France, length: 200))
  graph.addRelation(France, to: French, relation: "Official Language")
  graph.positionEntity(French, position: graph.positionForNewChild(France, length: 200))
  graph.addRelation(Paris, to: EiffelTower, relation: "Landmark")
  graph.positionEntity(EiffelTower, position: graph.positionForNewChild(Paris, length: 200))

  return graph
}
