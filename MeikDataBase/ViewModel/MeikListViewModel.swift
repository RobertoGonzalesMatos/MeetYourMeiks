//
//  MealListViewModel.swift
//  SearchExampleApp
//
//  Created by Karin Prater on 27.02.23.
//

import Foundation

class MealListViewModel: ObservableObject {
    
    @Published var meals = [Meik]()
    @Published var searchText: String = ""
    
    var filteredMeals: [Meik] {
        guard !searchText.isEmpty else { return meals }
        return meals.filter { meal in
            meal.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    
    func set(meiks: [Meik]) {
        meals = meiks
    }

}
