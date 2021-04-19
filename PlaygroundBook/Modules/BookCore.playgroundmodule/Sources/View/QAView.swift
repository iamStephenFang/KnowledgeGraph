//
//  QAView.swift
//  BookCore
//
//  Created by StephenFang on 2021/4/18.
//

import SwiftUI
import UIKit

public struct QAView: View {
    @State var currentQuestion : Int
    @State var answer : String
    @ObservedObject var graph: Graph
    
    public init(
        currentQuestion: Int = 0,
        answer : String = ""
    ) {
        _currentQuestion = State(wrappedValue: currentQuestion)
        _answer = State(wrappedValue:answer)
        graph = drawCountryGraph()
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Answer:  \(answer)")
                .foregroundColor(.primary)
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .frame(height: 100)
            
            QuestionView(question: "Where is the CAPITAL of CHINA?")
                .foregroundColor(self.currentQuestion == 0 ? .blue : .secondary)
                .onTapGesture {
                    self.currentQuestion = 0
                    self.answer = graph.getAnswerInfo(entityName: "China", relation: "Capital")
                }
            
            QuestionView(question: "What is the LANDMARK of TOKYO?")
                .foregroundColor(self.currentQuestion == 1 ? .blue : .secondary)
                .onTapGesture {
                    self.currentQuestion = 1
                    self.answer = graph.getAnswerInfo(entityName: "Tokyo", relation: "Landmark")
                }
            
            QuestionView(question: "What is the OFFICIAL LANGUAGE of FRANCE?")
                .foregroundColor(self.currentQuestion == 2 ? .blue : .secondary)
                .onTapGesture {
                    self.currentQuestion = 2
                    self.answer = graph.getAnswerInfo(entityName: "France", relation: "Official Language")
                }
            
            QuestionView(question: "Where is the FAMOUS ATTRACTION of GERMAN?")
                .foregroundColor(self.currentQuestion == 3 ? .blue : .secondary)
                .onTapGesture {
                    self.currentQuestion = 3
                    self.answer = graph.getAnswerInfo(entityName: "German", relation: "Famous Attraction")
                }
            
        }
    }
}


struct QuestionView: View {
    var question: String
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .padding()
            .overlay(
                Text(question)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding()
            )
    }
}


