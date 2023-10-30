import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()

    var body: some View {
        VStack {

            Image("Meik")
                .resizable()
                .frame(width: 250, height: 250)
                .padding(.bottom, 50)

            Form {
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red) // Red text for error messages
                }

                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))

                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))

                Button(action: {
                    viewModel.register()
                }) {
                    Text("Create Account")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color.blue) // Blue background color
                .cornerRadius(10) // Rounded corners
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
            }
            .formStyle(.automatic) // Apply the form style here

            Spacer()
        }
        .navigationBarTitle("Create Account", displayMode: .inline)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
