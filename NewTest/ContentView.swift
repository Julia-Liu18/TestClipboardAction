//
//  ContentView.swift
//  NewTest
//
//  Created by Julia on 2023/6/14.
//

import SwiftUI

struct ContentView: View {
    @State private var copiedText: String = ""
       
       var body: some View {
           VStack {
               TextField("输入要复制的文本", text: $copiedText)
                               .padding()
               
               Button(action: {
                   copyToClipboard()
               }) {
                   Text("复制")
                       .font(.headline)
                       .foregroundColor(.white)
                       .padding()
                       .background(Color.blue)
                       .cornerRadius(10)
               }
           }
           .padding()
       }
       
       func copyToClipboard() {
           UIPasteboard.general.string = copiedText
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
