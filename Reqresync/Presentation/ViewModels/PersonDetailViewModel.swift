//
//  Reqresync
//

import Foundation

final class PersonDetailViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserDetailResponse?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isloading = false
    @Published var hasError =  false
    
    func fetchUsersDetail(for id: Int) {
        
        isloading = true //When you first call the function
        NetworkingManager.shared.request("https://reqres.in/api/users/\(id)?delay=3", type: UserDetailResponse.self) { [weak self] res in
            
            DispatchQueue.main.async {
                defer { self?.isloading = false }
                switch res {
                case .success(let response):
                    self?.userInfo =  response
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
                
            }
            
        }
        
    }
}
