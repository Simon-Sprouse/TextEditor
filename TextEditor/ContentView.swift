import SwiftUI
import AppKit
import Cocoa
import CoreServices
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var text: String = "Enter Your Text Here"
    @State private var fileName: String = "Untitled"

    let dark_gray: Color = rgbToColor(51, 54 , 64)
    let medium_gray:Color = rgbToColor(244, 233, 229)
    
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
                .background(medium_gray)
            
            Spacer() // This will push the footer to the bottom

            // Footer
            Text("This is a footer")
                .frame(maxWidth: .infinity)
                .padding(2)
                .background(dark_gray)
                .foregroundColor(Color.white)
        }

        .padding([.top], 10)
        .background(dark_gray)
    }

    private func openFile() {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.allowsMultipleSelection = false
        openPanel.allowedContentTypes = [UTType.plainText]
        openPanel.allowedContentTypes = [UTType.plainText]
        if openPanel.runModal() == .OK, let url = openPanel.url {
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
