//
//  TodaysCardsView.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct TodaysCardInfo {
    var cardsToReview: Int
    var theme: reTheme
}

struct TodaysCardsView: View {
    let info: TodaysCardInfo
    let handler: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today's Cards")
                .font(.title)
                .fontWeight(.semibold)
            Text("\(info.cardsToReview) cards to review")
                .font(.title3)

            Button(action: {
                handler()
            }, label: {
                Text("Start Swipping")
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(reColorButtonStyle(info.theme))
            .padding(.top, 10)
        }
        .padding(.vertical, 16)
    }

}
