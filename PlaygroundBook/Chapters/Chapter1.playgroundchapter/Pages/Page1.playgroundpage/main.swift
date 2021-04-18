//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code
//: # The Basic Structure of Knowledge Graph
//: There are many real-world scenarios that are well suitable to be represented by knowledge graphs. For example, in a social network graph, we can have both "person" entities and "company" entities. The relationship between people can be "friends" or "colleagues". The relationship between a person and a company can be a "current" or "former" relationship.
//:
//: The basic structure of the knowledge graph is the triple composed of **"Entity-Relationship-Entity"**, which is the core of the knowledge graph.
//:
//: **Entities** refer to things in the real world such as people, place names, concepts, etc., while **relationship**s are used to describe some kind of connection between different entities. In a knowledge graph, two nodes can be connected together with an undirected edge if there is some kind of relationship between them. Here the nodes are entities and the edge between two nodes is called a relationship.
//: ## Instructions
//: You can create the basic composition of knowledge graph by completing the code below. After the code runs successfully, you are able to **drag and drop**, point and zoom the entities on the right.
//#-hidden-code
import UIKit
import SwiftUI
import BookCore
import PlaygroundSupport
//#-code-completion(everything, hide)
//#-end-hidden-code
KnowledgeGraph = drawComposition(firstEntity: /*#-editable-code*/"Apple"/*#-end-editable-code*/, nextEntity: /*#-editable-code*/"Fruit"/*#-end-editable-code*/, relation: /*#-editable-code*/"Type "/*#-end-editable-code*/)
//#-hidden-code
PlaygroundPage.current.liveView = instantiateLiveView()
//#-end-hidden-code
//: ## [Next page](@next)
