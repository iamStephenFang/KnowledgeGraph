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
  
  public init(
      currentQuestion: Int = 0,
      answer : String = getAnswerInfo(entityName: "China", relation: "Capital")
  ) {
      _currentQuestion = State(wrappedValue: currentQuestion)
      _answer = State(wrappedValue:answer)
  }
  
    public var body: some View {
    VStack(alignment: .center) {
      Text("Answer: \(answer)")
        .foregroundColor(.blue)
        .fontWeight(.bold)
        .font(.title)
        .padding()
        .frame(height: 100)

      QuestionView(question: "Where is the CAPITAL of CHINA?")
        .foregroundColor(self.currentQuestion == 0 ? .primary : .secondary)
        .onTapGesture {
          self.currentQuestion = 0
          self.answer = getAnswerInfo(entityName: "China", relation: "Capital")
        }
      
      QuestionView(question: "What is the LANDMARK of BERLIN?")
        .foregroundColor(self.currentQuestion == 1 ? .primary : .secondary)
        .onTapGesture {
          self.currentQuestion = 1
          self.answer = getAnswerInfo(entityName: "Berlin", relation: "Landmark")
        }
      
      QuestionView(question: "What is the FAMOUS ATTRACTION of THE UNITED STATES OF AMERICA?")
        .foregroundColor(self.currentQuestion == 2 ? .primary : .secondary)
        .onTapGesture {
          self.currentQuestion = 2
          self.answer = getAnswerInfo(entityName: "United States of America", relation: "Famous Attraction")
        }
      
      QuestionView(question: "What is the OFFICIAL LANGUAGE of FRANCE?")
        .foregroundColor(self.currentQuestion == 3 ? .primary : .secondary)
        .onTapGesture {
          self.currentQuestion = 3
          self.answer = getAnswerInfo(entityName: "France", relation: "Official Language")
        }
      
      QuestionView(question: "What is the NATIONAL FLOWER of JAPAN?")
        .foregroundColor(self.currentQuestion == 4 ? .primary : .secondary)
        .onTapGesture {
          self.currentQuestion = 4
          self.answer = getAnswerInfo(entityName: "Japan", relation: "National Flower")
        }
   
    }
  }
}

public func getAnswerInfo(entityName: String, relation: String) -> String{
    let targetTriplet = Triplet.CountryGraphTriplets.filter{$0.firstEntity == entityName && $0.relation == relation}.first
  return targetTriplet?.secondEntity ?? ""
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
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
            )
    }
}


