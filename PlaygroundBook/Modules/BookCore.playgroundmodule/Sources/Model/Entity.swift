//
//  Entity.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import CoreGraphics
import UIKit

public typealias EntityID = UUID

public struct Entity: Identifiable {
  
  public var id: EntityID = EntityID()
  
  var position: CGPoint
  var text: String
  var color: UIColor 
  
  public init(
    text: String = ""
  ) {
    self.position = .zero
    self.text = text
    self.color = UIColor.colors.randomItem()
  }
  
}

extension Entity {
  static func == (lhs: Entity, rhs: Entity) -> Bool {
    return lhs.id == rhs.id
  }
}
