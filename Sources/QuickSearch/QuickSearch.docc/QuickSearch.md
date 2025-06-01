# ``QuickSearch``

QuickSearch is a SwiftUI SDK that lets you type into a searchable text field without having to focus on it.



## Overview

![Library logotype](Logo.png)

QuickSearch is a SwiftUI SDK that lets you type into a `.searchable` text field by just typing, without first having to focus on the text field. It's good for content-based views without any other text fields.

QuickSearch works on all Macs and iPads with a physical keyboard. The searchable text field can be used like normal on devices with no physical keyboard.

Unlike the native `.searchable` view modifier, QuickSearch doesn't show an input cursor to avoid draving attention to the search field. 



## Installation

QuickSearch can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/QuickSearch.git
```


## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## Getting started

All you have to do to make QuickSearch work, is to apply `quickSearch: true` to your searchable view modifier:

```swift
 struct ContentView: View {
 
     @State var query = ""
     @State var text = ""
 
     @FocusState var isTextFieldFocused
    
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

You can apply a `.quickSearch` view modifier to any superview, if you can't access `.searchable`, use custom focus bindings, etc.



## Repository

For more information, source code, etc., visit the [project repository](https://github.com/danielsaidi/QuickSearch).



## License

QuickSearch is available under the MIT license.



## Topics

### Essentials

- ``QuickSearchViewModifier``



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

