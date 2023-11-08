//
//  Reqresync
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @State private var shouldShowCreate = false
    @StateObject private var viewModel = PeopleViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                BackgroundcolorView()
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            
                            ForEach(self.viewModel.users, id: \.id) { personCard in
                                
                                NavigationLink {
                                    PersonDetailView(userId: personCard.id)
                                } label: {
                                    PersonCellView(user: personCard)
                                    
                                }
                                
                            }
                            
                        }
                        .padding()
                        
                    }
                }
            }
            .navigationTitle(Strings.navigationTitlePeople)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    createBtn
                    
                }
                
            }
            .onAppear {
                self.viewModel.fetchUsers()
            }
            .sheet(isPresented: self.$shouldShowCreate) {
                CreatePersonView()
            }
            .alert(isPresented: $viewModel.hasError, error: viewModel.error) {}
            
        }
        
    }
}

#Preview {
    PeopleView()
}

private extension PeopleView {
    
    var createBtn: some View {
        
        Button {
            self.shouldShowCreate.toggle()
        } label: {
            Symbols.addPersonBtn
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
        .disabled(viewModel.isLoading)

        
    }
}
