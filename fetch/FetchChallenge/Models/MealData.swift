//
//  MealData.swift
//  FetchChallenge
//
//  Created by Hai Ho on 7/3/23.
//

import Foundation

struct Result: Decodable {
    
    let meals: [Dessert]
}


struct Dessert: Decodable, Identifiable {
    
        var id: UUID {
            return UUID()
        }
    
        let strMeal: String
        let idMeal: String
}

struct MealData: Decodable {
    
    let meals: [Meal]
    
}

struct Meal: Decodable, Identifiable {
    
    let items: [Item]
    let strInstructions: String?
    let idMeal: String

    var id: UUID {
        return UUID()
    }


}

extension Meal {
    
    struct Item: Decodable, Identifiable {
        let ingredient: String
        let measure: String
        
        var id: UUID {
            return UUID()
        }
    }
}

/* The foundation of this code was borrowed from a StackOverflow
post to help convert the pairs of ingredients and measurements
into an array of pairs.
*/
extension Meal {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        let mealDict = try container.decode([String: String?].self)
        
        // Set the strInstruction property first
        if let instruction = mealDict["strInstructions"] {
            self.strInstructions = instruction
        } else {
            self.strInstructions = nil
        }
        
        // Set the idMeal for Identifiable
        if let id = mealDict["idMeal"] {
            self.idMeal = id!
        } else {
            self.idMeal = ""
        }
        
        // Convert the meal dictionary into an array of item pairs
        var index = 1
        var items = [Item]()
        while
            let ingredient = mealDict["strIngredient\(index)"] as? String,
            let measure = mealDict["strMeasure\(index)"] as? String,
            !measure.isEmpty
        {
            // Stop adding items when when encounting empty values 
            if ingredient == "" {
                break
            }
            items.append(Item(ingredient: ingredient, measure: measure))
            index += 1
        }
        self.items = items
        
    }
}
