//
//  NetworkManager.swift
//  FetchChallenge
//
//  Created by Hai Ho on 7/3/23.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var meals = [Meal]()
    @Published var result = [Dessert]()
        
    func fetchData() {
        // Create a URL
        if let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") {
            
            // Create a URL Session
            let session = URLSession(configuration: .default)
            
            // Decode the JSON
            let task = session.dataTask(with: url) { data, response, error in
                
                
                if error == nil {
                    let decoder = JSONDecoder()
                    
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Result.self, from: safeData)
                            DispatchQueue.main.async {
                                self.result = results.meals
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchData(mealID: String) {

        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"

        // Create a URL
        if let url = URL(string: urlString) {

            // Create a URL session
            let session = URLSession(configuration: .default)

            // Perform a data task with the session
            let task = session.dataTask(with: url) { data, response, error in

                // If no error, decode the JSON
                if error == nil {
                    let decoder = JSONDecoder()

                    if let safeData = data {
                        do {
                            let mealDetail = try decoder.decode(MealData.self, from: safeData)
                            DispatchQueue.main.async {
                                self.meals = mealDetail.meals

                            }

                        } catch {
                            print(error)
                        }
                    }

                }
            }
            task.resume()
        }
    }
}
