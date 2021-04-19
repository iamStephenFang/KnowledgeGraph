//
//  Edge.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import Foundation
import CoreGraphics

public typealias EdgeID = UUID

struct Edge: Identifiable {
  var id = EdgeID()
  var start: EntityID
  var end: EntityID
  var text: String
}

public struct EdgeProxy: Identifiable {
  public var id: EdgeID
  var start: CGPoint
  var end: CGPoint
  var text: String
}

extension Edge {
  static func == (lhs: Edge, rhs: Edge) -> Bool {
    return lhs.start == rhs.start && lhs.end == rhs.end
  }
}

