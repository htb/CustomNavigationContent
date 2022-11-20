// Calculate the opacity for the navigation bar background as we scroll a list up.
// The monitor must be attached to one of the items that scrolls with the list view,
// e.g. like this:
//
//  listViewItem.background(ListContentOffsetMonitor(opactiy: $opacity)
//

import SwiftUI

public struct ListContentOffsetMonitor: View {
    @Binding private var opacity: CGFloat
    @State private var ypos: CGFloat = 0 { didSet { opacity = -min(0, max(-span, ypos)) / span } }
    @State private var initialPos: CGFloat? = nil

    // How far from list top to full opacity
    private let span: CGFloat = 20

    public init(opacity: Binding<CGFloat>) {
        self._opacity = opacity
    }
    
    public var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }

    private func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            let y = geometry.frame(in: .global).minY
            if let initialPos {
                ypos = y - initialPos
            } else {
                initialPos = y
                ypos = 0
            }
        }

        return Rectangle().fill(Color.clear)
    }
}

