//
//  Reqresync
//

import SwiftUI

struct CreatePersonView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CreatePersonViewModel()
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                firstNameRow
                lastNameRow
                jobRow
                
                Section {
                    submitBtn
                }
                
            }
            .navigationTitle(Strings.navigationTitleCreatePerson)
            .toolbar {
                
                doneBtn
                
            }
            .onChange(of: viewModel.state) { formState in
                if formState == .successful {
                    dismiss()
                }
            }
            .alert(isPresented: $viewModel.hasError, error: viewModel.error) {}

        }
        
    }
}

#Preview {
    
    NavigationView {
        CreatePersonView()
    }
    
}

extension CreatePersonView {
    
    var doneBtn: some View {
        Button(Strings.doneBtnTitle) {
            dismiss()
        }
    }
    
    var firstNameRow: some View {
        TextField(Strings.firstNameTxtField, text: $viewModel.user.firstName)
    }
    
    var lastNameRow: some View {
        TextField(Strings.lastNameTxtField, text: $viewModel.user.lastName)
    }
    
    var jobRow: some View {
        TextField(Strings.jobTitleTxtField, text: $viewModel.user.jobTitle)
    }
    
    var submitBtn: some View {
        Button(Strings.submitBtnTitle) {

            viewModel.create()
            
        }
    }
}

