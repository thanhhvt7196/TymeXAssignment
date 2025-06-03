//
//  View+Extension.swift
//  TymeXAssignment
//
//  Created by thanh tien on 3/6/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func showErrorAlert(isPresented: Binding<Bool>, title: String = L10n.errorAlertTitle, message: String) -> some View {
        self.alert(
            L10n.errorAlertTitle,
            isPresented: isPresented,
            actions: {
                Button {
                    isPresented.wrappedValue = false
                } label: {
                    Text(L10n.okButton)
                }
            }, message: {
                Text(message)
            }
        )
    }
}
