//
//  GHFAlertView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct GHFAlertView: View {
    
    @Binding var isShowingView: Bool
    
    let alertTitle: String
    let alertMessage: String
    let alertButtonText: String
    
    init(isShowingView: Binding<Bool>, alertTitle: String, alertMessage: String, alertButtonText: String = "OK") {
        self._isShowingView = isShowingView
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.alertButtonText = alertButtonText
    }
    
    var body: some View {
        VStack {
            GHFTitleLabelView(titleText: alertTitle, textAlignment: .center, fontSize: 20)
                .padding(.bottom, 20)
            
            GHFBodyLabelView(bodyText: alertMessage, textAlignment: .center)
                .padding(.horizontal)
                .padding(.bottom)
            
            GHFButton(backgroundColor: .pink, title: "OK") {
                isShowingView = false
            }
            .padding(.horizontal)
        }
        .frame(width: 280, height: 200)
        .background(Color.systemBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.secondary, lineWidth: 2)
        )
        .animation(.easeOut, value: isShowingView)
    }
}

#Preview {
    GHFAlertView(
        isShowingView: .constant(true),
        alertTitle: "Empty Username",
        alertMessage: "Please enter a username. We need to know who to look for 😄",
        alertButtonText: "OK"
    )
}
