//
//  GraphExample.swift
//  BookCore
//
//  Created by StephenFang on 2021/4/18.
//

import SwiftUI
import UIKit

public var KnowledgeGraph = createTriplet(firstEntity: "Apple", nextEntity: "Fruit", relation: "TYPE")

public func createEmptyGraph() -> Graph {
    let graph = Graph()
    return graph
}

public func createTriplet(firstEntity: String, nextEntity: String, relation: String) -> Graph {
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

public func createCountryGraph() -> Graph {
    let graph = Graph()
    
    let Countries = Entity(text: "Countries")
    var Beijing = Entity(text: "Beijing")
    var Washington = Entity(text: "Washington, D.C.")
    var Tokyo = Entity(text: "Tokyo")
    var Berlin = Entity(text: "Berlin")
    var London = Entity(text: "London")
    var Paris = Entity(text: "Paris")
    
    var Madarin = Entity(text: "Madarin")
    var English = Entity(text: "English")
    var Japanese = Entity(text: "Japanese")
    var German = Entity(text: "German")
    var French = Entity(text: "French")
    
    var TokyoTower = Entity(text: "Tokyo Tower")
    var EiffelTower = Entity(text: "Eiffel Tower")
    var TheGreatWall = Entity(text: "Great Wall")
    var ForbiddenCity = Entity(text: "Forbidden City")
    var BigBen = Entity(text: "Big Ben")
    var StatueofLiberty = Entity(text: "Statue of Liberty")
    var NeuschwansteinCastle = Entity(text: "Neuschwanstein Castle")
    var TowerofLondon = Entity(text: "Tower of London")
    var LaMarseillaise = Entity(text:"La Marseillaise")
    var BrandenburgGate = Entity(text:"Brandenburg Gate")
    var Sakura = Entity(text:"Sakura")
    
    graph.addEntity(Countries)
    graph.addEntities([Beijing,Washington,Tokyo,Berlin,Paris,London])
    graph.addEntities([Madarin,English,Japanese,German,French])
    graph.addEntities([TokyoTower,EiffelTower,TheGreatWall,StatueofLiberty,NeuschwansteinCastle,BigBen,TowerofLondon,NeuschwansteinCastle,LaMarseillaise,Sakura])
    
    let TheUS = graph.quickAddEntity(Countries, "United States of America", at: graph.pointWithCenter(center: .zero, radius: 350, angle: (0 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
    graph.addRelation(TheUS, to: Washington, relation: "Capital")
    Washington = graph.quickPositionEntity(TheUS, newEntity: Washington, length: 300)
    graph.addRelation(TheUS, to: English, relation: "Official Language")
    English = graph.quickPositionEntity(TheUS, newEntity: English, length: 300)
    graph.addRelation(TheUS, to: StatueofLiberty, relation: "Famous Attraction")
    StatueofLiberty = graph.quickPositionEntity(TheUS, newEntity: StatueofLiberty, length: 300)
    
    let TheUK = graph.quickAddEntity(Countries, "The United Kingdom", at: graph.pointWithCenter(center: .zero, radius: 350, angle: (1 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
    graph.addRelation(TheUK, to: London, relation: "Capital")
    London = graph.quickPositionEntity(TheUK, newEntity: London, length: 300)
    graph.addRelation(TheUK, to: English, relation: "Official Language")
    graph.addRelation(London, to: BigBen, relation: "Landmark")
    BigBen = graph.quickPositionEntity(London, newEntity: BigBen, length: 300)
    graph.addRelation(London, to: TowerofLondon, relation: "Cultural Heritage")
    TowerofLondon = graph.quickPositionEntity(London, newEntity: TowerofLondon, length: 300)
    
    let China = graph.quickAddEntity(Countries, "China", at: graph.pointWithCenter(center: .zero, radius: 350, angle: (2 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
    graph.addRelation(China, to: Madarin, relation: "Official Language")
    Madarin = graph.quickPositionEntity(China, newEntity: Madarin, length: 300)
    graph.addRelation(China, to: Beijing, relation: "Capital")
    Beijing = graph.quickPositionEntity(China, newEntity: Beijing, length: 300)
    graph.addRelation(Beijing, to: TheGreatWall, relation: "Landmark")
    TheGreatWall = graph.quickPositionEntity(Beijing, newEntity: TheGreatWall, length: 300)
    graph.addRelation(Beijing, to: ForbiddenCity, relation: "Cultural Heritage")
    ForbiddenCity = graph.quickPositionEntity(Beijing, newEntity: ForbiddenCity, length: 300)
    
    let Japan = graph.quickAddEntity(Countries, "Japan", at: graph.pointWithCenter(center: .zero, radius: 350, angle: (3 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
    graph.addRelation(Japan, to: Tokyo, relation: "Capital")
    Tokyo = graph.quickPositionEntity(Japan, newEntity: Tokyo, length: 300)
    graph.addRelation(Japan, to: Japanese, relation: "Official Language")
    Japanese = graph.quickPositionEntity(Japan, newEntity: Japanese, length: 300)
    graph.addRelation(Tokyo, to: TokyoTower, relation: "Landmark")
    TokyoTower = graph.quickPositionEntity(Tokyo, newEntity: TokyoTower, length: 300)
    graph.addRelation(Japan, to: Sakura, relation: "National Flower")
    Sakura = graph.quickPositionEntity(Japan, newEntity: Sakura, length: 300)
    
    let Germany = graph.quickAddEntity(Countries, "Germany", at: graph.pointWithCenter(center: .zero, radius: 350, angle: (4 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
    graph.addRelation(Germany, to: Berlin, relation: "Capital")
    Berlin = graph.quickPositionEntity(Germany, newEntity: Berlin, length: 300)
    graph.addRelation(Berlin, to: BrandenburgGate, relation: "Landmark")
    BrandenburgGate = graph.quickPositionEntity(Berlin, newEntity: BrandenburgGate, length: 300)
    graph.addRelation(Germany, to: German, relation: "Official Language")
    German = graph.quickPositionEntity(Germany, newEntity: German, length: 300)
    graph.addRelation(Germany, to: NeuschwansteinCastle, relation: "Famous Attraction")
    NeuschwansteinCastle = graph.quickPositionEntity(Germany, newEntity: NeuschwansteinCastle, length: 300)
    
    let France = graph.quickAddEntity(Countries, "France", at: graph.pointWithCenter(center: .zero, radius: 350, angle: (5 * 60 + 30) * CGFloat.pi/180.0), relation: "has")
    graph.addRelation(France, to: Paris, relation: "Capital")
    Paris = graph.quickPositionEntity(France, newEntity: Paris, length: 300)
    graph.addRelation(France, to: French, relation: "Official Language")
    French = graph.quickPositionEntity(France, newEntity: French, length: 300)
    graph.addRelation(Paris, to: EiffelTower, relation: "Landmark")
    EiffelTower = graph.quickPositionEntity(Paris, newEntity: EiffelTower, length: 300)
    graph.addRelation(France, to: LaMarseillaise, relation: "National Anthem")
    LaMarseillaise = graph.quickPositionEntity(France, newEntity: LaMarseillaise, length: 300)

    return graph
}
