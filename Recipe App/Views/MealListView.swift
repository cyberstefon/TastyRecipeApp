//
//  MealListView.swift
//  Recipe App
//
//  Created by Stefon Gholston on 11/16/23.
//

import SwiftUI
import Combine

struct MealListView: View {
    @State private var meals: [Meal]?
    @ObservedObject private var viewModel = MealDetailViewModel()

    var body: some View {
        NavigationView {
            List(meals ?? []) { meal in
                NavigationLink(destination: MealDetailView(meal: meal)) {
                    HStack {
                        URLImage(url: meal.strMealThumb)
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                        Text(meal.strMeal)
                    }
                }
            }
            .navigationTitle("Tasty Desserts 🍪")
            .onAppear {
                if meals == nil {
                    fetchMeals()
                }
            }
        }
    }

    func fetchMeals() {
        APIBuilder.shared.fetchMeals(category: "Dessert") { result in
            switch result {
            case .success(let fetchedMeals):
                DispatchQueue.main.async {
                    self.meals = fetchedMeals
                }
            case .failure(let error):
                print("Error fetching meals: \(error)")
            }
        }
    }
}
