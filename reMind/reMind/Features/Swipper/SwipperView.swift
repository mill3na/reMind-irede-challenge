//
//  SwipperView.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct SwipperView: View {
    @State var review: SwipeReview
    @State private var direction: SwipperDirection = .none
    @Environment(\.colorScheme) var scheme
    @Binding var paths: NavigationPath
    @State var reviwedTerms = [Term]()
    
    var body: some View {
        VStack {
            SwipperLabel(direction: $direction)
                .padding()
            
            Spacer()
            
            ZStack {
                ForEach(review.termsToReview, id: \.self) { term in
                    SwipperCard(direction: $direction,
                                frontContent: {
                        Text(term.value ?? "Unknow")
                            .foregroundStyle(.black)
                    }, backContent: {
                        Text(term.meaning ?? "Unknow")
                            .foregroundStyle(.black)
                    }, handler: goToNext,
                                theme: term.theme)
                }
            }
            
            Spacer()
            
            Button(action: {
                paths.append(ReportInfo(
                    review: review,
                    reviewedTerms: reviwedTerms
                ))
            }, label: {
                Text("Finish Review")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(scheme == .dark ? .black : .white)
            })
            .buttonStyle(reButtonStyle())
            .padding(.bottom, 30)
            
        }
        
        .navigationDestination(for: ReportInfo.self){ info in
            ReportView(paths: $paths,
                       info: info)
        }
        
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(reBackground())
        .navigationTitle("\(review.termsToReview.count) terms left")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)

    }
    
    func goToNext() {
        guard let term = review.termsToReview.last else { return }
        
        if direction == .left {
            review.termsToReview.removeLast()
        } else if direction == .right {
            term.lastReview = Date()
            CoreDataStack.shared.saveContext()
            review.termsToReview.removeLast()
        }
        reviwedTerms.append(term)

    }
}
