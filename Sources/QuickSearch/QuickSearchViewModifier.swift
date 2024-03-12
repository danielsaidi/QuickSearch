//
//  QuickSearchViewModifier.swift
//  QuickSearch
//
//  Created by Daniel Saidi on 2023-12-19.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This modifier can be applied to a view hierarchy that has a
 `.searchable` text field, to enable quick search.
 
 Quick search lets users type to search without first having
 to focus on the text field.
 
 You can also apply the modifier with a `.quickSearch(text:)`
 view modifier, which applies this modifier in a shorter way:
 
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
 
 If you can add `.quickSearch` directly next to `.searchable`,
 you can use `.searchable(text:quickSearch:...)` instead. It
 is not as flexible as `.searchable`, but works well to just
 apply basic `.searchable` capabilities.
 */
public struct QuickSearchViewModifier: ViewModifier {
    
    /// Create a quick search view modifier.
    ///
    /// - Parameters:
    ///   - text: The text binding to use.
    ///   - enabled: Whether or not quick search is enabled, by default `true`.
    public init(
        text: Binding<String>,
        enabled: Bool = true
    ) {
        self._text = text
        self.enabled = enabled
    }
    
    @Binding
    private var text: String
    
    private var enabled: Bool
    
    @FocusState
    private var isFocused
    
    public func body(content: Content) -> some View {
        #if os(iOS) || os(visionOS)
        content
            .background(
                extend {
                    TextField("", text: $text)
                        .opacity(0.01)
                        .offset(x: -10_000, y: -10_000)
                }
            )
        #else
        extend {
            content
        }
        #endif
    }
}

public extension View {
    
    /// This view modifier can be applied to a view that has
    /// a `.searchable` modifier, to enable quick search.
    ///
    /// See ``QuickSearchViewModifier`` for more information.
    func quickSearch(
        text: Binding<String>,
        enabled: Bool = true
    ) -> some View {
        self.modifier(
            QuickSearchViewModifier(text: text, enabled: enabled)
        )
    }
    
    /// Apply a `.searchable` modifier, then `.quickSearch`.
    ///
    /// See ``QuickSearchViewModifier`` for more information.
    func searchable(
        text: Binding<String>,
        quickSearch: Bool,
        placement: SearchFieldPlacement = .automatic,
        prompt: Text? = nil
    ) -> some View {
        self.searchable(text: text, placement: placement, prompt: prompt)
            .quickSearch(text: text, enabled: quickSearch)
    }
}

private extension QuickSearchViewModifier {
    
    func extend<Content: View>(
        content: @escaping () -> Content
    ) -> some View {
        content()
            .focused($isFocused)
            .onKeyPress(action: handleKeyPress)
            .onChange(of: text) {
                guard $1.isEmpty else { return }
                isFocused = true
            }
            .onAppear { isFocused = true }
    }
    
    func handleKeyPress(
        _ press: KeyPress
    ) -> KeyPress.Result {
        guard enabled else { return .ignored }
        guard press.modifiers.isEmpty else { return .ignored }
        let chars = press.characters
        switch press.key {
        case .delete: return handleKeyPressWithBackspace()
        case .escape: return handleKeyPressWithReset()
        case .return: return .ignored
        default: break
        }
        switch chars {
        case .backspace: return handleKeyPressWithBackspace()
        case .newLine: return .ignored
        case .space: return handleKeyPressByAppending(.space)
        case .tab: return .ignored
        default: return handleKeyPressByAppending(chars)
        }
    }
    
    func handleKeyPressByAppending(
        _ char: String
    ) -> KeyPress.Result {
        performAsyncToMakeRepeatPressWork {
            text.append(char)
        }
    }
    
    func handleKeyPressWithBackspace() -> KeyPress.Result {
        if text.isEmpty { return .ignored }
        return performAsyncToMakeRepeatPressWork {
            if text.isEmpty { return }
            text.removeLast()
        }
    }
    
    func handleKeyPressWithReset() -> KeyPress.Result {
        if text.isEmpty { return .ignored }
        text = ""
        return .handled
    }
    
    func performAsyncToMakeRepeatPressWork(
        action: @escaping () -> Void
    ) -> KeyPress.Result {
        DispatchQueue.main.async(execute: action)
        return .handled
    }
}
