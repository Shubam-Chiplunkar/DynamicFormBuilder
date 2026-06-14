//
//  DynamicTextField.swift
//  DynamicFormBuilder
//
//  Created by Shubham Chiplunkar on 14/06/26.
//

import SwiftUI

struct DynamicTextField: View {
    
    let field : FieldModel
    @ObservedObject var vm = ComponentViewModel()
    @Binding var text : String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(field.label)
            fieldView
        }
        .padding(.horizontal)
        
    }
    
    @ViewBuilder
    private var fieldView : some View{
        
        switch field.subtype {
        case .plain:
            TextField(field.placeholder ?? "", text: $text)
                .keyboardType(keyBoardType)
                .border(Color(hex: vm.theme?.border_color ?? ""), width: 1)
                .padding(EdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 5))
        case .number:
            TextField(field.placeholder ?? "", text: $text)
                .keyboardType(keyBoardType)
                .border(Color(hex: vm.theme?.border_color ?? ""), width: 1)
        case .secure:
            SecureField(field.placeholder ?? "", text: $text)
                .textFieldStyle(.roundedBorder)
                .border(Color(hex: vm.theme?.border_color ?? ""), width: 1)
        case .uri:
            TextField(field.placeholder ?? "", text: $text)
                .keyboardType(keyBoardType)
                .border(Color(hex: vm.theme?.border_color ?? ""), width: 1)
                .padding(EdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 5))
        case .none:
            TextField(field.placeholder ?? "", text: $text)
                .keyboardType(keyBoardType)
                .border(Color(hex: vm.theme?.border_color ?? ""), width: 1)
                
        }
        
        
    }
    
    private var keyBoardType: UIKeyboardType {
        switch field.subtype {
        case .plain:
            return .default
        case .number:
            return .numberPad
        case .secure:
            return .default // Not needed
        case .uri:
            return .URL
        case .none:
            return .default
        }
    }
    
}



//#Preview {
//    DynamicTextField(field: <#FieldModel#>)
//}
