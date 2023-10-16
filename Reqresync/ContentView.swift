//
//  Reqresync
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world !")
        }
        .padding()
        .onAppear {
            print("Users response 👇")
            dump(
                
               try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
            )
            
            print("User response 👇")
            dump(
                
               try? StaticJSONMapper.decode(file: "UserStaticData", type: UserDetailResponse.self)
            )
        }
        
    }
}

#Preview {
    ContentView()
}
