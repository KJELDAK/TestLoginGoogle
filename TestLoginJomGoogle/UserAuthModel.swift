import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import UIKit
class UserAuthModel: ObservableObject {
    @Published var givenName: String = ""
    @Published var profilePicUrl: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""

    init() {
        check() // Check login status on initialization
    }

    // Function to check the current sign-in status
    func checkStatus() {
        if let user = GIDSignIn.sharedInstance.currentUser {
            self.givenName = user.profile?.givenName ?? "Unknown"
            self.profilePicUrl = user.profile?.imageURL(withDimension: 100)?.absoluteString ?? ""
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
            self.profilePicUrl = ""
        }
    }

    // Check for previous sign-in status
    func check() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "Error: \(error.localizedDescription)"
                return
            }
            self.checkStatus()
        }
    }

    // Sign-in function using Google Sign-In
    func signIn() {
            guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
                self.errorMessage = "Unable to get presenting view controller"
                return
            }
            
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
    //            if let error = error {
    //                self.errorMessage = "Error: \(error.localizedDescription)"
    //                return
    //            }
               
                
                guard let result = signInResult else {
                    
                    self.errorMessage = "Sign-in failed. No user information."
                    return
                }
                if let token = result.user.idToken?.tokenString {
                    print("token" + token)
                
                }
                print (result.user.profile?.name)
                
                // Extract user information from result
                let givenName = result.user.profile?.givenName
                let profilePicUrl = result.user.profile?.imageURL(withDimension: 100)?.absoluteString ?? ""
                
                self.givenName = givenName ?? "No Name"
                self.profilePicUrl = profilePicUrl
                self.isLoggedIn = true
            }
        }

    // Sign out the user
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
}

