import SwiftUI
import GoogleSignIn

struct ContentView: View {
    @EnvironmentObject var vm: UserAuthModel
    
    // Sign-In Button
    fileprivate func SignInButton() -> some View {
        Button(action: {
            vm.signIn()
        }) {
            Text("Sign In")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    // Sign-Out Button
    fileprivate func SignOutButton() -> some View {
        Button(action: {
            vm.signOut()
        }) {
            Text("Sign Out")
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    // Display User Profile Picture
    fileprivate func ProfilePic() -> some View {
        AsyncImage(url: URL(string: vm.profilePicUrl)) { image in
            image.resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 100, height: 100)
        .clipShape(Circle())
    }
    
    // Display User Information (Name)
    fileprivate func UserInfo() -> Text {
        return Text(vm.givenName)
            .font(.title)
    }
    
    var body: some View {
        VStack {
            // Display user information and profile picture if logged in
            UserInfo()
            ProfilePic()
            
            // Show Sign-In or Sign-Out Button based on login status
            if vm.isLoggedIn {
                SignOutButton()
            } else {
                SignInButton()
            }
            
            // Display error message if any
            if !vm.errorMessage.isEmpty {
                Text(vm.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .navigationTitle("Login")
        .padding()
    }
}

