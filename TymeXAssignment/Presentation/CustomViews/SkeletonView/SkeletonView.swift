//
//  SkeletonView.swift
//  TymeXAssignment
//
//  Created by thanh tien on 3/6/25.
//

import SwiftUI

struct SkeletonView<S: Shape>: View {
    var shape: S
    var color: Color
    @State private var isAnimating = false
    
    private let rotation = 20.0
    
    init(@ViewBuilder _ shape: () -> S, _ color: Color = .gray.opacity(0.3)) {
        self.shape = shape()
        self.color = color
    }
    
    var body: some View {
        shape
            .fill(color)
            .overlay {
                GeometryReader { proxy in
                    let size = proxy.size
                    let skeletonWidth = size.width / 2
                    let blurRadius = max(skeletonWidth / 2, 30)
                    let blurDiameter = blurRadius * 2
                    let minX = -(skeletonWidth + blurDiameter)
                    let maxX = size.width + skeletonWidth + blurDiameter
                    
                    Rectangle()
                        .fill(.gray)
                        .frame(width: skeletonWidth, height: size.height * 2)
                        .frame(height: size.height)
                        .blur(radius: blurRadius)
                        .rotationEffect(.degrees(rotation))
                        .blendMode(.softLight)
                        .offset(x: isAnimating ? maxX : minX)
                }
            }
            .clipShape(shape)
            .compositingGroup()
            .onAppear {
                guard !isAnimating else {
                    return
                }
                withAnimation(animation) {
                    isAnimating = true
                }
            }
            .onDisappear {
                isAnimating = false
            }
            .transaction { transaction in
                if transaction.animation != animation {
                    transaction.animation = .none
                }
            }
    }
    
    var animation: Animation {
        return .easeInOut(duration: 1.5).repeatForever(autoreverses: false)
    }
}

#Preview {
    @Previewable
    @State var isTapped: Bool = false
    
    SkeletonView {
        Circle()
    }
    .frame(width: 100, height: 100)
    .onTapGesture {
        withAnimation(.smooth) {
            isTapped.toggle()
        }
    }
    .padding(.bottom, isTapped ? 15 : 0)
}
