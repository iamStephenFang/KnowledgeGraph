//
//  BasicGraphView.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//
import SwiftUI

struct BasicGraphView: View {
    @ObservedObject var graph: Graph
    @ObservedObject var selection: SelectionHandler
    
    @State var selectedText: String = ""
    @State var portalPosition: CGPoint = .zero
    @State var dragOffset: CGSize = .zero
    @State var isDragging: Bool = false
    @State var isDraggingMesh: Bool = false
    
    @State var zoomScale: CGFloat = 1.0
    @State var initialZoomScale: CGFloat?
    @State var initialPortalPosition: CGPoint?
    
    var body: some View {
        VStack {
            Text(selectedText)
              .foregroundColor(.secondary)
              .padding()
            GeometryReader { geometry in
                ZStack {
                    Rectangle().fill(Color.clear)
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
                                self.getRelationInfo(graph, selection: selection)
                            }
                            .onEnded { value in
                                self.processDragEnd(value)
                                self.selectedText = ""
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

extension BasicGraphView {
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
            processEntityTranslation(value.translation)
            selection.stopDragging(graph)
        }
    }
    
    func processEntityTranslation(_ translation: CGSize) {
        guard !selection.draggingEntities.isEmpty else { return }
        let scaledTranslation = translation.scaledDownTo(zoomScale)
        graph.processEntityTranslation(
            scaledTranslation,
            entities: selection.draggingEntities)
    }
    
    func processDragChange(_ value: DragGesture.Value, containerSize: CGSize) {
        if !isDragging {
            isDragging = true
            
            if let entity = hitTest(
                point: value.startLocation,
                parent: containerSize) {
                isDraggingMesh = false
                selection.selectEntity(entity)
                selection.startDragging(graph)
            } else {
                isDraggingMesh = true
            }
        }
        
        if isDraggingMesh {
            dragOffset = value.translation
        } else {
            processEntityTranslation(value.translation)
        }
    }
    
    func hitTest(point: CGPoint, parent: CGSize) -> Entity? {
        for entity in graph.entities {
            let endPoint = entity.position
                .scaledFrom(zoomScale)
                .alignCenterInParent(parent)
                .translatedBy(x: portalPosition.x, y: portalPosition.y)
            let dist =  distance(from: point, to: endPoint) / zoomScale
            
            if dist < EntityView.width / 2.0 {
                return entity
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
    
    func getRelationInfo(_ graph: Graph, selection: SelectionHandler){
        self.selectedText = ""
        let selectedNode = selection.onlySelectedEntity(in: graph)
        let startEdges = graph.edges.filter { $0.start == selectedNode?.id }
        let endEdges = graph.edges.filter { $0.end == selectedNode?.id }
        for edge in startEdges {
            let firstNode = graph.entities.filter({ $0.id == edge.end }).first
            self.selectedText.append("\(selectedNode?.text ?? "") - \(edge.text) - \(firstNode?.text ?? "")\n")
        }
        for edge in endEdges {
            let secondNode = graph.entities.filter({ $0.id == edge.start }).first
            self.selectedText.append("\(secondNode?.text ?? "") - \(edge.text) - \(selectedNode?.text ?? "")\n")
        }
    }
}
