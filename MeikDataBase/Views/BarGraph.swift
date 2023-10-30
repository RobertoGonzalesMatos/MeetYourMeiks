import SwiftUI
import FirebaseFirestoreSwift
import Charts

struct BarGraph: View {
    @FirestoreQuery var items: [Dictionary<String, Int>]
    @State private var sortedConcen: [String] = []
    @State private var sortedMeik: [String] = []
    @State private var sortedYear: [String] = []
    @State private var useList: [String] = []
    @State private var lastTappedItem: String?
    @State private var max: Int = 0
    @State private var valEnum: Int = 0
    @State private var selectedDataOption: DataOption = .concentration
    @State private var anySelected: Bool = true

    enum DataOption: String, CaseIterable, Identifiable {
        case meik = "Meik"
        case year = "Year"
        case concentration = "Concentration"
        var id: String { self.rawValue }
    }

    init() {
        self._items = FirestoreQuery(collectionPath: "DataTaps")
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Data Recolection")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack {
                Text("Data for: ")
                Spacer()
                Picker("Data Option", selection: $selectedDataOption) {
                    ForEach(DataOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }.padding(.bottom)
            GroupBox {
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .bottom) {
                            ForEach(useList, id: \.self) { item in
                                let isTapped = lastTappedItem == item
                                let value = CGFloat(items[valEnum][item] ?? 0)
                                let heightPercentage = (value / CGFloat(max)) * 200
                                VStack {
                                    HStack() {
                                        Rectangle()
                                            .fill(Color.blue)
                                            .font(.caption)
                                            .opacity(anySelected ? 1 : (isTapped ? 1 : 0.5))
                                            .cornerRadius(5)
                                            .frame(width: 35, height: heightPercentage)
                                            .onTapGesture {
                                                withAnimation(.easeInOut) {
                                                    if lastTappedItem == item {
                                                        lastTappedItem = nil // Clear the tapped item
                                                    } else {
                                                        lastTappedItem = item // Set the tapped item
                                                    }
                                                    anySelected = isTapped
                                                }
                                            }
                                        if isTapped {
                                            Text("\(Int(value))")
                                                .font(.subheadline)
                                            Spacer()
                                        }
                                    }
                                    Text(isTapped ? item : String(item.prefix(4) + "...")).padding(.trailing, 5).frame(maxWidth: 150, maxHeight: 50)
                                }
                            }
                        }
                    }.frame(width: 280).background(YAxisLineView())
                    VStack() {
                        let med = Int((max) / 2)
                        Text(String(max)).position(y: -24).font(.caption)
                        Text(String(med)).position(y: 3).font(.caption)
                        Text("0").position(y: 30).font(.caption)
                    }.frame(width: 30, height: 210)
                }.frame(width: 270, height: 270)
                .padding(.leading)
            }.groupBoxStyle(RoundedGroupBoxStyle())
            Spacer()
            .onAppear() {
                Task {
                    var counter = 0
                    while items.count == 0 {
                        do {
                            try await Task.sleep(nanoseconds: 1_000_000_000)
                            counter = counter + 1
                            if counter == 20 {
                                break
                            }
                        } catch {
                            print("Task sleep error: \(error)")
                        }
                    }
                    if counter != 20 {
                        sortedConcen = items[0].keys.sorted(by: { (key1, key2) -> Bool in
                            return (items[0][key1]!) > (items[0][key2]!)
                        })
                        sortedMeik = items[1].keys.sorted(by: { (key1, key2) -> Bool in
                            return (items[1][key1]!) > (items[1][key2]!)
                        })
                        sortedYear = items[2].keys.sorted(by: { (key1, key2) -> Bool in
                            return (items[2][key1]!) > (items[2][key2]!)
                        })
                        useList = sortedConcen
                    }
                    self.max = items.first?[sortedConcen.first!] ?? 1
                }
            }
            .onChange(of: selectedDataOption) { _ in
                useList = dicts()
            }
        }
        .padding()
        .cornerRadius(20)
    }
    func dicts() -> [String] {
        switch selectedDataOption {
        case .concentration:
            valEnum = 0
            self.max = items[valEnum][sortedConcen.first!] ?? 1
            return sortedConcen
        case .meik:
            valEnum = 1
            self.max = items[valEnum][sortedMeik.first!] ?? 1
            return sortedMeik // Use safe subscript to handle possible out-of-bounds access
        case .year:
            valEnum = 2
            self.max = items[valEnum][sortedYear.first!] ?? 1
            return sortedYear // Use safe subscript to handle possible out-of-bounds access
        }
    }
}

struct RoundedGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        GroupBox(label: configuration.label) {
            configuration.content
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.blue, lineWidth: 2)
        )
    }
}

struct YAxisLineView: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 290, height: 1) // Adjust the size as needed
                .foregroundColor(.gray)
            Spacer()
            Rectangle()
                .frame(width: 290, height: 1) // Adjust the size as needed
                .foregroundColor(.gray)
                .offset(y:13)
            Spacer()
            Rectangle()
                .frame(width: 290, height: 1) // Adjust the size as needed
                .foregroundColor(.gray)
                .offset(y:27)
            Spacer()
        }
    }
}
struct BarGraph_Previews: PreviewProvider {
    static var previews: some View {
        BarGraph()
    }
}

