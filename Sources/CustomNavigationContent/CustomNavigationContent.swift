import SwiftUI

private struct NavBarContentHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

private struct CustomNavigationContentModifier<NavContent: View>: ViewModifier {

    private let navigationBarContent: NavContent
    @Binding private var opacity: CGFloat
    
    @State private var navBarHeight: CGFloat = 0

    public init(opacity: Binding<CGFloat>, @ViewBuilder content: @escaping () -> NavContent) {
        self._opacity = opacity
        self.navigationBarContent = content()
    }
    
    public func body(content: Content) -> some View {
        content
        .safeAreaInset(edge: .top) {
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    // Navigation content
                    Color.clear
                        .overlay(alignment: .bottom) {
                            navigationBarContent
                                .background(
                                    GeometryReader { proxy in
                                        Color.clear
                                            .preference(key: NavBarContentHeightPreferenceKey.self, value: proxy.size.height)
                                            .onPreferenceChange(NavBarContentHeightPreferenceKey.self) { height in
                                                self.navBarHeight = height
                                            }
                                    }
                                )
                        }
                }
                .padding(.bottom, 5)
                .background(.ultraThickMaterial.opacity(opacity))
                Divider().opacity(opacity)
            }
            .frame(height: navBarHeight)
            .frame(maxWidth: .infinity)
        }
        
            .navigationTitle("loc.session.title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
    }
    
}

extension View {
    /// Attach this modifier to any view and supply a custom navigation content view.
    /// You can supply your own opacity as a binding.
    /// Tracking a list view's content offset is currently tricky (as of iOS 16.1). One way to do it is to add a state variable for the opacity attach this background to any (one!) view inside the list, like so:
    ///
    ///     @State var opacity: CGFloat = 0
    ///     ...
    ///     List {
    ///         Text("first item").background(ListContentOffsetMonitor(opacity: $opacity))
    ///         Text("second item")
    ///     }
    ///     .customnavigationContent(opacity: $opacity) { Text("custom nav content") }
    public func customNavigationContent<NavContent: View>(opacity: Binding<CGFloat> = .constant(1.0), @ViewBuilder content: @escaping () -> NavContent) -> some View {
        return self.modifier(CustomNavigationContentModifier(opacity: opacity, content: content))
    }
}
