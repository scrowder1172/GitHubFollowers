//
//  GHFTitleLabelView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct GHFTitleLabelView: View {
    
    let titleText: String
    let textAlignment: TextAlignment
    let fontSize: CGFloat
    
    var body: some View {
        Text(titleText)
            .multilineTextAlignment(textAlignment)
            .font(.system(size: fontSize, weight: .bold))
            .foregroundStyle(Color.label)
            .truncationMode(.tail)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    GHFTitleLabelView(
        titleText: "Title",
        textAlignment: .center,
        fontSize: 24
    )
    .border(.white)
}
