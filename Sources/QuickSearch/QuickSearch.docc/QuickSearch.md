# ``QuickSearch``

QuickSearch is a SwiftUI SDK that lets you type into a searchable text field without having to focus on it.



## Overview

![Library logotype](Logo.png)

QuickSearch is a SwiftUI SDK that lets you type into a `.searchable` text field by just typing, without first having to focus on the text field.

Unlike the native `.searchable(text: $query, isPresented: .constant(true))` view modifier, QuickSearch doesn't show the input cursor to avoid draving attention to the search field. 



## Installation

QuickSearch can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/QuickSearch.git
```



## Getting started

All you have to do to make QuickSearch work, is to apply `quickSearch: true` to `.searchable`:

```swift
 struct ContentView: View {
 
     @State
     var query = ""
     
     @State
     var text = ""
 
     @FocusState
     var isTextFieldFocused
    
     var body: some View {
         NavigationStack {
             VStack {
                TextField("Type here...", text: $text)
             }
             .searchable(text: $query, quickSearch: true)
         }
     }
}
```

You can also apply the `.quickSearch` view modifier, to any superview, if you can't access `.searchable`.

If you can add `.quickSearch` directly next to `.searchable`, you can use `.searchable(text:quickSearch:...)` instead. It is not as flexible as `.searchable`, but works well to apply basic `.searchable` capabilities.



## Repository

For more information, source code, etc., visit the [project repository](https://github.com/danielsaidi/QuickSearch).



## License

QuickSearch is available under the MIT license.



## Topics

### Essentials

- ``QuickSearchViewModifier``
