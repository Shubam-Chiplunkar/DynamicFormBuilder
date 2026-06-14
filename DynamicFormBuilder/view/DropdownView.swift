//
//  DropdownView.swift
//  DynamicFormBuilder
//
//  Created by Shubham Chiplunkar on 14/06/26.
//

import SwiftUI

struct DropdownView: View {
    
    let component: FieldModel
    
    @Binding var selectedOption : String
    @State private var showPicker = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(component.label)
            
            Button {
                showPicker.toggle()
            } label: {
                
                HStack {
                    Text(
                        selectedOption.isEmpty ? "Select Option" : selectedOption
                    )
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray)
                )
            }
        }
        .sheet(isPresented: $showPicker) {
            
            NavigationStack {
                
                List(component.options ?? [], id: \.id) { option in
                    
                    Button(option.label) {
                        
                        selectedOption = option.label
                        showPicker = false
                    }
                }
                .navigationTitle(component.label)
            }
        }
    }
}

//#Preview {
//    DropdownView()
//}
