# CustomNavigationContent

A modifier to supply a custom navigation content view to your navigation bar.
This will automatically calculate the required space for your custom navigation bar content.

## License

&copy; Hans Terje Bakke, 2022

Do whatever you like with this, just don't blame the original author if it breaks something.

## Basic usage

Basic usage is

```swift
.customNavigationContent(opacity: $opacity) {
    Circle()
        .frame(width: 200, height: 200)
        .foregroundColor(.blue)
        .padding()
}
```

Omit the opacity binding to use the default, 1.0.

## List views

You can use this with list views to get the common nice transparent navigation bar when the list view is not scrolled, and the translucent thick material fading in as it scrolls up.

However, getting the content offset to calculate the opacity is currently tricky, as of iOS 16. An alternative is to use LazyVStack and ForEach instead of List.

In order to calculate the opacity to get the nice face-in effect when scrolling, you can apply trick with a supplied view. The trick is to apply this view and binding one(!) item inside the list. Basically:

```swift
@State var opacity: CGFloat = 0
...
List {
    Text("first list item").background(ListContentOffsetMonitor(opacity: $opacity)
    Text("second list item")
}
.customNavigationContent(opacity: $opacity) {
    Text("my custom navigation content")
}
```

See `Preview.swift` for a working example.

## Override navigation title

This only works with .inline navigation bar (not the .large style).
You can keep the inline title, blank it, or override it using for example

```swift
.toolbar {
    if vm.record.isCancelled {
        ToolbarItem(placement: .principal) {
            Text("loc.session.cancelled".localized.uppercased())
                .font(.headline)
                .foregroundColor(.red)
        }
    }
```    
