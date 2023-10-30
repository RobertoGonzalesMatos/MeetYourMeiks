import SwiftUI
import FirebaseFirestoreSwift

struct SearchTokenMeikListView: View {
    @StateObject var viewModel = MeikTokenListViewModel()
    @FirestoreQuery var items: [Meik]

    init() {
        self._items = FirestoreQuery(collectionPath: "meiks")
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.search()) { meik in
                        MeikCardView(meik: meik, isProfile: false)
                    }
                    .listRowSeparator(.hidden, edges: .all)
                }
                .listStyle(.plain)
                .navigationTitle("Get to Know our Meiks!")
                .searchable(text: $viewModel.searchText, tokens: $viewModel.selectedTokens) { token in
                    Text(token.name)
                }
            }
        }
        .onAppear() {
            loadData()
        }
    }

    // Load data when the view appears
    private func loadData() {
        Task {
            while items.count == 0 {
                do {
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                } catch {
                    print("Task sleep error: \(error)")
                }
            }
            viewModel.set(meiks: items)
        }
    }
}

struct SearchTokenMealListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTokenMeikListView()
    }
}
