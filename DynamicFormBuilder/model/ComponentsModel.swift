//
//  ComponenstModel.swift
//  DynamicFormBuilder
//
//  Created by Shubham Chiplunkar on 12/06/26.
//

import SwiftUI

struct ComponentsModel: Codable {
    let theme : ThemeModel
    let form_title: String
    let fields: [FieldModel]
    
}

struct ThemeModel: Codable{
    let background_color : String
    let text_color : String
    let border_color : String
    let error_color : String
}

struct FieldModel : Codable , Identifiable{
    
    let uniqueId = UUID()
    let id: String
    let order: Int
    let type: ComponentsType
    var subtype: ComponentSubtype = .none
    let label: String
    let placeholder: String?
    let max_length: Int?
    let error_message: String?
    let required: Bool
    let allow_multiple: Bool?
//    let metadata    : []
//    let default_value: DefaultValue
    let options: [OptionsPayload]?
    let clickable_text_color: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case order
        case type
        case subtype
        case label
        case placeholder
        case max_length
        case error_message
        case required
        case allow_multiple
//        case default_value
        case options
        case clickable_text_color
    }
    
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.order = try container.decode(Int.self, forKey: .order)
        self.type = try container.decode(ComponentsType.self, forKey: .type)
        self.subtype = try container.decodeIfPresent(ComponentSubtype.self, forKey: .subtype) ?? .none
        self.label = try container.decode(String.self, forKey: .label)
        self.placeholder = try container.decodeIfPresent(String.self, forKey: .placeholder)
        self.max_length = try container.decodeIfPresent(Int.self, forKey: .max_length)
        self.error_message = try container.decodeIfPresent(String.self, forKey: .error_message) ?? ""
        self.required = try container.decode(Bool.self, forKey: .required)
        self.allow_multiple = try container.decodeIfPresent(Bool.self, forKey: .allow_multiple) ?? false
//        self.default_value = try container.decode(DefaultValue.self, forKey: .default_value)
        self.options = try container.decodeIfPresent([OptionsPayload].self, forKey: .options) ?? []
        self.clickable_text_color = try container.decodeIfPresent(String.self, forKey: .clickable_text_color)
    }
    
    enum ComponentsType: String, Codable, Equatable {
        case text
        case dropdown
        case checkbox
        case color_picker
        case toggle
        case unknown

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let raw = (try? container.decode(String.self))?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
            switch raw {
            case "text": self = .text
            case "dropdown": self = .dropdown
            case "checkbox": self = .checkbox
            case "color_picker": self = .color_picker
            case "toggle": self = .toggle
            default : self = .unknown // default type on unknown
            }
        }
    }
    
    enum ComponentSubtype: String, Codable, Equatable {
        case plain
        case number
        case secure
        case uri
        case none

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let raw = (try? container.decode(String.self))?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            switch raw {
            case .some("plain"): self = .plain
            case .some("number"): self = .number
            case .some("secure"): self = .secure
            case .some("uri"): self = .uri
            case .some("none"): self = .none
            default: self = .none // default subtype when missing or unknown
            }
        }
    }
    
    enum DefaultValue: Codable { // because default_values can be multiple type
        case string(String)
        case bool(Bool)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()

            if let value = try? container.decode(String.self) {
                self = .string(value)
            } else if let value = try? container.decode(Bool.self) {
                self = .bool(value)
            } else {
                throw DecodingError.typeMismatch(
                    DefaultValue.self,
                    .init(codingPath: decoder.codingPath,
                          debugDescription: "Unsupported default value")
                )
            }
        }
    }
    
}

struct OptionsPayload: Codable {
    let id : String
    let label   : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case label
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.label = try container.decode(String.self, forKey: .label)
    }
}

struct SelectedComponent: Identifiable{
    let id = UUID()
    var fieldModel : FieldModel
    var value: String = ""
    var selectedOption: [String] = []
    var toggleValue: Bool = false
    var isChecked: Bool = false
    var isOn: Bool = false
}
