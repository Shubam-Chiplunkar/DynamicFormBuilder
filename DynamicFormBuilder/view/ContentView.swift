//
//  ContentView.swift
//  DynamicFormBuilder
//
//  Created by Shubham Chiplunkar on 12/06/26.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = ComponentViewModel()
    @State private var fieldComponent: [FieldModel] = []
    @State private var selectedComponent: [SelectedComponent] = []
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color(hex: vm.theme?.background_color ?? "#FFFFFF")
                    .ignoresSafeArea()
                VStack {
                    
                    NavigationLink("Add Components"){
                        ComponentSelectionView(onSelect: { component in
                            self.selectedComponent.append(SelectedComponent(fieldModel: component))
                        })
                    }
                    .navigationTitle(vm.navigationTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    
                    List{
                        
                        ForEach($selectedComponent) { $component in
                            switch (component.fieldModel.type){
                            case .text:
                                DynamicTextField(field: component.fieldModel, text: $component.value)
                            case .dropdown:
                                DropdownView(component: component.fieldModel, selectedOption: $component.value)
                            case .toggle:
                                ToggleView(component: component.fieldModel)
                            case .checkbox:
                                CheckBoxView(component: component.fieldModel,isChecked: $component.isChecked)
                            default:
                                EmptyView()
                            }
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .scrollContentBackground(.hidden)
                    
                }
            }
            
            
            Button("Save") {
                validateAndSubmit()
            }
            .buttonStyle(.borderedProminent)
        }
        
        .onAppear {

            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()

            appearance.backgroundColor = UIColor(
                Color(hex: vm.theme?.background_color ?? "#121212")
            )

            appearance.titleTextAttributes = [
                .foregroundColor: UIColor(
                    Color(hex: vm.theme?.text_color ?? "#E0E0E0")
                )
            ]

            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor(
                    Color(hex: vm.theme?.text_color ?? "#E0E0E0")
                )
            ]

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        .alert(alertTitle,
               isPresented: $showAlert) {

            Button("OK", role: .cancel) { }

        } message: {

            Text(alertMessage)
        }
    }
    
    private func deleteItem(at offsets: IndexSet) {
        selectedComponent.remove(atOffsets: offsets)
    }
    
    private func validateAndSubmit() {
        
        for component in selectedComponent {
            
            let field = component.fieldModel
            
            if field.required {
                
                switch field.type {
                    
                case .text:
                    
                    if component.value.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty {
                        
                        alertMessage = field.error_message ??
                        "\(field.label) is required"
                        
                        showAlert = true
                        return
                    }
                    
                case .dropdown:

                    if component.value.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty {
                        
                        alertMessage = field.error_message ??
                        "\(field.label) is required"
                        
                        showAlert = true
                        return
                    }
                    
                case .checkbox:

                    if !component.isChecked {

                        alertMessage = field.error_message ??
                            "\(field.label) must be accepted"

                        showAlert = true
                        return
                    }
                    
                case .toggle:

                    if !component.isOn {

                        alertMessage = field.error_message ??
                            "\(field.label) must be enabled"

                        showAlert = true
                        return
                    }
                default:
                    break
                }
            }
            printSubmission()
        }
    }
    
    
    private func printSubmission() {

        var result: [String: Any] = [:]

        for component in selectedComponent {
            result[component.fieldModel.id] = component.value
        }
        
        print(result)
        alertTitle = "Success"
        alertMessage = "Form submitted successfully."

        showAlert = true
    }
}

#Preview {
    ContentView()
}
