//
//  Reqresync
//

import SwiftUI

struct CheckmarkPopoverView: View {
    
    var body: some View {
        
        Symbols.checkMark
            .font(.system(.largeTitle, design: .rounded).bold())
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
    
}

#Preview {
    CheckmarkPopoverView()
        .previewLayout(.sizeThatFits)
        .padding()
        .background(.blue)
}
