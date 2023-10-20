//
//  Reqresync
//

import SwiftUI

struct BackgroundcolorView: View {
    
    var body: some View {
        
        Colors.uiBackground
            .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    BackgroundcolorView()
}
