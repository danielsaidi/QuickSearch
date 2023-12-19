//
//  String+Types.swift
//  QuickSearch
//
//  Created by Daniel Saidi on 2023-12-19.
//

#if os(iOS) || os(macOS)
import SwiftUI

/**
 This modifier can be applied to a view hierarchy that has a
 `.searchable` view modifier applied within it, and lets you
 type directly without first focusing on the search field.
 
 You can apply this modifier with the `.quickSearch` shorthand:
 
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
 
 When the app launches, the user can now start typing on the
 keyboard without first focusing on the search text field.
 */
public struct QuickSearchViewModifier: ViewModifier {
    
    /**
     Create a quick search view modifier.
     
     - Parameters:
       - text: The text binding to use.
     */
    init(
        text: Binding<String>
    ) {
        self._text = text
    }
    
    @Binding
    private var text: String
    
    @FocusState
    private var isFocused
    
    public func body(content: Content) -> some View {
        content
            .background(
                TextField("", text: $text)
                    .focused($isFocused)
                    .onKeyPress {
                        switch $0.characters {
                        case .backspace: return handleBackspace()
                        case .space: return handleAppending(.space)
                        case .tab: return .ignored
                        default: return handleAppending($0.characters)
                        }
                    }
                    .onChange(of: text, {
                        guard $1.isEmpty else { return }
                        isFocused = true
                    })
                    .onAppear {
                        isFocused = true
                    }
                    .opacity(0.01)
                    .offset(x: -10_000, y: -10_000)
            )
    }
}

extension QuickSearchViewModifier {
    
    func handleAppending(
        _ char: String
    ) -> KeyPress.Result {
        performAsyncToMakeRepeatPressWork {
            text.append(char)
        }
    }
    
    func handleBackspace() -> KeyPress.Result {
        if text.isEmpty { return .ignored }
        return performAsyncToMakeRepeatPressWork {
            text.removeLast()
        }
    }
    
    func performAsyncToMakeRepeatPressWork(
        action: @escaping () -> Void
    ) -> KeyPress.Result {
        DispatchQueue.main.async(execute: action)
        return .handled
    }
}

public extension View {
    
    /**
     Create a quick search view modifier.
     
     - Parameters:
       - text: The text binding to use.
     */
    func quickSearch(
        text: Binding<String>
    ) -> some View {
        self.modifier(
            QuickSearchViewModifier(text: text)
        )
    }
}
#endif
