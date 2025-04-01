//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-03-12.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import QuickSearch

struct ContentView: View {

    @FocusState
    private var isFocused

    @State
    var items = Array(0...10_000)
        .map { String("Item \($0)") }

    @State 
    private var query = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(itemsToDisplay, id: \.self) { item in
                    Button(item) {
                        print(item)
                    }
                }
            }
            .searchable(
                text: $query,
                quickSearch: true,
                isFocused: $isFocused,
                prompt: Text("Type to search")
            )
        }
    }
}

private extension ContentView {
    
    var itemsToDisplay: [String] {
        let val = query.trimmingCharacters(in: .whitespacesAndNewlines)
        if val.isEmpty { return items }
        return items.filter { $0.contains(query) }
    }
}

#Preview {
    ContentView()
}
