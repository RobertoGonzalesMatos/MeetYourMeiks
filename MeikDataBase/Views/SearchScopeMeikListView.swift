//
//  SearchScopeMealListView.swift
//  SearchExampleApp
//
//  Created by Karin Prater on 27.02.23.
//

import FirebaseFirestoreSwift
import SwiftUI

struct SearchScopeMealListView: View {
    
    @StateObject var viewModel = MeikTokenListViewModel()
    @State var selectedMeal: Meik? = nil
    @FirestoreQuery var items: [Meik]
    
    init(){
        self._items = FirestoreQuery(collectionPath: "meiks")
    }
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List(selection: $selectedMeal) {
                ForEach(viewModel.filteredMeals) { meal in
                    MealCardView(meik: meal)
                        .tag(meal)
                }
                .listRowSeparator(.hidden, edges: .all)
            }
            .listStyle(.plain)
            .navigationTitle("Find Your Next Meal")
        }, detail: {
            if let meal = selectedMeal {
                DetailView(meal: meal)
            } else {
                Text("Select a Meal")
            }
        })
        //.searchable(text: $viewModel.searchText)
        .searchable(text: $viewModel.searchText,
                    tokens: $viewModel.selectedTokens,
                    suggestedTokens: $viewModel.suggestedTokens,
                    token: { token in
            Text(token.rawValue)
        })
        .searchScopes($viewModel.mealSearchScope, scopes: {
            Text("All").tag(MealSearchScope.all)
        })
        .onAppear(){
            viewModel.set(meiks: items)
        }
    }
}





struct SearchScopeMealListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScopeMealListView()
    }
}
