//
//  SwipeCard.swift
//  reMind
//
//  Created by Pedro Sousa on 04/07/23.
//

import SwiftUI

struct SwipeCard<FrontContent: View, BackContent: View>: View {
    @ViewBuilder var frontContent: () -> FrontContent
    @ViewBuilder var backContent: () -> BackContent

    let handle: 

    var theme: reTheme = .lavender

    // Tap States
    @State private var isFlipped: Bool = false
    @State private var frontAngle = Angle(degrees: 0)
    @State private var backAngle = Angle(degrees: 90)

    // Drag States
    @State private var dragAmout: CGSize = .zero
    @State private var cardAngle: Angle = .zero
    
    private let duration: CGFloat = 0.18
    private let screenSize = UIScreen.main.bounds.size
    private let axis: (CGFloat, CGFloat, CGFloat) = (0, 1, 0)

    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(theme.render)
                backContent()
            }
            .rotation3DEffect(backAngle, axis: axis)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(theme.render)
                frontContent()
            }
            .rotation3DEffect(frontAngle, axis: axis)
        }
        .frame(width: screenSize.width - 60, height: 404)
        .offset(dragAmout)
        .rotationEffect(cardAngle)
        .onTapGesture(perform: flip)
        .gesture(
            DragGesture()
                .onChanged(dragDidChange)
                .onEnded(dragDidEnd)
        )
    }

    private func flip() {
        isFlipped.toggle()
        
        if isFlipped {
            withAnimation(.linear(duration: duration)) {
                frontAngle = Angle(degrees: -90)
            }
            withAnimation(.linear(duration: duration)
                .delay(duration)) {
                    backAngle = Angle(degrees: 0)
                }
        } else {
            withAnimation(.linear(duration: duration)) {
                backAngle = Angle(degrees: 90)
            }
            withAnimation(.linear(duration: duration)
                .delay(duration)) {
                    frontAngle = Angle(degrees: 0)
                }
        }
    }

    private func dragDidChange(_ gesture: DragGesture.Value) {
        dragAmout = gesture.translation
        cardAngle = Angle(degrees: gesture.translation.width * 0.05)
    }

    private func dragDidEnd(_ gesture: DragGesture.Value) {
        withAnimation(.linear(duration: duration)) {
            dragAmout = .zero
            cardAngle = .zero
        }
    }
}

struct SwipeCard_Previews: PreviewProvider {
    static var previews: some View {
        SwipeCard {
            VStack {
                Text("Term")
                Image(systemName: "heart")
            }
        } backContent: {
            Text("Meaning")
        }
    }
}
