//
//  MaterialTextField.swift
//  Edvora
//
//  Created by Ketul Shah on 17/11/21.
//

import SwiftUI

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

struct MaterialTextField: View {
    
    @Binding var name: String
    var label: String
    var leftIcon: String
    var required: Bool = true
    var rightIcon: String?
    var right : Bool?
    var handler: () -> Void
    var onChange: () -> Void
    var indicator: Bool = false
    var leftPossition: CGFloat = 20
    @State private var onKeyIn = false
    var body: some View {
        
        ZStack {
            HStack {
                VStack {
                    HStack {
                        Image(leftIcon)
                            .foregroundColor(.secondary)
                            .zIndex(1)
                        
                        TextField(self.name, text: self.$name)
                            .font(.custom("ZonaPro-SemiBold", size: 16))
                            .autocapitalization(.none)
                            .textContentType(.nickname)
                            .padding(.top, 5)
                            .onTapGesture {
                                self.onKeyIn = true
                            }
                            .textFieldStyle(.plain)
                            .zIndex(1)
                            .onSubmit {
                                self.onChange()
                            }
                        
                        if right ?? false {
                            VStack(alignment: .trailing) {
                                Button(action: handler) {
                                    Image(rightIcon ?? "")
                                        .renderingMode(.original)
                                }
                            }.frame(width: 50, height: 30, alignment: .trailing)
                            
                        }
                    }
                    
                }
            }
            .padding(.leading, 0)
            .padding(.trailing, 15)
            .padding()
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color(hex:0xBF9B9B), style: StrokeStyle(lineWidth: 1.0)))
            
            VStack(alignment: .leading) {
                HStack {
                    Text(label)
                }
                .frame(width: self.onKeyIn || self.name != "" ? label.widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold)) : label.widthOfString(usingFont: UIFont.systemFont(ofSize: 17, weight: .bold)), height: 30, alignment: .center)
                .multilineTextAlignment(.leading)
                .font(.custom("ZonaPro-SemiBold", size: self.onKeyIn || self.name != "" ? 14 : 16))
                .foregroundColor(Color(hex:0xBF9B9B))
                .background(.white)
                .offset(y: self.onKeyIn || self.name != "" ? -28 : 3)
                .offset(x: self.onKeyIn || self.name != "" ? 40 : 40)
                .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0))
                .allowsHitTesting(false)
                Rectangle().frame(height: 1)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
            }
            
            VStack {
                if indicator && self.name.count > 0 {
                    HStack {
                        Spacer()
                        Text("Verifying")
                            .font(.custom("ZonaPro-Light", size: 10))
                            .foregroundColor(Color.yellow)
                    }
                }
            }
        }
    }}
