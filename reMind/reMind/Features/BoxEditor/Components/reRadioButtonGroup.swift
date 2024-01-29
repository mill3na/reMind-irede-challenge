//
//  reRadioButtonGroup.swift
//  reMind
//
//  Created by Pedro Sousa on 30/06/23.
//

import SwiftUI

struct reRadioButtonGroup: View {
    @State var title: String = ""
    @Binding var currentSelection: Int
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if !title.isEmpty {
                Text(title)
                    .font(.body)
                    .fontWeight(.bold)
            }

            HStack(spacing: 20) {
                reRadioButton(tag: 0,
                              currentSelection: $currentSelection,
                              color: Palette.mauve.render)
                .overlay {
                    if currentSelection == 0 {
                        Circle()
                            .frame(width: 25, height: 25)
//                            .foregroundStyle(scheme == .black ? Color.black : .white)
                            .foregroundStyle(.white)

                    }
                }
                reRadioButton(tag: 1,
                              currentSelection: $currentSelection,
                              color: Palette.lavender.render)
                
                .overlay {
                    if currentSelection == 1 {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.white)

                    }
                }
                reRadioButton(tag: 2,
                              currentSelection: $currentSelection,
                              color: Palette.aquamarine.render)
                
                .overlay {
                    if currentSelection == 2 {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.white)

                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct reRadioButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        reRadioButtonGroup(title: "Theme", currentSelection: .constant(0))
    }
}
