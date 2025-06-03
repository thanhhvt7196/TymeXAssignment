//
//  PlainListCell.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import SwiftUI

struct PlainListCell<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .listRowInsets(EdgeInsets())
            .listRowSpacing(.zero)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
}
