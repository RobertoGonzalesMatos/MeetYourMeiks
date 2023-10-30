import SwiftUI

struct MeikCardView: View {
    let meik: Meik
    @State private var isExpanded = false
    @State private var backDegree: Double = 0.0
    @State private var frontDegree: Double = -90.0
    @State private var isFlipped = false
    let durationAndDelay: CGFloat = 0.3
    @ObservedObject private var viewModel = ImageViewModel()
    @State private var downloadedImage = UIImage(systemName: "person.circle")
    @State private var isProfile: Bool

    init(meik: Meik, isProfile: Bool) {
        self.meik = meik
        self.isProfile = isProfile
    }

    var body: some View {
        VStack {
            cardContent
                .background(Color(.tertiarySystemBackground))
                .cornerRadius(15)
                .shadow(radius: 5)
                .onTapGesture {
                    if !isProfile && !isExpanded {
                        viewModel.saveData(Meik: self.meik)
                    }
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
        }
    }

    private var cardContent: some View {
        VStack(alignment: .leading, spacing: 10) {
            cardImages
                .gesture(DragGesture(minimumDistance: 50).onEnded { _ in
                    if isExpanded { flipCard() }
                })
            cardDetails
                .padding(.horizontal, 15)
        }
    }

    private var cardImages: some View {
        ZStack(alignment: .center) {
            Text(meik.text)
                .padding()
                .frame(maxHeight: isExpanded ? .infinity : 150)
                .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))

            Image(uiImage: downloadedImage!)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 450, maxHeight: isExpanded ? .infinity : 150)
                .clipped()
                .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0, y: 1, z: 0))
                .onAppear() {
                    loadImage()
                }
        }
    }

    private var cardDetails: some View {
        VStack {
            HStack{
                Text(meik.name)
                    .font(.title2)
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.primary)
                Spacer()
                Text(meik.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            HStack {
                Text(meik.concentration)
                    .font(.system(size: 15))
                    .frame(maxWidth: 200, maxHeight: isExpanded ? 60 : 25, alignment: .leading)
                    .foregroundColor(.gray)
                Spacer()
                Text(meik.year)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 1)

            HStack {
                Text(meik.email)
                    .font(.system(size: 15))
                    .onTapGesture {
                        openEmail()
                    }
                    .foregroundColor(.gray)

                Spacer()
            }
            .frame(height: 10)

            TagScrollView(tags: meik.tags, isExpanded: $isExpanded)
                .padding(.bottom)
        }
    }

    private func flipCard() {
        isFlipped.toggle()

        withAnimation(.linear(duration: durationAndDelay)) {
            backDegree = isFlipped ? 90 : 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + durationAndDelay) {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = isFlipped ? 0 : -90
            }
        }
    }

    private func loadImage() {
        Task {
            while meik.id.isEmpty {
                do {
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                } catch {
                    print("Task sleep error: \(error)")
                }
            }
            viewModel.retrieve(path: "images/\(meik.id).jpg", version: meik.imageURL) { uiImage in
                self.downloadedImage = uiImage
            }
        }
    }

    private func openEmail() {
        if let mailURL = URL(string: "mailto:\(meik.email)") {
            UIApplication.shared.open(mailURL)
        }
    }
}

struct MeikCardView_Previews: PreviewProvider {
    static var previews: some View {
        MeikCardView(meik: Meik.preview(), isProfile: true)
            .padding()
    }
}

extension Text {
    func TagOverlay(color: Color, foregroundColor: Color = .white) -> some View {
        self.padding(7)
            .padding(.horizontal, 5)
            .background(Capsule().fill(color))
            .foregroundColor(foregroundColor)
    }
}

struct TagScrollView: View {
    var tags: [String]
    @Binding var isExpanded: Bool

    var body: some View {
        ScrollView(.horizontal) {
            if isExpanded {
                HStack(spacing: 8) {
                    ForEach(0..<tags.count / 3 + (tags.count % 3 == 0 ? 0 : 1), id: \.self) { chunkIndex in
                        VStack(spacing: 4) {
                            ForEach(chunkIndex * 3..<min((chunkIndex + 1) * 3, tags.count), id: \.self) { tagIndex in
                                Text(tags[tagIndex]).TagOverlay(color: .black.opacity(0.8))
                            }
                        }
                    }
                }
                .padding(8)
            } else {
                HStack {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag).TagOverlay(color: .black.opacity(0.8))
                    }
                }
                .padding()
            }
        }
        .padding(.bottom)
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
    }
}
