//
//  GraphDemoView.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//
import SwiftUI

struct GraphDemoView: View {
  @ObservedObject var graph: Graph
  @ObservedObject var selection: SelectionHandler
  
  @State var portalPosition: CGPoint = .zero
  @State var dragOffset: CGSize = .zero
  @State var isDragging: Bool = false
  @State var isDraggingMesh: Bool = false
  
  @State var zoomScale: CGFloat = 1.0
  @State var initialZoomScale: CGFloat?
  @State var initialPortalPosition: CGPoint?
  
    var body: some View {
      VStack {
        GeometryReader { geometry in
          ZStack {
            Rectangle().fill(Color.white)
            GraphView(selection: self.selection, graph: self.graph)
              .scaleEffect(self.zoomScale)
              .offset(
                x: self.portalPosition.x + self.dragOffset.width,
                y: self.portalPosition.y + self.dragOffset.height)
              .animation(.easeIn)
          }
          .gesture(DragGesture()
          .onChanged { value in
            self.processDragChange(value, containerSize: geometry.size)
          }
          .onEnded { value in
            self.processDragEnd(value)
          })
            .gesture(MagnificationGesture()
              .onChanged { value in
                if self.initialZoomScale == nil {
                  self.initialZoomScale = self.zoomScale
                  self.initialPortalPosition = self.portalPosition
                }
                self.processScaleChange(value)
            }
            .onEnded { value in
              self.processScaleChange(value)
              self.initialZoomScale = nil
              self.initialPortalPosition  = nil
            })
        }
      }
    }
}

extension GraphDemoView {
  func distance(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat {
    let xdelta = pow(pointA.x - pointB.x, 2)
    let ydelta = pow(pointA.y - pointB.y, 2)
    
    return sqrt(xdelta + ydelta)
  }
  
  func processDragEnd(_ value: DragGesture.Value) {
    isDragging = false
    dragOffset = .zero
    
    if isDraggingMesh {
      portalPosition = CGPoint(
        x: portalPosition.x + value.translation.width,
        y: portalPosition.y + value.translation.height)
    } else {
      processNodeTranslation(value.translation)
      selection.stopDragging(graph)
    }
  }
  
  func processNodeTranslation(_ translation: CGSize) {
    guard !selection.draggingNodes.isEmpty else { return }
    let scaledTranslation = translation.scaledDownTo(zoomScale)
    graph.processNodeTranslation(
      scaledTranslation,
      nodes: selection.draggingNodes)
  }
  
  func processDragChange(_ value: DragGesture.Value, containerSize: CGSize) {
    if !isDragging {
      isDragging = true
      
      if let node = hitTest(
        point: value.startLocation,
        parent: containerSize) {
        isDraggingMesh = false
        selection.selectNode(node)
        selection.startDragging(graph)
      } else {
        isDraggingMesh = true
      }
    }

    if isDraggingMesh {
      dragOffset = value.translation
    } else {
      processNodeTranslation(value.translation)
    }
  }
  
  func hitTest(point: CGPoint, parent: CGSize) -> Node? {
    for node in graph.nodes {
      let endPoint = node.position
        .scaledFrom(zoomScale)
        .alignCenterInParent(parent)
        .translatedBy(x: portalPosition.x, y: portalPosition.y)
      let dist =  distance(from: point, to: endPoint) / zoomScale
      
      if dist < NodeView.width / 2.0 {
        return node
      }
    }
    return nil
  }
  
  func processScaleChange(_ value: CGFloat) {
    let clamped = clampedScale(value, initialValue: initialZoomScale)
    zoomScale = clamped.scale
    if !clamped.didClamp,
      let point = initialPortalPosition {
      portalPosition = scaledOffset(value, initialValue: point)
    }
  }
  
  func clampedScale(_ scale: CGFloat, initialValue: CGFloat?) -> (scale: CGFloat, didClamp: Bool) {
    let minScale: CGFloat = 0.1
    let maxScale: CGFloat = 2.0
    let raw = scale.magnitude * (initialValue ?? maxScale)
    let value =  max(minScale, min(maxScale, raw))
    let didClamp = raw != value
    return (value, didClamp)
  }
  
  func scaledOffset(_ scale: CGFloat, initialValue: CGPoint) -> CGPoint {
    let newx = initialValue.x*scale
    let newy = initialValue.y*scale
    return CGPoint(x: newx, y: newy)
  }
}
