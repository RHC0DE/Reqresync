//
//  Reqresync
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    @State private var users: [User] = []
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                viewBackgroundcolor
                
                ScrollView {
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        
                        ForEach(self.users, id: \.id) { personCard in
                            
                            PersonCellView(user: personCard)
                            
                        }
                        
                    }
                    .padding()
                    
                }
                
            }
            .navigationTitle(Strings.navigationTitle)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    createBtn
                    
                }
                
            }
            .onAppear {
                
                do {
                    let res = try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
                    
                    users = res.data
                    
                } catch {
                    // TODO: Handle any erros
                    print(error)
                    
                }
                
            }
            
        }
        
    }
}

#Preview {
    PeopleView()
}

private extension PeopleView {
    
    var viewBackgroundcolor: some View {
        Colors.uiBackground
            .ignoresSafeArea(edges: .top)
    }
    
    var createBtn: some View {
        Button {
            
        } label: {
            Symbols.addPersonBtn
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
    
}
