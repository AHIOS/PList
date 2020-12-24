//
//  UIColor+hex.swift
//  PList
//
//  Created by Giuseppe Valenti on 20/12/20.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(hex: String) {
        let hexVal = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hexVal).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexVal.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
            return self.adjust(by: abs(percentage) )
        }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
            return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
            if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
                return UIColor(red: min(red + percentage/100, 1.0),
                               green: min(green + percentage/100, 1.0),
                               blue: min(blue + percentage/100, 1.0),
                               alpha: alpha)
            } else {
                return nil
            }
        }
    
    func colorWithBrightnessFactor(factor: CGFloat) -> UIColor {
            var hue : CGFloat = 0
            var saturation : CGFloat = 0
            var brightness : CGFloat = 0
            var alpha : CGFloat = 0
            
            if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
                return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
            } else {
                return self;
            }
        }
    
    func toColor(_ color: UIColor, percentage: CGFloat) -> UIColor {
            let percentage = max(min(percentage, 100), 0) / 100
            switch percentage {
            case 0: return self
            case 1: return color
            default:
                var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
                var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
                guard self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return self }
                guard color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return self }

                return UIColor(red: CGFloat(r1 + (r2 - r1) * percentage),
                               green: CGFloat(g1 + (g2 - g1) * percentage),
                               blue: CGFloat(b1 + (b2 - b1) * percentage),
                               alpha: CGFloat(a1 + (a2 - a1) * percentage))
            }
        }
}
