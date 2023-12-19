//
//  View+QuickSearch.swift
//  QuickSearch
//
//  Created by Daniel Saidi on 2023-12-19.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS)
import SwiftUI

public extension View {
    
    /**
     This modifier can be applied to a view hierarchy with a
     `.searchable` text field, and makes it possible to type
     to search without first focusing on the text field.
     
     See ``QuickSearchViewModifier`` for more information on
     how to apply the modifier.
     
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
