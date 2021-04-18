//
//  SelectionHandler.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import Foundation
import CoreGraphics

struct DragInfo {
  var id: EntityID
  var originalPosition: CGPoint
}

class SelectionHandler: ObservableObject {
  @Published var draggingEntities: [DragInfo] = []
  @Published private(set) var selectedEntityIDs: [EntityID] = []
  
  func selectEntity(_ entity: Entity) {
    selectedEntityIDs = [entity.id]
  }
  
  func isEntitySelected(_ entity: Entity) -> Bool {
    return selectedEntityIDs.contains(entity.id)
  }
  
  func onlySelectedEntity(in graph: Graph) -> Entity? {
    let selectedEntities = self.selectedEntities(in: graph)
    if selectedEntities.count == 1 {
      return selectedEntities.first
    }
    return nil
  }
  
  func selectedEntities(in graph: Graph) -> [Entity] {
    return selectedEntityIDs.compactMap { graph.entityWithID($0) }
  }
  
  func startDragging(_ graph: Graph) {
    draggingEntities = selectedEntities(in: graph)
      .map { DragInfo(id: $0.id, originalPosition: $0.position) }
  }
  
  func stopDragging(_ graph: Graph) {
    draggingEntities = []
  }
}
