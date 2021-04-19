//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code
//: # Create your Knowledge Graph
//: On this page, you will try to construct a knowledge graph in the form of functions. Related operations have been encapsulated by functions. Please refer to the following steps to write your code.
//:
//: Suppose you want to know the capital of China, through the triplet "China-Capital-Beijing" you can easily get the answer to the question with other entities information related to Beijing, it is similar to the behavior you search for the capital of China in the online search engine. In fact, many search engines use knowledge graph-related techniques.
//: ### Step One
//: The first step is to create an entity object and add it to the graph object.
//: ### Step Two
//: The second step is to create relational objects and connect related entities
//: ### Step Three
//: If you need to change the entity or relationship information created in the previous two steps, you can use the following functions to modify the created graph object.
//#-hidden-code
import UIKit
import SwiftUI
import BookCore
import PlaygroundSupport
var userGraph: (Graph) -> Graph = { graph in
//#-code-completion(everything, hide)
//#-end-hidden-code
    let Apple = Entity(text: "Apple")
    let Fruit = Entity(text: "Fruit")
    
    graph.addEntity(Apple)
    graph.addEntity(Fruit)
    graph.addRelation(Apple, to: Fruit, relation: "Type")
    
    return graph
}
//#-hidden-code
KnowledgeGraph = userGraph(Graph())
PlaygroundPage.current.liveView = instantiateLiveView()
//#-end-hidden-code
//: ## Precautions
//:- The newly created entity appears in the middle of the screen by default, which means that if you do not create a relationship for the created entity, the entity will remain in the middle
//:- You can drag, zoom in or zoom out the entity and the graph as a whole
//: ## [Next page](@next)
