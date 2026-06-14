//
//  ComponentViewModel.swift
//  DynamicFormBuilder
//
//  Created by Shubham Chiplunkar on 12/06/26.
//

import SwiftUI
import Combine

class ComponentViewModel: ObservableObject{
    
    @Published var components: [FieldModel] = []
    @Published var navigationTitle: String = ""
    @Published var theme: ThemeModel? = nil
    
    init(){
        getJsonData()
    }
    
    private func getJsonData() {
        
        guard let url = Bundle.main.url(forResource: "components", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let componentPayLoad = try JSONDecoder().decode(ComponentsModel.self, from: data)
            print("Payload: ", componentPayLoad)
            
            DispatchQueue.main.async {
                self.theme = componentPayLoad.theme
                self.navigationTitle = componentPayLoad.form_title
                self.components = componentPayLoad.fields.sorted { lhs, rhs in
                    lhs.order < rhs.order
                }
                
                for component in self.components {
                    print(component.order, component.id)
                }
            }
            
        } catch {
            print("Error parsing JSON: \(error)")
        }
        
    }
    
}
