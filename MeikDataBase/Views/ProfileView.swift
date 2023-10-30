//
//  ProfileView.swift
//  MeikDataBase
//
//  Created by Roberto Gonzales on 8/29/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct ProfileView: View {
    @State var viewModel = SaveMeik()
    @State var meikPrev = Meik(imageURL: 0, id: "", concentration: "Your Concentration", name: "Your Name", location: "Your Country",year:"year",email:"email",text:"Write bout you", tags: [""])
    @FirestoreQuery var items: [Meik]
    @State var uId: String
    @State private var image = UIImage()
    @State private var showSheet = false
    @State var imageViewModel = ImageViewModel()
    @State var saveBool: Bool = false
    @State private var selected: years = .one
    @State private var Concentration1: concentrations = .Default
    @State private var Concentration2: concentrations = .Default
    @State private var Concentration3: concentrations = .Default
    @State private var ConcenNum: Int = 1
    @State private var ICName: String = ""
    @State private var ICBool: Bool = false
    
    init(userId: String){
        self._items = FirestoreQuery(collectionPath: "meiks")
        uId = userId
        meikPrev.id = uId
    }
     
    var body: some View {
        VStack{
            MeikCardView(meik: meikPrev, isProfile: true).frame(idealHeight: .infinity)
            ScrollView{
                Form {
                    TextField("Name", text: $viewModel.name)
                    TextField("Where are you from?", text: $viewModel.location)
                    Group{
                        Picker("Concentrations",selection: $Concentration1){
                            ForEach(concentrations.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                        .foregroundColor(.gray)
                        if ConcenNum >= 2{
                            Picker("Concentrations",selection: $Concentration2){
                                ForEach(concentrations.allCases, id: \.self){
                                    Text($0.rawValue)
                                }
                            }
                            .foregroundColor(.gray)
                        }
                        if ConcenNum >= 3{
                            Picker("Concentrations",selection: $Concentration3){
                                ForEach(concentrations.allCases, id: \.self){
                                    Text($0.rawValue)
                                }
                            }
                            .foregroundColor(.gray)
                        }
                        if Concentration1 == .IC || Concentration2 == .IC || Concentration3 == .IC{
                            TextField("IC Name", text: $ICName)
                        }
                        Button("Add Concentration \(Image(systemName: "plus.circle"))"){
                            ConcenNum += 1
                        }
                    }
                    TextField("email", text: $viewModel.email)
                    TextField("tags, type 'remove' to erase all tags", text: $viewModel.tags)
                    TextField("Text", text: $viewModel.text)
                    Picker("",selection: $selected){
                        ForEach(years.allCases, id: \.self){
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .frame(height: 250)
                Button {
                    showSheet = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                        Text("Pick Photo").foregroundColor(.white)
                    }
                    .frame(width: 300,height: 30)
                }
                Button("Save") {
                    
                    if viewModel.name == ""{
                        viewModel.name = meikPrev.name
                    }
                    viewModel.concentration = Concentration1.rawValue
                    if viewModel.concentration == "Independent Concentration"{
                        viewModel.concentration = "IC (\(ICName))"
                    }
                    if viewModel.concentration == "--"{
                        viewModel.concentration = String(meikPrev.concentration.split(separator: " &").first ?? "--")
                    }
                    if ConcenNum >= 2 {
                        if Concentration2.rawValue != "--"{
                            if Concentration2.rawValue == "Independent Concentration"{
                                viewModel.concentration = viewModel.concentration + " & " + "IC (\(ICName))"
                            } else {
                                viewModel.concentration = viewModel.concentration + " & " + Concentration2.rawValue
                            }
//                            print("a")
                        }
                    }
                    if ConcenNum >= 3 {
                        if Concentration3.rawValue != "--"{
                            if Concentration3.rawValue == "Independent Concentration"{
                                viewModel.concentration = viewModel.concentration + " & " + "IC (\(ICName))"
                            } else {
                                viewModel.concentration = viewModel.concentration + " & " + Concentration3.rawValue
                            }
                        }
                    }
                    if viewModel.location == ""{
                        viewModel.location = meikPrev.location
                    }
                    if viewModel.email == ""{
                        viewModel.email = meikPrev.email
                    }
                    if viewModel.text == ""{
                        viewModel.text = meikPrev.text
                    }
                    if viewModel.tags == ""{
                        viewModel.tags = meikPrev.tags.joined(separator: ", ")
                    } else if viewModel.tags.lowercased() == "remove"{
                        viewModel.tags = ""
                    } else {
                        viewModel.tags = viewModel.tags + ", " + meikPrev.tags.joined(separator: ", ")
                    }
                    viewModel.year = selected.rawValue
                    imageViewModel.save(image: image)
                    viewModel.save()
                    meikPrev.concentration = viewModel.concentration
                    meikPrev.name = viewModel.name
                    meikPrev.location = viewModel.location
                    meikPrev.email = viewModel.email
                    meikPrev.year = viewModel.year
                    
                    let setWithoutDuplicates = Set(viewModel.tags.split(separator: ", ").map { String($0) })
                    let finalArray = Array(setWithoutDuplicates)
                    
                    meikPrev.tags = finalArray
                    saveBool.toggle()
                }
                Spacer()
                Button("Log Out"){
                    do{
                        try Auth.auth().signOut()
                    } catch {
                        print (error)
                    }
                }
                .tint(.red)
                .padding()
            }
        }
        .onAppear(){
            meikPrev.id = uId
            Task{
                var counter = 0
                while items.count == 0 {
                    do {
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                        counter = counter+1
//                        print("a")
                        if counter == 20 {
                            break
                        }
                    } catch {
                        // Handle the error, if needed
                        print("Task sleep error: \(error)")
                    }
                }
                if  counter != 20 {
                    let item = items.filter({$0.id == uId}).first
                    meikPrev.concentration = item?.concentration ?? ""
                    meikPrev.name = item?.name ?? ""
                    meikPrev.location = item?.location ?? ""
                    meikPrev.text = item?.text ?? ""
                    meikPrev.email = item?.email ?? ""
                    meikPrev.year = item?.year ?? ""
                    meikPrev.imageURL = item?.imageURL ?? 0
                    meikPrev.tags = item?.tags ?? [""]
                    for year in years.allCases {
                        if year.rawValue == item?.year{
                            selected = year
                        }
                    }
                }
            }
        }
//        ,onDismiss: {saveBool.toggle()}
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image).onDisappear(){
                viewModel.imageURL = meikPrev.imageURL+1
            }
        }
        .id(meikPrev.id)
        .id(saveBool)
        .id(viewModel.imageURL)
    }
}
enum years: String, CaseIterable{
    case one = "'27"
    case two = "'26"
    case tree = "'25"
    case four = "'24"
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userId: "Mw9mp1qTmlfwpKRrILbYcLFA39U2")
    }
}
