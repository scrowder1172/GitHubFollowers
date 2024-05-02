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
            .padding(5)
            .border(Color.systemGray4, width: 2)
            .foregroundStyle(Color.label)
            .tint(Color.label)
            .multilineTextAlignment(.center)
            .font(.title2)
            .background(Color.tertiarySystemBackground)
            .autocorrectionDisabled()
            .padding()
    
        
    }
}

#Preview {
    GHFTextField(inputText: .constant("Hello"))
}
