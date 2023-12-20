//
//  QuickSearchViewModifier.swift
//  QuickSearch
//
//  Created by Daniel Saidi on 2023-12-19.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS)
import SwiftUI

/**
 This modifier can be applied to a view hierarchy that has a
 `.searchable` text field and lets us type to search without
 first focusing on the text field.
 
 You can also apply the modifier with a `.quickSearch(text:)`
 view extension, which applies the modifier in a shorter way:
 
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
 
 When the app launches, the user can now start typing on the
 keyboard without first focusing on the search text field.
 */
public struct QuickSearchViewModifier: ViewModifier {
    
    /**
     Create a quick search view modifier.
     
     - Parameters:
       - text: The text binding to use.
     */
    public init(
        text: Binding<String>
    ) {
        self._text = text
    }
    
    @Binding
    private var text: String
    
    @FocusState
    private var isFocused
    
    public func body(content: Content) -> some View {
        #if os(iOS)
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

private extension QuickSearchViewModifier {
    
    func extend<Content: View>(
        content: @escaping () -> Content
    ) -> some View {
        content()
            .focused($isFocused)
            .focusEffectDisabled()
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
        guard press.modifiers.isEmpty else { return .ignored }
        let chars = press.characters
        switch press.key {
        case .delete: return handleKeyPressWithBackspace()
        case .escape: return handleKeyPressWithReset()
        default: break
        }
        switch chars {
        case .backspace: return handleKeyPressWithBackspace()
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
#endif
