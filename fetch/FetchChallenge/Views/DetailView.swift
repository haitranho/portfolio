//
//  DetailView.swift
//  FetchChallenge
//
//  Created by Hai Ho on 7/3/23.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    let mealName: String
    let ID: String
    
    var body: some View {
        
        List (networkManager.meals) { meal in
            Text("Meal Name: " + mealName)
            Text("Instructions: " + meal.strInstructions!)
            Text("Ingredient/measurements: ")
            
            ForEach(meal.items) { item in
                HStack {
                    Text(item.ingredient)
                    Text(item.measure)

                }
            }
        }
        .onAppear() {
            self.networkManager.fetchData(mealID: ID)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(mealName: "Apam balik", ID: "53049")
    }
}
