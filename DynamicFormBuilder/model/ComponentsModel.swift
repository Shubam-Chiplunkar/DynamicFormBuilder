//
//  ComponenstModel.swift
//  DynamicFormBuilder
//
//  Created by Shubham Chiplunkar on 12/06/26.
//

import SwiftUI

struct ComponentsModel : Decodable , Identifiable{
    
    let id: String
    let order: Int
    let type: ComponentsType
    let subtype: ComponentSubtype
    let label: String
    let placeholder: String?
    let max_length: Int?
    let error_message: String?
    let required: Bool
    let allow_multiple: Bool
    let default_values: [String]
    let options: [String]
    let clickable_text_color: String?
    
    enum ComponentsType: Decodable, Equatable {
        case text
        case dropdown
        case checkbox
        case color_picker
        case toggle
        case unknown(String)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let raw = try container.decode(String.self).trimmingCharacters(in: .whitespacesAndNewlines)
            let lowered = raw.lowercased()
            switch lowered {
            case "text": self = .text
            case "dropdown": self = .dropdown
            case "checkbox": self = .checkbox
            case "color_picker": self = .color_picker
            case "toggle": self = .toggle
            default: self = .unknown(raw)
            }
        }
    }
    
    enum ComponentSubtype: Decodable, Equatable {
        case plain
        case number
        case secure
        case uri
        case none
        case unknown(String)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let raw = try? container.decode(String.self)
            guard let raw = raw?.trimmingCharacters(in: .whitespacesAndNewlines), !raw.isEmpty else {
                self = .none
                return
            }
            switch raw.lowercased() {
            case "plain": self = .plain
            case "number": self = .number
            case "secure": self = .secure
            case "uri": self = .uri
            default: self = .unknown(raw)
            }
        }
    }
    
}

struct ComponentsPayload: Decodable {
    let fields : [ComponentsModel]
}
