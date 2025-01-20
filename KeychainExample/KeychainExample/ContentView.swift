//
//  ContentView.swift
//  KeychainExample
//
//  Created by Luis Alejandro Ramirez Suarez on 20/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var password: String = ""
    @State private var storedPassword: String? = nil
    @State private var isPasswordStored: Bool = false
    
    let key = "userPassword" // Key to store the password in Keychain
    
    var body: some View {
        NavigationView {
            VStack {
                SecureField("Enter Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    Button(action: {
                        // Store the password in Keychain
                        if !password.isEmpty, KeychainHelper.save(key: key, value: password) {
                            storedPassword = "Stored Password: \(password)"
                            isPasswordStored = true
                            print("Password stored successfully.")
                        } else {
                            print("Failed to store the password.")
                        }
                    }) {
                        Text("Save Password")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Retrieve the password from Keychain
                        if let retrievedPassword = KeychainHelper.get(key: key), !retrievedPassword.isEmpty {
                            storedPassword = "Retrieved password: \(retrievedPassword)"
                            isPasswordStored = true
                            print("Retrieved password: \(retrievedPassword)")
                        } else {
                            print("No password found.")
                        }
                    }) {
                        Text("Retrieve Password")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                
                if let storedPassword = storedPassword {
                    Text(storedPassword)
                        .padding()
                        .foregroundColor(.gray)
                }
                
                Button(action: {
                    // Delete the password from Keychain
                    if KeychainHelper.delete(key: key) {
                        storedPassword = nil
                        isPasswordStored = false
                        print("Password deleted successfully.")
                    } else {
                        print("Failed to delete the password.")
                    }
                }) {
                    Text("Delete Password")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Keychain Example")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
