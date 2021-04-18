//
//  EntityView.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import SwiftUI

struct EntityView: View {
  static let width = CGFloat(100)
  @State var entity: Entity
  @ObservedObject var selection: SelectionHandler
  var isSelected: Bool {
    return selection.isEntitySelected(entity)
  }
  
  var body: some View {
    Ellipse()
      .fill(Color(entity.color))
      .overlay(Ellipse()
                .stroke(isSelected ? Color.primary : Color.clear, lineWidth: 2 ))
      .overlay(Text(entity.text)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)))
      .frame(width: EntityView.width, height: EntityView.width, alignment: .center)
  }
}
