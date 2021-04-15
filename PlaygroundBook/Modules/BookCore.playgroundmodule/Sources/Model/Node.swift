//
//  Entity.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import CoreGraphics
import UIKit

typealias NodeID = UUID

struct Node: Identifiable {
  var id: NodeID = NodeID()
  var position: CGPoint = .zero
  var text: String = ""
  var color: UIColor = UIColor.colors.randomItem();
}

extension Node {
  static func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.id == rhs.id
  }
}
