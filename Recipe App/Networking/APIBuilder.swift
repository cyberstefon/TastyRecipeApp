//
//  APIBuilder.swift
//  Recipe App
//
//  Created by Stefon Gholston on 11/19/23.
//

import Foundation

class APIBuilder {
    static let shared = APIBuilder()

    func fetchMeals(category: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                return
            }

            do {
                let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
                if let meals = mealsResponse.meals {
                    completion(.success(meals))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchDetailedMeal(idMeal: String, completion: @escaping (Result<Meal, Error>) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                return
            }

            do {
                let detailedMeal = try JSONDecoder().decode(MealsResponse.self, from: data).meals?.first
                if let detailedMeal = detailedMeal {
                    completion(.success(detailedMeal))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
