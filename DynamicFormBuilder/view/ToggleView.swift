//
//  ToggleView.swift
//  DynamicFormBuilder
//
//  Created by Shubham Chiplunkar on 14/06/26.
//

import SwiftUI

struct ToggleView: View {
    
    let component: FieldModel
    
    @State private var isOn = false

    
    var body: some View {
        Toggle(component.label, isOn: $isOn)
                   .padding()
    }
}

//#Preview {
//    ToggleView()
//}
