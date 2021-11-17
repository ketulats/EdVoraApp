//
//  LogoImage.swift
//  Edvora
//
//  Created by Ketul Shah on 17/11/21.
//


import SwiftUI

struct LogoImage: View {
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        Image("logo").frame(width: screenWidth, height: 40, alignment: .top)
    }
}
