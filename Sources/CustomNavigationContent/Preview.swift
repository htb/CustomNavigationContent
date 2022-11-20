import SwiftUI

struct TestView: View {
    let maxValue: Int = 50
    let hueRange: (CGFloat, CGFloat) = (0.0, 0.5)

    @State var opacity: CGFloat = 0

    var body: some View {
        List {
            ForEach(0...maxValue, id: \.self) { item in
                let p = CGFloat(item) / CGFloat(maxValue)
                let hue = hueRange.0 + (hueRange.1 - hueRange.0) * p
                let view = Text(item.description)
                    .listRowBackground(Color(uiColor: UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)))
                
                    Group {
                        if item == 0 {
                            view.background(ListContentOffsetMonitor(opacity: $opacity))
                        } else {
                            view
                        }
                    }
            }
        }
        .customNavigationContent(opacity: $opacity) {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(.blue)
                .padding()
        }
    }
}

struct CustomNavigationContent_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            TestView()
        }
    }
}
