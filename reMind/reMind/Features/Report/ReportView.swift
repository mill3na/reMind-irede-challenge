//
//  ReportView.swift
//  reMind
//
//  Created by Milena Maia Araújo on 28/01/24.
//

import SwiftUI

struct ReportInfo: Hashable {
    let review: SwipeReview
    let reviewedTerms: [Term]
}

struct ReportModel: Hashable {
    let value: String
    let meaning: String
    let isReviewedCorrectly: Bool
    let isFirst: Bool
    let isLast: Bool
}

struct ReportView: View {
    @Environment (\.colorScheme) var scheme
    @Binding var paths: NavigationPath
    let info: ReportInfo
    
    var reports: [ReportModel] {
        var reports = [ReportModel]()
        for (index, term) in info.reviewedTerms.enumerated() {
            let isReviewedCorrectly = term.lastReview != nil ? true : false
            let isFirst = index == 0 ? true : false
            let isLast = index == info.reviewedTerms.count-1 ? true : false
            reports.append(ReportModel(
                value: term.value ?? "Unknow",
                meaning: term.meaning ?? "Unknow",
                isReviewedCorrectly: isReviewedCorrectly,
                isFirst: isFirst,
                isLast: isLast))
        }
        return reports
    }
    
    var quantityLabel: String {
        let reviewedTerms = info.reviewedTerms.count
        return "\(reviewedTerms)/\(info.review.termsToReview.count + reviewedTerms) were reviewed."
    }
    
    var body: some View {
        VStack {
            Text(quantityLabel)
                .padding()
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(reports, id: \.self) { report in
                        DisclosureGroup {
                            HStack {
                                Text(report.meaning)
                                    .foregroundStyle(.black)

                                Spacer()
                            }
                        } label: {
                            HStack {
                                Image(systemName: report.isReviewedCorrectly ? "checkmark.circle" : "xmark.circle")
                                Text(report.value)
                            }
                                .tint(.black)

                        }
                        
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 0)
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: report.isFirst ? 8 : 0,
                                        bottomLeadingRadius: report.isLast ? 8 : 0,
                                        bottomTrailingRadius: report.isLast ? 8 : 0,
                                        topTrailingRadius: report.isFirst ? 8 : 0
                                    )
                                )
                                .foregroundColor(report.isReviewedCorrectly ? Color("success") : Color("error"))
                            
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                while (paths.count > 0) {
                    paths.removeLast()
                }
            }, label: {
                Text("Close Report")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(scheme == .dark ? .black : .white)
            })
            .buttonStyle(reButtonStyle())
            .padding(.bottom, 30)
            
        }
        
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(reBackground())
        .navigationTitle("Swipper Report")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
    }
}
