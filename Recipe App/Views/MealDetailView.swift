//
//  MealDetailView.swift
//  Recipe App
//
//  Created by Stefon Gholston on 11/16/23.
//

import SwiftUI

struct MealDetailView: View {
    var meal: Meal
    @ObservedObject private var viewModel = MealDetailViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(meal.strMeal)
                    .font(.title)
                Text("Instructions:")
                    .font(.headline)
                Text(viewModel.detailedMeal?.strInstructions ?? "No instructions available")

                if let detailedMeal = viewModel.detailedMeal, !detailedMeal.ingredients.isEmpty {
                    Text("Details:")
                        .font(.headline)
                    ForEach(detailedMeal.ingredients, id: \.self) { detail in
                        Text(detail)
                    }
                }

                if let tags = viewModel.detailedMeal?.strTags {
                    Text("Tags: \(tags)")
                }

                if let youtubeLink = viewModel.detailedMeal?.strYoutube {
                    Link("Watch on YouTube", destination: URL(string: youtubeLink)!)
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchMealDetails(mealID: meal.idMeal)
            }
        }
        .navigationBarTitle(Text(meal.strMeal), displayMode: .inline)
    }
}
