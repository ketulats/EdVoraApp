//
//  ContentView.swift
//  Shared
//
//  Created by Ketul Shah on 17/11/21.
//

import SwiftUI
import UIKit

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct ContentView: View {
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var isSecured: Bool = true
    @State private var isValid : Bool   = false
    @State private var errorText : String = "Login Successfully."
    @State private var showingAlert = false
    let verticalPaddingForForm = 40.0
    
    var body: some View {
        ZStack {
            
            VStack(spacing: CGFloat(verticalPaddingForForm)) {
                //Logo
                LogoImage()
                
                // Email
                HStack {
                    MaterialTextField(name: $name, label: "UserName",leftIcon: "iconUserName", handler: {}, onChange: {
                        _ = self.onSubmitNameTextField()
                    })
                }
                .background(Color.white)
                
                //Password
                HStack {
                    if isSecured {
                        MaterialTextFieldSecure(name: $password, label: "Password",leftIcon: "iconPassword", rightIcon: "iconEye", right: true, handler : {
                            self.passHideShowFunction()
                        }, onChange: {
                            _ = self.onSubmitPasswordField()
                        })
                    } else {
                        MaterialTextField(name: $password, label: "Password",leftIcon: "iconPassword", rightIcon: "iconEye", right: true, handler: {
                            self.passHideShowFunction()
                        },onChange: {
                            _ = self.onSubmitPasswordField()
                        })
                    }
                }
                .background(Color.white)
                
                // Forgot Password
                VStack(alignment: .trailing) {
                    Button(action: {showingAlert = true }) {
                        Text("Forgot Password?")
                    }.alert("Comming Soon", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    .foregroundColor(Color(hex:0xBF9B9B)) .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }.frame(width: 300, height: 0, alignment: .trailing)
                
                // Button Login
                Button(action: {self.onSubmitLogin()}) {
                    Text("LOGIN")
                        .padding().frame(minWidth: 0, maxWidth: .infinity)
                    
                }
                .background(Color(hex:0xBF9B9B))
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .alert(errorText, isPresented: $isValid) {
                    Button("OK", role: .cancel) { }
                }
                
                //SignUp Button
                HStack() {
                    Text("Don’t have an account?").padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .foregroundColor(Color(hex:0x959595))
                    
                    Button(action: {showingAlert = true}) {
                        Text("Sign Up")
                    }
                    .foregroundColor(Color(hex:0xBF9B9B))
                    .alert("Comming Soon", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
                }
            }.padding(.horizontal, CGFloat(verticalPaddingForForm))
        }
    }
    
    // Show and Hide Password Function.
    func passHideShowFunction() {
        self.isSecured.toggle()
    }
    
    //Login Button Action
    func onSubmitLogin() {
        if name == "" || password == "" {
            errorText = "All fields are mendetory."
            isValid = true
        }else if !onSubmitNameTextField() {
            isValid = true
        }else if !onSubmitPasswordField() {
            isValid = true
        }else {
            isValid = true
            errorText = "Login Successfully."
        }
        print("isValid \(isValid)" )
        
    }
    
    // Validate Password Click
    func onSubmitPasswordField() -> Bool {
        if !self.textFieldValidatorPassword(password) {
            errorText = "Password should have 8 characters, 1 number, 1 upper case alphabet, 1 lower case alphabet"
            return false
        }
        return true
    }
    
    // Validate Password
    func textFieldValidatorPassword(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    // Validate UserName Click
    func onSubmitNameTextField () -> Bool{
        if !textFieldValidatorName(name) {
            errorText = "Username should not have spaces and no upper case alphabet"
            return false
        }else if !self.textFieldValidatorEmail(name){
            errorText = "Invalide Email"
            return false
        }else {
            return true
        }
    }
    
    // Validate UserName
    func textFieldValidatorName(_ string: String) -> Bool {
        
        let emailFormat = "[^<A-Z>< ]+$"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    // Validate UserName with email
    func textFieldValidatorEmail(_ string: String) -> Bool {
        
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
