//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-03-12.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let items = Array(0...10_000).map { String($0) }
    
    @State private var query = ""
    
    @AppStorage("isEnabled") private var isEnabled = true
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(itemsToDisplay, id: \.self) {
                    Text($0)
                }
            }
            .searchable(
                text: $query,
                quickSearch: true,
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
