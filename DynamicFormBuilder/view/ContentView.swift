//
//  ContentView.swift
//  DynamicFormBuilder
//
//  Created by Shubham Chiplunkar on 12/06/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = ComponentViewModel()
    
    var body: some View {
//        print(vm)
        Text("Hello World")
        .onAppear{
            vm.getJsonData()
        }
    }
}

#Preview {
    ContentView()
}
