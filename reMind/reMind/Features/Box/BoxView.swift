//
//  BoxView.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct BoxView: View {
    @State var box: Box
    @State private var searchText: String = ""
    @State private var isEditMode = false
    @State private var isTermEditorPresented = false
    @State var todaysCardView: TodaysCardInfo
    @Binding var paths: NavigationPath
    
    private var filteredTerms: [Term] {
        let termsSet = box.terms as? Set<Term> ?? []
        let terms = Array(termsSet).sorted { lhs, rhs in
            (lhs.value ?? "") < (rhs.value ?? "")
        }
        
        if searchText.isEmpty {
            return terms
        } else {
            return terms.filter { ($0.value ?? "").contains(searchText) }
        }
    }
    
    var body: some View {
        List {
            TodaysCardsView(
                info: todaysCardView
            ) {
                paths.append(
                    SwipeReview(termsToReview: box.termsToReview))
            }
            Section {
                ForEach(filteredTerms, id: \.self) { term in
                    Text(term.value ?? "Unknown")
                        .padding(.vertical, 8)
                        .fontWeight(.bold)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                term.destroy()
                                CoreDataStack.shared.saveContext()
                                todaysCardView.cardsToReview = box.numberOfTerms
                            } label: {
                                Image(systemName: "trash")
                            }

                        }
                }
            } header: {
                Text("All Cards")
                    .textCase(.none)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Palette.label.render)
                    .padding(.leading, -16)
                    .padding(.bottom, 16)
            }

        }
        
        .sheet(isPresented: $isEditMode) {
            BoxEditorView(name: box.name,
                          keywords: box.keywords ?? "",
                          description: box.boxDescription ?? "",
                          theme: Int(box.rawTheme),
                          mode: .edit,
                          createHandler: nil,
                          editHandler: editBox
            
            )
        }
        
        .sheet(isPresented: $isTermEditorPresented) {
            TermEditorView(term: "", 
                           meaning: "",
                           box: box,
                           addTermHandler: addTerm
            )
        }
        
        .navigationDestination(for: SwipeReview.self) { review in
            SwipperView(review: review, paths: $paths)
        }
        
        .scrollContentBackground(.hidden)
        .background(reBackground())
        .navigationTitle(box.name)
        .searchable(text: $searchText, prompt: "")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    isEditMode = true
                    print("edit")
                } label: {
                    Image(systemName: "square.and.pencil")
                }

                Button {
                    isTermEditorPresented = true
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
    
    func editBox(editedBox: BoxInfo) {
        box.name = editedBox.name
        box.keywords = editedBox.keywords
        box.rawTheme = Int16(editedBox.theme)
        box.boxDescription = editedBox.desctiption
        todaysCardView.theme = box.theme
        CoreDataStack.shared.saveContext()
    }
    
    func addTerm(term: Term) {
        box.addToTerms(term)
        CoreDataStack.shared.saveContext()
        todaysCardView.cardsToReview = box.numberOfTerms
    }
    
}
