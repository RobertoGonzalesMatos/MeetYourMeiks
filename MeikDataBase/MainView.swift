/**
 A SwiftUI view representing the main content of the MeikDataBase app.

 The `MainView` displays different views based on the user's authentication status.

 If the user is signed in and has a non-empty user ID, it displays the "accountView."
 If the user is not signed in, it displays the "LogInView."

 The "accountView" is a TabView containing multiple views: TaskListView, ProfileView, and BarGraph.

 - Note: This view relies on the `MainViewModel` to manage the user's authentication status.

 - SeeAlso: `MainViewModel`, `LogInView`, `SearchTokenMealListView`, `ProfileView`, `BarGraph`

 - Author: Roberto Gonzales
 - Date: 8/28/23
 */
import SwiftUI
import FirebaseAuth

struct MainView: View {
    @StateObject var viewModel = MainViewModel()

    var body: some View {
        if viewModel.isSignedIn && !viewModel.currentUserId.isEmpty {
            if viewModel.isAMeikLeader{
                accountView
            }else if(viewModel.isAMeik){
                meikView
            }else{
                VStack{
                    SearchTokenMeikListView()
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.background)
                            .frame(width: 400,height: 50)
                            .opacity(0.9)
                        Button{
                            do{
                                try Auth.auth().signOut()
                            } catch {
                                print (error)
                            }
                        }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 15).backgroundStyle(.red)
                                Text("Log Out").foregroundColor(.white)
                            }
                            .frame(width: 300,height: 30)
                        }
                        .tint(.red)
                        .padding()                }}
            }
            
        } else {
            
            LogInView()
        }
    }
    @ViewBuilder
    var accountView: some View {
        TabView() {
            SearchTokenMeikListView()
                .tabItem {
                    Label("Tasks", systemImage: "house")
                }
            ProfileView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            BarGraph()
                .tabItem {
                    Label("Analytics", systemImage: "chart.xyaxis.line")
                }
        }
    }
    @ViewBuilder
    var meikView: some View {
        TabView() {
            SearchTokenMeikListView()
                .tabItem {
                    Label("Tasks", systemImage: "house")
                }
            ProfileView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
