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

extension Measurement {
    var valueInMeters: Double {
        switch self {
        case .meters: return 1
        case .kilometers: return 1000
        case .feet: return 0.3048
        case .yards: return 0.9144
        case .miles: return 1609.344
        }
    }
}

struct ContentView: View {
    @State private var inputLength = ""
    @State private var inputMeasurement = Measurement.meters

    private var outputLength = 0.0
    @State private var outputMeasurement = Measurement.feet

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

                Section(header: Text("Converted Length")) {
                    HStack {
                        Text("\(outputLength, specifier: "%.2f")")
                        Text(outputMeasurement.rawValue)
                    }
                    Picker("Unit", selection: $outputMeasurement) {
                        ForEach(Measurement.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }

                Button(action: {}) {
                    HStack {
                        Image(systemName: "arrow.triangle.swap")
                        Text("Swap direction")
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
