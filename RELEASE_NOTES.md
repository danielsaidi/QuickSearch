# Release Notes


## 0.4

This version makes QuickSearch compile for all platforms.



## 0.3

This version makes QuickSearch use Swift 6.



## 0.2.1

This version adds support for strict concurrency.



## 0.2

This version makes the SDK support visionOS.

### ✨ Features

* `.quickSearch` flips the `disabled` parameter to `isEnabled`.
* `View` has a new `.searchable(text:quickSearch:...)` extension.
* `.quickSearch` and `.searchable` lets you pass in a focus binding.



## 0.1.4

### ✨ Features

* `QuickSearchViewModifier` has a new `disabled` parameter.

### 💡 Behavior Changes

* `QuickSearchViewModifier` now ignores `return` and `newLine`.
* `QuickSearchViewModifier` no longer applies `focusEffectDisabled`.



## 0.1.3

This patch makes the view modifier initializer public.



## 0.1.2

### 💡 Behavior Changes

* Pressing escape now resets the search field.
* Quick search now ignores any modified pressed.
* iOS & macOS now uses two different quick search approaches. 

### 🐛 Bug Fixes

* Backspace now works on both iOS and macOS.



## 0.1.1

### 🐛 Bug Fixes

* Backspace now works on iOS.



## 0.1

This is the first version of the QuickSearch library.

### ✨ Features

* `QuickSearchViewModifier` is a new modifier that can be used to enable quick search.
* `.quickSearch` is a View modifier shorthand that can be used to enable quick search.
