//
//  IconSearchTokenMealListView.swift
//  SearchExampleApp
//
//  Created by Karin Prater on 28.02.23.
//
import FirebaseFirestoreSwift
import SwiftUI

struct IconSearchTokenMealListView: View {
    
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
         
            .searchable(text: $viewModel.searchText,
                        tokens: $viewModel.selectedTokens, token: { token in
                //Label(" ", systemImage:  token.icon())
                Text(token.rawValue)
            })
            .searchSuggestions({
                ForEach(viewModel.suggestedTokens) { token in
                    Button {
                        viewModel.selectedTokens.append(token)
                    } label: {
                        Label(token.rawValue, systemImage:  token.icon())
                    }
                }
            })
            
        }, detail: {
            if let meal = selectedMeal {
                DetailView(meal: meal)
            } else {
                Text("Select a Meal")
            }
        })
        .onAppear(){
            viewModel.set(meiks: items)
        }
    }
}

struct IconSearchTokenMealListView_Previews: PreviewProvider {
    static var previews: some View {
        IconSearchTokenMealListView()
    }
}
