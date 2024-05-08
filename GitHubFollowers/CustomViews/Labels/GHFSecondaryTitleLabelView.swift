//
//  GHFSecondaryLabelVew.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/7/24.
//

import SwiftUI

struct GHFSecondaryTitleLabelView: View {
    let bodyText: String
    let textAlignment: TextAlignment
    
    var body: some View {
        Text(bodyText)
            .multilineTextAlignment(textAlignment)
            .font(.title3)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    GHFSecondaryTitleLabelView(bodyText: "Hello, world", textAlignment: .leading)
}
