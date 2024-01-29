//
//  BoxCardView.swift
//  reMind
//
//  Created by Pedro Sousa on 27/06/23.
//

import SwiftUI

struct BoxCardView: View {
    @Binding var box: Box

    var body: some View {
        VStack(alignment: .leading) {
            Text(box.name)
                .font(.title3)
                .fontWeight(.bold)
            
            Label("\(box.numberOfTerms) terms", systemImage: "doc.plaintext.fill")
                .padding(8)
                .background(Palette.reBlack.render.opacity(0.2))
                .cornerRadius(10)
        }
        .foregroundColor(Palette.reBlack.render)
        .padding(16)
        .frame(width: 165, alignment: .leading)
        .background(box.theme.render)
        .cornerRadius(10)
    }
}
