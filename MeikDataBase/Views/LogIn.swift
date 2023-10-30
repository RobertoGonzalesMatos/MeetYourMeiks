import SwiftUI

struct LogInView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Meik")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .padding()
                
                Spacer()
                
                Form {
                    if viewModel.errorMessage != "" {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                    
                    HStack {
                        Button(action: {
                            viewModel.logIn()
                        }) {
                            Text("Log In")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                }
                .offset(y: -50)
                .frame(minWidth: 300, maxWidth: 400, minHeight: 200, maxHeight: 300)
                
                VStack {
                    Text("New around here?")
                        .font(.headline) // Larger font size
                        .foregroundColor(.secondary) // Gray text color
                    
                    NavigationLink("Create New Account",
                                   destination: RegisterView())
                        .font(.headline) // Larger font size
                }
                .padding(15)
                
                Spacer()
            }
            .navigationBarTitle("Log In", displayMode: .inline)
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
