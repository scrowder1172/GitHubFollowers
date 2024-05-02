//
//  GHFTextField.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct GHFTextField: View {
    
    @Binding var inputText: String
    
    var body: some View {
        TextField("Enter a username", text: $inputText)
            .autocorrectionDisabled()
            .padding(10)
            .foregroundStyle(Color.label)
            .tint(Color.label)
            .multilineTextAlignment(.center)
            .font(.title2)
            .background(Color.tertiarySystemBackground)
            .clipShape(.rect(cornerRadius: 30))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.systemGray4, lineWidth: 2)
            )
            .padding()
            .submitLabel(.go)
    
        
    }
}

#Preview("TextField") {
    GHFTextField(inputText: .constant("Hello"))
}

#Preview("TabView") {
    GHFTabView()
}
