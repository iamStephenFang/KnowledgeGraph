//
//  Extension.swift
//  UserModule
//
//  Created by StephenFang on 2021/4/14.
//

import CoreGraphics
import UIKit

extension CGPoint {
    func translatedBy(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
    
    func alignCenterInParent(_ parent: CGSize) -> CGPoint {
        let x = parent.width/2 + self.x
        let y = parent.height/2 + self.y
        return CGPoint(x: x, y: y)
    }
    
    func scaledFrom(_ factor: CGFloat) -> CGPoint {
        return CGPoint(
            x: self.x * factor,
            y: self.y * factor)
    }
}

extension CGSize {
    func scaledDownTo(_ factor: CGFloat) -> CGSize {
        return CGSize(width: width/factor, height: height/factor)
    }
    
    var length: CGFloat {
        return sqrt(pow(width, 2) + pow(height, 2))
    }
    
    var inverted: CGSize {
        return CGSize(width: -width, height: -height)
    }
}

public extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
    static var red: UIColor {
        return UIColor(red: 255, green: 59, blue: 48)
    }
    static var orange: UIColor {
        return UIColor(red: 255, green: 149, blue: 0)
    }
    static var yellow: UIColor {
        return UIColor(red: 255, green: 204, blue: 0)
    }
    static var green: UIColor {
        return UIColor(red: 76, green: 217, blue: 100)
    }
    static var tealBlue: UIColor {
        return UIColor(red: 90, green: 200, blue: 250)
    }
    static var blue: UIColor {
        return UIColor(red: 0, green: 122, blue: 255)
    }
    static var purple: UIColor {
        return UIColor(red: 88, green: 86, blue: 214)
    }
    static var pink: UIColor {
        return UIColor(red: 255, green: 45, blue: 85)
    }
    public static let colors: [UIColor] = [.red, .orange, .yellow, .green, .tealBlue, .blue, .purple, .pink]
}

extension Triplet {
    public static let CountryGraphTriplets: [Triplet] = [
      Triplet(firstEntity: "Countries", secondEntity: "United States of America", relation: "contain"),
      Triplet(firstEntity: "Countries", secondEntity: "The United Kingdom", relation: "contain"),
      Triplet(firstEntity: "Countries", secondEntity: "China", relation: "contain"),
      Triplet(firstEntity: "Countries", secondEntity: "Japan", relation: "contain"),
      Triplet(firstEntity: "Countries", secondEntity: "Germany", relation: "contain"),
      Triplet(firstEntity: "Countries", secondEntity: "France", relation: "contain"),
      
      Triplet(firstEntity: "China", secondEntity: "Beijing", relation: "Capital"),
      Triplet(firstEntity: "United States of America", secondEntity: "Washington, D.C.", relation: "Capital"),
      Triplet(firstEntity: "The United Kingdom", secondEntity: "London", relation: "Capital"),
      Triplet(firstEntity: "Japan", secondEntity: "Tokyo", relation: "Capital"),
      Triplet(firstEntity: "Germany", secondEntity: "Berlin", relation: "Capital"),
      Triplet(firstEntity: "France", secondEntity: "Paris", relation: "Capital"),
      
      Triplet(firstEntity: "China", secondEntity: "Madarin", relation: "Official Language"),
      Triplet(firstEntity: "United States of America", secondEntity: "English", relation: "Official Language"),
      Triplet(firstEntity: "The United Kingdom", secondEntity: "English", relation: "Official Language"),
      Triplet(firstEntity: "Japan", secondEntity: "Japanese", relation: "Official Language"),
      Triplet(firstEntity: "Germany", secondEntity: "German", relation: "Official Language"),
      Triplet(firstEntity: "France", secondEntity: "French", relation: "Official Language"),
      
      Triplet(firstEntity: "Tokyo", secondEntity: "Tokyo Tower", relation: "Landmark"),
      Triplet(firstEntity: "Paris", secondEntity: "Eiffel Tower", relation: "Landmark"),
      Triplet(firstEntity: "Beijing", secondEntity: "Great Wall", relation: "Landmark"),
      Triplet(firstEntity: "Beijing", secondEntity: "Forbidden City", relation: "Cultural Heritage"),
      Triplet(firstEntity: "London", secondEntity: "Big Ben", relation: "Landmark"),
      Triplet(firstEntity: "United States of America", secondEntity: "Statue of Liberty", relation: "Famous Attraction"),
      Triplet(firstEntity: "Germany", secondEntity: "Neuschwanstein Castle", relation: "Famous Attraction"),
      Triplet(firstEntity: "Berlin", secondEntity: "Brandenburg Gate", relation: "Landmark"),
      Triplet(firstEntity: "London", secondEntity: "Tower of London", relation: "Cultural Heritage"),
      Triplet(firstEntity: "France", secondEntity: "La Marseillaise", relation: "National Anthem"),
      Triplet(firstEntity: "Japan", secondEntity: "Sakura", relation: "National Flower")
    ]
}
