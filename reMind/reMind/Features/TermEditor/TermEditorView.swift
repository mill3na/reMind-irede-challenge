//
//  TermEditorView.swift
//  reMind
//
//  Created by Pedro Sousa on 30/06/23.
//

import SwiftUI

struct TermEditorView: View {
    @State var term: String
    @State var meaning: String
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var scheme
    let box: Box
    let addTermHandler: ((Term) -> Void)
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(title: "Term", text: $term)
                reTextEditor(title: "Meaning", text: $meaning)
                
                Spacer()

                Button(action: {
                    addTerm(addOther: true)
                    
                }, label: {
                    Text("Save and Add New")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(scheme == .dark ? .black : .white)
                })
                .buttonStyle(reButtonStyle())
            }
            .padding()
            .background(reBackground())
            .navigationTitle("New Term")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        addTerm(addOther: false)
                       
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
    func addTerm(addOther: Bool) {
        let termModel = Term.newObject()
        termModel.identifier = UUID()
        termModel.meaning = meaning.isEmpty ? nil : meaning
        termModel.value = term.isEmpty ? nil : term
        termModel.creationDate = Date()
        termModel.boxID = box
        termModel.rawTheme = Int16([0, 1, 2].randomElement() ?? 0)
        addTermHandler(termModel)
        
        if !addOther {
            dismiss()
        } else {
            term = ""
            meaning = ""
        }
    }
}
