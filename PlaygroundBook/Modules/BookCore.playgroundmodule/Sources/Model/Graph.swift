//
//  Graph.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import Foundation
import CoreGraphics

public class Graph: ObservableObject {
    @Published var entities: [Entity]
    @Published var links: [EdgeProxy]
    
    public init(
        entities: [Entity] = [],
        links: [EdgeProxy] = []
    ) {
        self.entities = entities
        self.links = links
    }
    
    var edges: [Edge] = [] {
        didSet {
            rebuildLinks()
        }
    }
    
    func rebuildLinks() {
        links = edges.compactMap { edge in
            let sentity = entities.filter({ $0.id == edge.start }).first
            let eentity = entities.filter({ $0.id == edge.end }).first
            if let sentity = sentity, let eentity = eentity {
                return EdgeProxy(id: edge.id, start: sentity.position, end: eentity.position, text: edge.text)
            }
            return nil
        }
    }
    
    func entityWithID(_ entityID: EntityID) -> Entity? {
        return entities.filter({ $0.id == entityID }).first
    }
    
    func replace(_ entity: Entity, with replacement: Entity) {
        var newSet = entities.filter { $0.id != entity.id }
        newSet.append(replacement)
        entities = newSet
    }
}

extension Graph {
    func processEntityTranslation(_ translation: CGSize, entities: [DragInfo]) {
        entities.forEach { draginfo in
            if let entity = entityWithID(draginfo.id) {
                let nextPosition = draginfo.originalPosition.translatedBy(x: translation.width, y: translation.height)
                self.positionEntity(entity, position: nextPosition)
            }
        }
    }
    
    func connect(_ firstEntity: Entity, to secondEntity: Entity, relation: String) {
        let newedge = Edge(start: firstEntity.id, end: secondEntity.id, text: relation)
        let exists = edges.contains(where: { edge in
            return newedge == edge
        })
        guard exists == false else {
            return
        }
        edges.append(newedge)
    }
    
    public func addEntity(_ entity: Entity) {
        entities.append(entity)
    }
    
    public func addEntities(_ entitiesToAdd: [Entity]) {
      for entity in entitiesToAdd {
        entities.append(entity)
      }
    }
    
    public func deleteEntity(_ entityToDelete: EntityID) {
        if let delete = entities.firstIndex(where: { $0.id == entityToDelete }) {
            entities.remove(at: delete)
          let remainingEdges = edges.filter({ $0.end != entityToDelete && $0.start != entityToDelete })
          edges = remainingEdges
        }
      rebuildLinks()
    }
    
    public func updateRelation(_ firstEntity: Entity, to secondEntity: Entity, relation: String){
      let newedge = Edge(start: firstEntity.id, end: secondEntity.id, text: relation)
      let exists = edges.contains(where: { edge in
        return newedge == edge
      })
      guard exists == true else {
        return
      }
      let replaceEdge = edges.filter { $0 == newedge }.first
      var newSet = edges.filter { $0.id != replaceEdge?.id }
      newSet.append(newedge)
      edges = newSet
    }
    
    public func addRelation(_ entity: Entity, to secondEntity: Entity, relation: String){
        let center = entity.position
        let radius = 300.0
        let angle = CGFloat.random(in: 1.0..<360.0) * CGFloat.pi/180.0
        let point = CGPoint(x: center.x + CGFloat(radius) * cos(angle), y: center.y + CGFloat(radius) * sin(angle))
        
        self.positionEntity(secondEntity, position: point)
        connect(entity, to: secondEntity, relation: relation)
        rebuildLinks()
    }
    
    public func deleteEntity(_ entity: Entity) {
      deleteEntity(entity.id)
    }

    func updateEntity(_ entity: Entity, text: String) {
      var newEntity = entity
      newEntity.text = text
      replace(entity, with: newEntity)
    }
    
    @discardableResult func positionEntity(_ entity: Entity, position: CGPoint) -> Entity{
        var movedEntity = entity
        movedEntity.position = position
        replace(entity, with: movedEntity)
        rebuildLinks()
        return movedEntity
    }
    
    @discardableResult func quickAddEntity(_ entity: Entity,_ entityName: String, at point: CGPoint? = nil, relation: String) -> Entity {
        let target = point ?? entity.position
        var child = Entity(text: entityName)
        child.position = target
        addEntity(child)
        connect(entity, to: child, relation: relation)
        rebuildLinks()
        return child
    }
    
    @discardableResult func quickPositionEntity(_ entity: Entity, newEntity: Entity, length: CGFloat) -> Entity{
        var movedEntity = newEntity
        let childEdges = edges.filter { $0.start == entity.id }
        if let grandparentedge = edges.filter({ $0.end == entity.id }).first, let grandparent = entityWithID(grandparentedge.start) {
            let baseAngle = angleFrom(start: grandparent.position, end: entity.position)
            let childBasedAngle = positionForChildAtIndex(childEdges.count, baseAngle: baseAngle)
            let newpoint = pointWithCenter(center: entity.position, radius: length, angle: childBasedAngle)
            movedEntity.position = newpoint
        }
        replace(newEntity, with: movedEntity)
        rebuildLinks()
        return movedEntity
    }
    
    func pointWithCenter(center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
      let deltax = radius*cos(angle)
      let deltay = radius*sin(angle)
      let newpoint = CGPoint(x: center.x + deltax, y: center.y + deltay)
      return newpoint
    }
    
    func angleFrom(start: CGPoint, end: CGPoint) -> CGFloat {
      var deltax = end.x - start.x
      let deltay = end.y - start.y
      if abs(deltax) < 0.001 {
        deltax = 0.001
      }
      let angle = atan(deltay/abs(deltax))
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
    
    func getAnswerInfo(entityName: String, relation: String) -> String{
        let firstEntity = entities.filter{$0.text == entityName}.first
        let answerEdge = edges.filter { $0.id == firstEntity?.id && $0.text == relation }.first
        let answerEntity = entities.filter{ $0.id == answerEdge?.end}.first
        return answerEntity?.text ?? ""
    }
}
