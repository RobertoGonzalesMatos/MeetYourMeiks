//
//  CustomMealTokenListViewModel.swift
//  SearchExampleApp
//
//  Created by Karin Prater on 27.02.23.
//

import SwiftUI
import Combine

struct StringToken: Identifiable {
    let name: String
    let id = UUID()
    
    static func testData() -> [StringToken] {
        ["Muffin", "Noodles", "Beef", "Wraps", "Hamburger", "Chicken",
                                     "Falafel", "Pita", "Avocado", "Tomato",
         "Chocolate", "Strawberry", "Coffee", "Cheese"].map {
            StringToken(name: $0)
        }
    }
}


class CustomMealTokenListViewModel: ObservableObject {

    @Published var meals = [Meik]()

    func set(meiks: [Meik]){
        meals = meiks
    }
}


extension String {
    
    func containsAll(_ strings: [String]) -> Bool {
        var result = true
        
        for string in strings {
            if !self.localizedCaseInsensitiveContains(string) {
                result = false
            }
        }
        
        return result
    }
}
