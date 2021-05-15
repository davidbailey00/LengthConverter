//
//  ContentView.swift
//  LengthConverter
//
//  Created by David Bailey on 15/05/2021.
//

import SwiftUI

enum Measurement: String, CaseIterable, Identifiable {
    case meters
    case kilometers
    case feet
    case yards
    case miles

    var id: String { self.rawValue }
}

struct ContentView: View {
    @State private var inputLength = ""
    @State private var inputMeasurement = Measurement.meters

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Original Length")) {
                    HStack {
                        TextField("Length", text: $inputLength)
                            .keyboardType(.decimalPad)
                        Text(inputMeasurement.rawValue)
                    }
                    Picker("Unit", selection: $inputMeasurement) {
                        ForEach(Measurement.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
            }
            .navigationBarTitle("Length Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
