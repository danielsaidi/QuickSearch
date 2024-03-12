<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="QuickSearch Logo" title="QuickSearch" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/QuickSearch?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-5.9-orange.svg" alt="Swift 5.9" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <img src="https://img.shields.io/github/license/danielsaidi/QuickSearch" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" /></a>
    <a href="https://mastodon.social/@danielsaidi"><img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" /></a>
</p>



## About QuickSearch

QuickSearch is a SwiftUI SDK that lets you type into a `.searchable` text field without first having to focus on it, which is how many native utilty apps behave.

This is convenient, since `.searchable` text fields lack focus control and doesn't allow you to focus programmatically.



## Installation

QuickSearch can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/QuickSearch.git
```



## Getting Started

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
             .quickSearch(text: $query)
             .searchable(text: $query)
         }
     }
}
```

If you can add `.quickSearch` directly next to `.searchable`, you can use `.searchable(text:quickSearch:...)` instead. It is not as flexible as `.searchable`, but works well to apply basic `.searchable` capabilities.



## Documentation

The [online documentation][Documentation] has more information, articles, code examples, etc.



## Demo Application

The demo app lets you explore the library. To try it out, just open and run the `Demo` project.



## Support my work 

You can [sponsor me][Sponsors] on GitHub Sponsors or [reach out][Email] for paid support, to help support my [open-source projects][OpenSource].

Your support makes it possible for me to put more work into these projects and make them the best they can be.



## Contact

Feel free to reach out if you have questions or want to contribute in any way:

* Website: [danielsaidi.com][Website]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]
* Twitter: [@danielsaidi][Twitter]
* E-mail: [daniel.saidi@gmail.com][Email]



## License

QuickSearch is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com

[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[Twitter]: https://twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Documentation]: https://danielsaidi.github.io/QuicSearch
[Getting-Started]: https://danielsaidi.github.io/QuicSearch/documentation/quicsearch/getting-started

[License]: https://github.com/danielsaidi/QuickSearch/blob/master/LICENSE
