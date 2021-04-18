//
//  EntityGraphView.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import SwiftUI

struct EntityGraphView: View {
  @ObservedObject var selection: SelectionHandler
  @Binding var entities: [Entity]
  
  var body: some View {
    ZStack {
      ForEach(entities, id: \.id) { entity in
        EntityView(entity: entity, selection: self.selection)
          .offset(x: entity.position.x, y: entity.position.y)
          .onTapGesture {
            self.selection.selectEntity(entity)
          }
      }
    }
  }
}
