//
//  SearchCustomizeTokenMealListView.swift
//  SearchExampleApp
//
//  Created by Karin Prater on 27.02.23.
//
import FirebaseFirestoreSwift
import SwiftUI

struct SearchCustomizeTokenMealListView: View {
    
    @StateObject var viewModel = CustomMealTokenListViewModel()
    @State var formBool:Bool = false
    @FirestoreQuery var items: [Meik]
    
    init(){
        self._items = FirestoreQuery(collectionPath: "meiks")
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                List {
                    ForEach(viewModel.filteredMeals) { meal in
                       MealCardView(meik: meal)
                    }
                    .listRowSeparator(.hidden, edges: .all)
                }
                .listStyle(.plain)
                .navigationTitle("Find Your Next Meal")
                .searchable(text: $viewModel.searchText,
                            tokens: $viewModel.selectedTokens, token: { token in
                    Text(token.name)
                })
                Button("MeikForm") {
                    formBool = true
                }
            }
        }
        .onAppear(){
            viewModel.set(meiks: items)
        }
        .sheet(isPresented: $formBool) {
            FormView()
        }
    }
}

struct SearchCustomizeTokenMealListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCustomizeTokenMealListView()
    }
}
