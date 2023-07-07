//
//  ContentView.swift
//  FetchChallenge
//
//  Created by Hai Ho on 7/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        // Create a NavigationView with each desert entry
        NavigationView {
            List(networkManager.result) { meal in
                NavigationLink(destination: DetailView(mealName: meal.strMeal, ID: meal.idMeal)) {
                    HStack {
                        Text(meal.strMeal)

                    }
                    .onAppear {
                    }                    
                }
            }
            .navigationBarTitle("Desserts")
            
        }
        .onAppear {
            self.networkManager.fetchData()
        }
        .navigationViewStyle(.stack)
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
