//
//  GHFBodyLabelView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct GHFBodyLabelView: View {
    
    let bodyText: String
    let textAlignment: TextAlignment
    
    var body: some View {
        Text(bodyText)
            .multilineTextAlignment(textAlignment)
            .font(.body)
    }
}

#Preview {
    GHFBodyLabelView(
        bodyText: "Please enter a username. We need to know who to look for 😄",
        textAlignment: .leading
    )
}
