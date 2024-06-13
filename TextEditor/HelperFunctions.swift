//
//  HelperFunctions.swift
//  TextEditor
//
//  Created by Simon Sprouse on 6/6/24.
//

import Foundation
import SwiftUI

func rgbToColor(_ r:Int, _ g:Int, _ b:Int) -> Color {
    return Color(
        red:Double(r)/255,
        green:Double(g)/255,
        blue:Double(b)/255
    )
}



