//
//  QuickSearchViewModifier.swift
//  QuickSearch
//
//  Created by Daniel Saidi on 2023-12-19.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view modifier can be applied to any views that have
/// a `.searchable` text field, to enable quick search.
///
/// Quick search lets users type into any text field without
/// first having to focus on the text field. Just launch the
/// app and load the view, and you can start typing.
///
/// You can also enable quick search with the view modifiers
/// `.quickSearch(...)` and `searchable(...quickSearch:)`.
@MainActor
public struct QuickSearchViewModifier: ViewModifier {
    
    /// Create a quick search view modifier.
    ///
    /// - Parameters:
    ///   - text: The text binding to use.
    ///   - isEnabled: Whether or not quick search is enabled, by default `true`.
    ///   - isFocused: A custom focused binding, if any.
    public init(
        text: Binding<String>,
        isEnabled: Bool = true,
        isFocused: FocusState<Bool>.Binding? = nil
    ) {
        self._text = text
        self.isEnabled = isEnabled
        self.isCustomFocused = isFocused
    }
    
    @Binding
    private var text: String
    
    private var isEnabled: Bool
    private var isCustomFocused: FocusState<Bool>.Binding?
    
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

@MainActor
public extension View {
    
    /// This view modifier can be applied to a view that has
    /// a `.searchable` modifier, to enable quick search.
    ///
    /// See ``QuickSearchViewModifier`` for more information.
    func quickSearch(
        text: Binding<String>,
        isEnabled: Bool = true,
        isFocused: FocusState<Bool>.Binding? = nil
    ) -> some View {
        self.modifier(
            QuickSearchViewModifier(
                text: text,
                isEnabled: isEnabled,
                isFocused: isFocused
            )
        )
    }
    
    /// Apply a `.searchable` modifier, then `.quickSearch`.
    ///
    /// See ``QuickSearchViewModifier`` for more information.
    func searchable(
        text: Binding<String>,
        quickSearch: Bool,
        isFocused: FocusState<Bool>.Binding? = nil,
        placement: SearchFieldPlacement = .automatic,
        prompt: Text? = nil
    ) -> some View {
        self.searchable(text: text, placement: placement, prompt: prompt)
            .quickSearch(
                text: text,
                isEnabled: quickSearch,
                isFocused: isFocused
            )
    }
}

private extension QuickSearchViewModifier {

    func extend<Content: View>(
        content: @escaping () -> Content
    ) -> some View {
        content()
            .focused(isCustomFocused ?? $isFocused)
            .onKeyPress(action: handleKeyPress)
            .onChange(of: text) {
                guard $1.isEmpty else { return }
                isFocused = true
            }
            .onAppear {
                isFocused = true
                isCustomFocused?.wrappedValue = true
            }
    }
    
    func handleKeyPress(
        _ press: KeyPress
    ) -> KeyPress.Result {
        guard isEnabled else { return .ignored }
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
        DispatchQueue.main.async {
            action()
        }
        return .handled
    }
}
