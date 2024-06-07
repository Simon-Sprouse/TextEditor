//
//  ContentView.swift
//  TextEditor
//
//  Created by Simon Sprouse on 6/6/24.
//

import SwiftUI
import AppKit
import Cocoa
import CoreServices
import UniformTypeIdentifiers

func rgbToColor(_ r:Int, _ g:Int, _ b:Int) -> Color {
    return Color(
        red:Double(r)/255,
        green:Double(g)/255,
        blue:Double(b)/255
    )
}

struct ContentView: View {
    @State private var text: String = "Enter Yor Text Here"
    @State private var fileName: String = "Untitled"
    
    
   
    
    let background_color: Color = rgbToColor(255, 0 , 80)
    
    var body: some View {
        VStack {
            HStack {
                Button("Open") {
                    openFile()
                }
                Button("Save") {
                    saveFile()
                }
            }

            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .padding()
                .background(background_color)
        }
        .padding([.top], 10)
        .background(Color.green)
    }
    
    private func openFile() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [UTType.plainText]
        if panel.runModal() == .OK, let url = panel.url {
            if let fileContents = try? String(contentsOf: url) {
                text = fileContents
                fileName = url.lastPathComponent
            }
        }
    }
    
    private func saveFile() {
        let panel = NSSavePanel()
        panel.allowedContentTypes = [UTType.plainText]
        panel.nameFieldStringValue = fileName
        if panel.runModal() == .OK, let url = panel.url {
            try? text.write(to: url, atomically: true, encoding: .utf8)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
