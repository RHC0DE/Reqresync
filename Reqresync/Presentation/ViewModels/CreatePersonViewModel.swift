//
//  Reqresync
//

import Foundation

final class CreatePersonViewModel: ObservableObject {
    
    @Published var user = UserCreated()
    @Published private(set) var state: SubmissionFormState?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isLoadingWhileSending =  false
    @Published var hasError =  false
    
    func create() {
        
        state = .submitting 
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(user)
        
        NetworkingManager
            .shared
            .request(methodType: .POST(data: data),
                     "https://reqres.in/api/users?delay=3") {[weak self] res in
                
                DispatchQueue.main.async {
                    
                    switch res {
                    case .success:
                        self?.state = .successful
                    case .failure(let error):
                        self?.state = .unsuccessful
                        self?.hasError = true
                        self?.error = error as? NetworkingManager.NetworkingError
                    }
                    
                }
                
            }
        
    }
}

extension CreatePersonViewModel {
    enum SubmissionFormState {
        case successful
        case unsuccessful
        case submitting
    }
}
