//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code
//: # Create your Knowledge Graph
//: On this page, you will try to create a knowledge graph in the form of functions. Related operations have been encapsulated by functions, please refer to the following steps to write your code to fill the blank knowledge graph.
//:
//: ### Step One
//: The first step is to create an **Entity** object, be sure to give it a text identifier, such as 'Apple', then use function `graph.addEntity()` or `graph.addEntities()` to add your entity to the graph, the latter will add entities in the form of an array.
//: ### Step Two
//: The second step is to create **Relation** objects by calling function `graph.addRelation()`, the parameters accepted by this function are the first Entity, the second Entity, and the name of the relation. If you have written a long piece of code and want to change one of the relation, you can call the function `graph.updateRelation()` to update. The parameters accepted by the two functions are the same.
//: ### Step Three
//: The position of **Relation** in the graph is randomly generated from the position of the established **Entity**. If you are not satisfied with the position of the entity, you can change its position by dragging. If you decide to delete an Entity, you can call the function `graph.deleteEntity()` to delete it, this function will delete all relations related to the entity.
//#-hidden-code
import UIKit
import SwiftUI
import BookCore
import PlaygroundSupport
var userGraph: (Graph) -> Graph = { graph in
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, hide, Page_Contents)

//#-editable-code
    let Apple = Entity(text: "Apple")
    let Fruit = Entity(text: "Fruit")
    let Orange = Entity(text: "Orange")
    
    graph.addEntity(Fruit)
    graph.addEntities([Apple, Orange])
    
    graph.addRelation(Fruit, to: Apple, relation: "type")
    graph.addRelation(Fruit, to: Orange, relation: "type")
    
    graph.updateRelation(Fruit, to: Apple, relation: "kind of")
    graph.deleteEntity(Orange)
//#-end-editable-code
//#-hidden-code
    return graph
}
KnowledgeGraph = userGraph(Graph())
PlaygroundPage.current.liveView = instantiateLiveView()
//#-end-hidden-code
/*:
 * callout(
 Precautions):
The newly created entity appears in the middle of the screen by default, which means if you do not create a relation for the created entity, the entity will remain in the middle of the graph.
 */
//: - - -
//: ## [Next page](@next)
