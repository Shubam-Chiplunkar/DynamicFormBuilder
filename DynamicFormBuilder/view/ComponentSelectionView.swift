//
//  ComponentSelectionView.swift
//  DynamicFormBuilder
//
//  Created by Shubham Chiplunkar on 14/06/26.
//

import SwiftUI

struct ComponentSelectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var componentVM = ComponentViewModel()
    
    let onSelect: (FieldModel) -> Void
    
    var body: some View {
        List(componentVM.components){ info in
            
            Button {
                onSelect(info)
                dismiss()
                
            }label: {
                HStack(alignment: .center){
                    if info.subtype != .none{
                        Text("\(info.type) : (\(info.subtype))".uppercased())
                    }else{
                        Text("\(info.type)".uppercased())
                    }
                }
            }
        }
        .navigationTitle("Components")
    }
}

#Preview {
    ComponentSelectionView{ components in
    print(components)
    }
}
