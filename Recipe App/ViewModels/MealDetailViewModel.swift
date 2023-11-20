//
//  MealDetailViewModel.swift
//  Recipe App
//
//  Created by Stefon Gholston on 11/19/23.
//
import Dispatch
import Combine

class MealDetailViewModel: ObservableObject {
    @Published var detailedMeal: Meal?

    func fetchMealDetails(mealID: String) {
        APIBuilder.shared.fetchDetailedMeal(idMeal: mealID) { result in
            switch result {
            case .success(let detailedMeal):
                DispatchQueue.main.async {
                    self.detailedMeal = detailedMeal
                }
            case .failure(let error):
                print("Error fetching detailed meal: \(error)")
            }
        }
    }
}
