// Add to Xcode Library

import SwiftUI

@available(iOS 16.0, *)
public struct ModifierLibrary: LibraryContentProvider {
    @LibraryContentBuilder
    public func modifiers(base: any View) -> [LibraryItem] {
        LibraryItem(base.customNavigationContent(opacity: .constant(1.0)) { Text("Hello, world!") }, category: .layout)
    }
}
