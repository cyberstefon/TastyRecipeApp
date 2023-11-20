//
//  Meal.swift
//  Recipe App
//
//  Created by Stefon Gholston on 11/16/23.
//

import Foundation

struct Meal: Codable, Identifiable {
    var idMeal: String
    var strMeal: String
    var strMealThumb: String
    var strInstructions: String?
    var strTags: String?
    var strYoutube: String?
    var ingredients: [String] = []

    var id: String { idMeal }

    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strMealThumb, strInstructions, strTags, strYoutube
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        ingredients = []  // Initialize the ingredients array
    }
}
