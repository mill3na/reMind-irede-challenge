//
//  BoxEditorView.swift
//  reMind
//
//  Created by Pedro Sousa on 29/06/23.
//

import SwiftUI

enum BoxEditorMode {
    case create
    case edit
}

struct BoxInfo {
    let name: String
    let keywords: String
    let desctiption: String
    let theme: Int
}

struct BoxEditorView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var coreData = CoreDataStack()
    @State var name: String
    @State var keywords: String
    @State var description: String
    @State var theme: Int
    let mode: BoxEditorMode
    let createHandler: ((Box) -> Void)?
    let editHandler: ((BoxInfo) -> Void)?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(title: "Name", text: $name)
                reTextField(title: "Keywords",
                            caption: "Separated by , (comma)",
                            text: $keywords)
                
                reTextEditor(title: "Description",
                             text: $description)

                reRadioButtonGroup(title: "Theme",
                                   currentSelection: $theme)
                Spacer()
            }
            .padding()
            .background(reBackground())
            .navigationTitle(mode == .create ? "New Box": "Edit Box")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if mode == .create {
                            let box = Box.newObject()
                            box.identifier = UUID()
                            box.name = name
                            box.rawTheme = Int16(theme)
                            box.keywords = keywords
                            box.boxDescription = description
                            
                            createHandler?(box)
                        } else {
                            editHandler?(.init(name: name,
                                               keywords: keywords,
                                               desctiption: description,
                                               theme: theme))
                        }
                        
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}
