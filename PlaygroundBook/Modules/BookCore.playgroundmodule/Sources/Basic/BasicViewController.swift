//
//  BasicViewController.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//
import UIKit
import SwiftUI

class BasicViewController: UIViewController {
    @Published var graph = KnowledgeGraph
    @Published var selection = SelectionHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let content = BasicGraphView(graph: graph, selection: selection)
        let contentView = UIHostingController(rootView: content)
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
