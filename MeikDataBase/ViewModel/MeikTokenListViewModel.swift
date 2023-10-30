import Foundation
/**
    StringToken is an information container object with a name and id
 */
struct StringToken: Identifiable {
    let name: String
    let id = UUID()
}
/**
 A view model for managing token-based searches and filtering in the MeikDataBase app.

 The `MeikTokenListViewModel` class provides properties and methods to perform token-based searches, filter data, and manage the list of Meiks.

 - Note: This view model is used to facilitate searching and filtering operations.

 */
class MeikTokenListViewModel: ObservableObject {
    @Published var meiks = [Meik]()
    @Published var searchText: String = ""
    @Published var selectedTokens = [StringToken]()
    /**
     Performs a search and filtering operation based on the current search text and selected tokens.

     - Returns: An array of `Meik` objects that match the search criteria and selected tokens.

     - Note: This function filters the list of Meiks based on the search text and selected tokens. If both the search text and tokens are empty, it returns the original list of Meiks.

     */
    func search() -> [Meik] {
        if searchText.isEmpty && selectedTokens.isEmpty {
            return meiks
        }

        if searchText.contains(",") {
            selectedTokens.append(StringToken(name: String(searchText.dropLast())))
            searchText = ""
            return meiks
        }

        var meikFilter = meiks

        if !searchText.isEmpty {
            meikFilter = meiks.filter { meik in
                let searchTextLowercased = searchText.lowercased()
                return meik.name.lowercased().contains(searchTextLowercased) ||
                       meik.concentration.lowercased().contains(searchTextLowercased) ||
                       meik.tags.joined(separator: " ").lowercased().contains(searchTextLowercased) ||
                       meik.location.lowercased().contains(searchTextLowercased) ||
                       meik.year.lowercased().contains(searchTextLowercased)
            }
        }

        if !selectedTokens.isEmpty {
            for selectedToken in selectedTokens {
                let tokenNameLowercased = selectedToken.name.lowercased()
                meikFilter = meikFilter.filter { meik in
                    return meik.name.lowercased().contains(tokenNameLowercased) ||
                           meik.concentration.lowercased().contains(tokenNameLowercased) ||
                           meik.tags.joined(separator: " ").lowercased().contains(tokenNameLowercased) ||
                           meik.location.lowercased().contains(tokenNameLowercased) ||
                           meik.year.lowercased().contains(tokenNameLowercased)
                }
            }
        }

        return meikFilter
    }
    /**
     Sets the list of Meiks to the provided array.

     - Parameter meiks: An array of `Meik` objects to set as the data source for filtering and searching.

     - Note: This function updates the list of Meiks in the view model.

     */
    func set(meiks: [Meik]) {
        DispatchQueue.main.async {
            self.meiks = meiks
        }
    }
}
