# ``QuickSearch``

QuickSearch is a SwiftUI SDK that lets you type into a searchable text field without having to focus on it.



## Overview

![Library logotype](Logo.png)

QuickSearch is a SwiftUI SDK that lets you type into a `.searchable` text field without first having to focus on it, which is how many native utilty apps behave.

This is convenient, since `.searchable` text fields lack focus control and doesn't allow you to focus programmatically.




## Installation

QuickSearch can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/QuickSearch.git
```



## Getting started

All you have to do to make QuickSearch work, is to apply a `.quickSearch` view modifier after `.searchable`:

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
             .searchable(text: $query)
             .quickSearch(text: $query)
         }
     }
}
```

If you can add `.quickSearch` directly next to `.searchable`, you can use `.searchable(text:quickSearch:...)` instead. It is not as flexible as `.searchable`, but works well to apply basic `.searchable` capabilities.



## Repository

For more information, source code, etc., visit the [project repository](https://github.com/danielsaidi/QuickSearch).



## License

QuickSearch is available under the MIT license.



## Topics

### Essentials

- ``QuickSearchViewModifier``
