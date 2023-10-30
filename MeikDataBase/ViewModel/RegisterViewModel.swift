import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterViewModel: ObservableObject{
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init(){
        
    }
    
    func register(){
        guard validate() else{
            return
        }
        Auth.auth().createUser(withEmail: email, password: password){_,_ in 
        }
    }
    
    
    private func validate() -> Bool{
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
                !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            errorMessage = "Please Fill All Fields"
            return false
        }
        guard email.contains("@brown") && email.contains(".") else {
            errorMessage = "Please enter valid Brown email"
            return false
        }
        guard password.count>=6 else {
            errorMessage = "Please enter valid email"
            return false
        }
        return true
    }
}

