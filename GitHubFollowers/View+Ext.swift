//
//  View+Ext.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

extension View {
    func ghfAlert(isShowingAlert: Binding<Bool>, title: String, message: String, buttonText: String) -> some View {
        ZStack {
            self
                .disabled(isShowingAlert.wrappedValue)
                .blur(radius: isShowingAlert.wrappedValue ? 3 : 0 )
                .opacity(isShowingAlert.wrappedValue ? 0.3 : 1)
            
            if isShowingAlert.wrappedValue {
                GHFAlertView(isShowingView: isShowingAlert, alertTitle: title, alertMessage: message, alertButtonText: buttonText)
            }
        }
    }
}
