//
//  EdgeView.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import SwiftUI

typealias AnimatablePoint = AnimatablePair<CGFloat, CGFloat>
typealias AnimatableCorners = AnimatablePair<AnimatablePoint, AnimatablePoint>

struct EdgeShape: Shape {
  var startx: CGFloat = 0
  var starty: CGFloat = 0
  var endx: CGFloat = 0
  var endy: CGFloat = 0
  
  init(edge: EdgeProxy) {
    startx = edge.start.x
    starty = edge.start.y
    endx = edge.end.x
    endy = edge.end.y
  }
  
  func path(in rect: CGRect) -> Path {
    var linkPath = Path()
    linkPath.move(to: CGPoint(x: startx, y: starty)
                    .alignCenterInParent(rect.size))
    linkPath.addLine(to: CGPoint(x: endx, y:endy)
                      .alignCenterInParent(rect.size))
    return linkPath
  }
  
  var animatableData: AnimatableCorners {
    get { AnimatablePair(
      AnimatablePair(startx, starty),
      AnimatablePair(endx, endy))
    }
    set {
      startx = newValue.first.first
      starty = newValue.first.second
      endx = newValue.second.first
      endy = newValue.second.second
    }
  }
}

struct EdgeView: View {
  var edge: EdgeProxy
  var body: some View {
    EdgeShape(edge: edge)
      .stroke(Color.primary, lineWidth: 2)
      .overlay(
        Text(edge.text)
          .foregroundColor(.primary)
          .offset(x: (edge.start.x + edge.end.x) / 2.0, y: (edge.start.y + edge.end.y) / 2.0)
    )
  }
}
