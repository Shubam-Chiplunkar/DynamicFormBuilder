//
//  CheckBoxView.swift
//  DynamicFormBuilder
//
//  Created by Shubham Chiplunkar on 14/06/26.
//

import SwiftUI

struct CheckBoxView: View {
    
    let component: FieldModel
    

    @Binding var isChecked : Bool
    
    var body: some View {
        Button {
                    isChecked.toggle()
                } label: {

                    HStack(alignment: .top, spacing: 12) {

                        Image(systemName:
                                isChecked
                                ? "checkmark.square.fill"
                                : "square"
                        )

                        Text(component.label)

                        Spacer()
                    }
                }
                .buttonStyle(.plain)
                .padding()
    }
}

//#Preview {
//    CheckBoxView()
//}

