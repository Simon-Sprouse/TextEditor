//
//  ContentView.swift
//  TextEditor
//
//  Created by Simon Sprouse on 6/6/24.
//

import SwiftUI
import AppKit

struct ContentView: View {
    @State private var text: String = ""
    @State private var fileName: String = "Untitled"
    
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
                .padding()
                .border(Color.gray, width: 1)
        }
        .padding()
    }
    
    private func openFile() {
        let panel = NSOpenPanel()
        panel.allowedFileTypes = ["txt"]
        if panel.runModal() == .OK, let url = panel.url {
            if let fileContents = try? String(contentsOf: url) {
                text = fileContents
                fileName = url.lastPathComponent
            }
        }
    }
    
    private func saveFile() {
        let panel = NSSavePanel()
        panel.allowedFileTypes = ["txt"]
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
