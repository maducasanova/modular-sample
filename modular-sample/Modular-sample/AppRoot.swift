//
//  AppRoot.swift
//  Modular-sample
//
//  Created by Maria Eduarda on 01/10/24.
//

import SwiftUI

struct AppRoot: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    AppRoot()
}
