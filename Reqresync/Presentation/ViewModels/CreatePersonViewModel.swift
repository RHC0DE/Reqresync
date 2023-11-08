//
//  Reqresync
//

import Foundation

final class CreatePersonViewModel: ObservableObject {
    
    @Published var user = UserCreated()
    @Published private(set) var state: SubmissionFormState?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError =  false
    
    func create() {
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(user)
        
        NetworkingManager
            .shared
            .request(methodType: .POST(data: data),
                     "https://reqres.in/api/users") {[weak self] res in
                
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

    }
}
