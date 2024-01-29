//
//  ContentView.swift
//  reMind
//
//  Created by Pedro Sousa on 23/06/23.
//

import SwiftUI

struct BoxesView: View {
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 140), spacing: 20),
        GridItem(.adaptive(minimum: 140), spacing: 20)
    ]
    
    @ObservedObject var viewModel: BoxViewModel
    @State private var isCreatingNewBox: Bool = false
    @Binding var paths: NavigationPath
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach($viewModel.boxes) { box in
                    NavigationLink (value: box.wrappedValue){
                        BoxCardView(box: box)
                        
                            .reBadge(box.termsToReview)
                    }
                }
            }
            .padding(40)
        }
        
        .navigationDestination(for: Box.self) { box in
            BoxView(
                box: box,
                todaysCardView: .init(
                    cardsToReview: box.termsToReview.count,
                    theme: box.theme
                ), paths: $paths
            )
        }
        
        .onAppear {
            viewModel.update()
        }
        .padding(-20)
        .navigationTitle("Boxes")
        .background(reBackground())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isCreatingNewBox.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isCreatingNewBox) {
            BoxEditorView(name: "",
                          keywords: "",
                          description: "",
                          theme: 0,
                          mode: .create,
                          createHandler: viewModel.saveBox, 
                          editHandler: nil)
        }
    }
}
